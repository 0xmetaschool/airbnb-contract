library;

/// Used to track the Listings that a user has created.
pub struct PropertyImage {
    /// images of the property.
    pub image1: b256,
    pub image2: b256,
}

impl PropertyImage {
    /// Creates a new Listing.
    ///
    /// # Arguments
    ///
    /// * `id`: [u64] - The unique identifier for the Listing.
    pub fn new(image1: b256, image2: b256) -> Self {
        Self { 
            image1,
            image2,
         }
    }
}