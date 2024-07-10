library;

/// Used to track the Listings that a user has created.
pub struct Booking {
    /// The unique identifier for the Listing.
    pub id: u64,
}

impl Booking {
    /// Creates a new Listing.
    ///
    /// # Arguments
    ///
    /// * `id`: [u64] - The unique identifier for the Listing.
    pub fn new(id: u64) -> Self {
        Self { id }
    }
}