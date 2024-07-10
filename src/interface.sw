library;

use ::data_structures::{
    booking_info::BookingInfo,
    property_info::PropertyInfo,
    property_image::PropertyImage,
};

abi HotelBooking {
    
    #[storage(read, write)]
    fn list_property(pincode: u64,image1: b256, image2: b256);
   
    #[storage(read, write)]
    fn unlist_property(property_id: u64);

    #[storage(read, write)]
    fn book(property_id: u64, bookingFrom: u64, bookingTo: u64);
}

abi Info {

    #[storage(read)]
    fn booking_info(booking_id: u64) -> Option<BookingInfo> ;

    #[storage(read)]
    fn property_info(property_id: u64) -> Option<PropertyInfo>;

    #[storage(read)]
    fn get_property_images(property_id: u64) -> Option<PropertyImage>;

    #[storage(read)]
    fn total_property_listed() -> u64;

    #[storage(read)]
    fn total_booking() -> u64;

}