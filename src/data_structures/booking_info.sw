library;

use ::data_structures::booking_state::BookingState;

/// General data structure containing information about a booking
pub struct BookingInfo {
    /// The user who has created the booking
    pub bookedBy: Identity,
    ///booking from
    pub bookingFrom: u64,
    ///booking to
    pub bookingTo: u64,
    //Booking Status
    pub status: BookingState,
    ///Property booked
    pub property_id: u64,
}

impl BookingInfo {

    pub fn new(
        bookedBy: Identity,
        bookingFrom: u64,
        bookingTo: u64,
        property_id: u64,
    ) -> Self {
        Self {
            bookedBy,
            bookingFrom,
            bookingTo,
            status: BookingState::Booked,
            property_id,
        }
    }
}
