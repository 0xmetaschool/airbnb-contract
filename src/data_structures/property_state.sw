library;

use core::ops::Eq;

/// Represents the current state of the campaign.
pub enum PropertyState {
    /// The campaign has been cancelled.
    Listed: (),
    /// The campain was successful
    Unlisted: (),
}

impl Eq for PropertyState {
    fn eq(self, other: PropertyState) -> bool {
        match (self, other) {
            (PropertyState::Listed, PropertyState::Listed) => true,
            (PropertyState::Unlisted, PropertyState::Unlisted) => true,
            _ => false,
        }
    }
}
