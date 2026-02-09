use serde::de::DeserializeOwned;
use tauri::{plugin::PluginApi, AppHandle, Runtime};

pub fn init<R: Runtime, C: DeserializeOwned>(
    app: &AppHandle<R>,
    _api: PluginApi<R, C>,
) -> crate::Result<Share<R>> {
    Ok(Share(app.clone()))
}

/// Access to the share APIs.
pub struct Share<R: Runtime>(AppHandle<R>);

impl<R: Runtime> Share<R> {
    // Share methods will be implemented in ENG-134
}
