library;

use ::data_structures::property_info::PropertyInfo;

pub struct PropertyListed {

    owner: Identity,
    property_info: PropertyInfo,
    property_id: u64,
}
pub struct PropertyUnlisted {
    property_id: u64,
}

pub struct BookingSuccessful {

    booking_id: u64,
    bookedBy: Identity,
    bookingFrom: u64,
    bookingTo: u64,
}
