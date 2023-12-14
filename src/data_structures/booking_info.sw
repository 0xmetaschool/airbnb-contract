library;

use ::data_structures::booking_state::BookingState;

/// General data structure containing information about a booking
pub struct BookingInfo {
    /// The user who has created the booking
    bookedBy: Identity,
    ///booking from
    bookingFrom: u64,
    ///booking to
    bookingTo: u64,
    //Booking Status
    status: BookingState,
    ///Property booked
    property_id: u64,
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
