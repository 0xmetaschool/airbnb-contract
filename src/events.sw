library;

use ::data_structures::property_info::PropertyInfo;

pub struct PropertyListed {

    pub owner: Identity,
    pub property_info: PropertyInfo,
    pub property_id: u64,
}
pub struct PropertyUnlisted {
    pub property_id: u64,
}

pub struct BookingSuccessful {

    pub booking_id: u64,
    pub bookedBy: Identity,
    pub bookingFrom: u64,
    pub bookingTo: u64,
}
