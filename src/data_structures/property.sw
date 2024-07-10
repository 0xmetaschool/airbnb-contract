library;

/// Used to track the Listings that a user has created.
pub struct Property {
    /// The unique identifier for the Listing.
    pub id: u64,
}

impl Property {
    /// Creates a new Listing.
    ///
    /// # Arguments
    ///
    /// * `id`: [u64] - The unique identifier for the Listing.
    pub fn new(id: u64) -> Self {
        Self { id }
    }
}