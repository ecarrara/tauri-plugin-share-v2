use serde::{Deserialize, Serialize};

/// Data to be shared via the native share sheet.
#[derive(Debug, Clone, Default, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ShareRequest {
    /// URL to share.
    pub url: Option<String>,
    /// Title for the shared content (may be ignored by some targets).
    pub title: Option<String>,
    /// Text content to share.
    pub text: Option<String>,
}

/// Response from canShare command.
#[derive(Debug, Clone, Default, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct CanShareResponse {
    pub value: bool,
}
