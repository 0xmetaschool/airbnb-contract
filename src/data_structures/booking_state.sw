library;

use core::ops::Eq;

/// Represents the current state of the Booking.
pub enum BookingState {

    pub Available: (),

    pub Booked: (),

    pub Cancelled: (),
}

impl Eq for BookingState {
    fn eq(self, other: BookingState) -> bool {
        match (self, other) {
            (BookingState::Available, BookingState::Available) => true,
            (BookingState::Booked, BookingState::Booked) => true,
            (BookingState::Cancelled, BookingState::Cancelled) => true,
            _ => false,
        }
    }
}
