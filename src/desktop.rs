use serde::de::DeserializeOwned;
use tauri::{plugin::PluginApi, AppHandle, Runtime};

use crate::models::*;

pub fn init<R: Runtime, C: DeserializeOwned>(
    app: &AppHandle<R>,
    _api: PluginApi<R, C>,
) -> crate::Result<Share<R>> {
    Ok(Share(app.clone()))
}

/// Access to the share APIs.
pub struct Share<R: Runtime>(AppHandle<R>);

impl<R: Runtime> Share<R> {
    /// Share content - not available on desktop.
    pub fn share(&self, _request: ShareRequest) -> crate::Result<()> {
        Err(crate::Error::NotAvailableOnDesktop)
    }

    /// Check if sharing is available on this platform.
    pub fn can_share(&self) -> crate::Result<bool> {
        Ok(false)
    }
}
