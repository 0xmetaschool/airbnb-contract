library;

pub enum BookingError {

    PropertyBooked: (),

    BookingNotFound: (),

    PropertyNotAvailable: (),

    PropertyNotFound: (),
}

pub enum CreationError {

    BookingDateMustBeInFuture: (),
}

pub enum UserError {

    InvalidID: (),
    /// The user is not authorized to perform this action.
    UnauthorizedUser: (),

    PropertyNotAvailable: (),

}
