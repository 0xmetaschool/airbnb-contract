contract;

mod data_structures;
mod errors;
mod events;
mod interface;

use ::data_structures::{
    property::Property,
    property_info::PropertyInfo,
    booking_state::BookingState,
    booking_info::BookingInfo,
    property_state::PropertyState,
    property_image::PropertyImage,
    booking::Booking,
};
use ::errors::{BookingError, CreationError, UserError};
use ::events::{
    PropertyListed,
    PropertyUnlisted,
    BookingSuccessful,
};
use std::{
    auth::msg_sender,
    block::height,
    context::msg_amount,
    hash::Hash,
};
use ::interface::{HotelBooking, Info};

storage {

    booking_history: StorageMap<(Identity, u64), u64> = StorageMap {},

    property_availability: StorageMap<(u64, u64, u64), bool> = StorageMap {},


    property_info: StorageMap<u64, PropertyInfo> = StorageMap {},

    property_images: StorageMap<u64, PropertyImage> = StorageMap {},

    booking_info: StorageMap<u64, BookingInfo> = StorageMap {},


    total_property_listed: u64 = 0,

    total_booking: u64 = 0,
}

impl HotelBooking for Contract {

    #[storage(read, write)]
    fn list_property(pincode: u64, image1: b256, image2: b256) {
        let owner = msg_sender().unwrap();

        let property_info = PropertyInfo::new(owner, pincode);
        let property_images = PropertyImage::new(image1, image2);

        storage.total_property_listed.write(storage.total_property_listed.read() + 1);
        storage.property_info.insert(storage.total_property_listed.read(), property_info);
        
        // Store the image references
        storage.property_images.insert(storage.total_property_listed.read(), property_images);

        // We have changed the state by adding a new data structure therefore we log it
        log(PropertyListed {
            owner,
            property_info,
            property_id: storage.total_property_listed.read(),
        });
    }

    #[storage(read, write)]
    fn unlist_property(property_id: u64) {

        // Retrieve the property in order to check its data / update it
        let mut property_info = storage.property_info.get(property_id).try_read().unwrap();

        // Only the creator (author) of the property can unlist it
        require(property_info.owner == msg_sender().unwrap(), UserError::UnauthorizedUser);

        // Mark the property as unlisted
        property_info.listed = PropertyState::Unlisted;

        storage.property_info.insert(property_id, property_info);

        // We have updated the state of a property therefore we must log it
        log(PropertyUnlisted { property_id });
    }

    #[storage(read, write)]
    fn book(property_id: u64, bookingFrom: u64, bookingTo: u64) {
        //Booking date check
        require(bookingFrom >= height().as_u64(), CreationError::BookingDateMustBeInFuture );
        require(bookingTo >= height().as_u64(), CreationError::BookingDateMustBeInFuture );
        
        // Retrieve the property in order to check its data / update it
        let mut property_info = storage.property_info.get(property_id).try_read().unwrap();
        let mut bookedBy = msg_sender().unwrap();


        //check if the property is listed or not
        require(property_info.listed != PropertyState::Unlisted, BookingError::PropertyNotFound);
        //check if the property is booked or available
        require(property_info.available != BookingState::Booked, UserError::PropertyNotAvailable);
        
        //Create the booking info
        let booking_info = BookingInfo::new(bookedBy, bookingFrom, bookingTo, property_id);

        storage.total_booking.write(storage.total_booking.read() + 1);
        storage.booking_info.insert(storage.total_booking.read(), booking_info);
        storage.booking_history.insert((bookedBy, property_id), storage.total_booking.read());
        storage.property_availability.insert((property_id, bookingFrom, bookingTo), false);

        //Mark property as booked
        property_info.available = BookingState::Booked;

        storage.property_info.insert(property_id, property_info);

        // We have updated the state of a booking therefore we must log it
        log(BookingSuccessful { 
            booking_id: storage.total_booking.read(), 
            bookedBy, 
            bookingFrom, 
            bookingTo });
    }

}

impl Info for Contract {

    #[storage(read)]
    fn booking_info(booking_id: u64) -> Option<BookingInfo> {
        storage.booking_info.get(booking_id).try_read()
    }

    #[storage(read)]
    fn property_info(property_id: u64) -> Option<PropertyInfo> {
        storage.property_info.get(property_id).try_read()
    }

    #[storage(read)]
    fn get_property_images(property_id: u64) -> Option<PropertyImage> {
        storage.property_images.get(property_id).try_read()
    }

    #[storage(read)]
    fn total_property_listed() -> u64 {
        storage.total_property_listed.read()
    }

    #[storage(read)]
    fn total_booking() -> u64 {
        storage.total_booking.read()
    }
}
