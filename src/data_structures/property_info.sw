library;

use ::data_structures::property_state::PropertyState;
use ::data_structures::booking_state::BookingState;


pub struct PropertyInfo {
    /// The user who has listed the Property
    owner: Identity,
    ///Pincode of the property
    pincode: u64,
    ///Listed or not
    listed: PropertyState,
    ///Availability
    available: BookingState,    
}

impl PropertyInfo {

    pub fn new(
        owner: Identity,
        pincode: u64,
    ) -> Self {
        Self {
            owner,
            pincode,
            listed: PropertyState::Listed,
            available: BookingState::Available,
        }
    }
}
