use serde::de::DeserializeOwned;
use tauri::{
    plugin::{PluginApi, PluginHandle},
    AppHandle, Runtime,
};

use crate::models::*;

#[cfg(target_os = "ios")]
tauri::ios_plugin_binding!(init_plugin_share);

pub fn init<R: Runtime, C: DeserializeOwned>(
    _app: &AppHandle<R>,
    api: PluginApi<R, C>,
) -> crate::Result<Share<R>> {
    #[cfg(target_os = "android")]
    let handle = api.register_android_plugin("com.plugin.share", "SharePlugin")?;
    #[cfg(target_os = "ios")]
    let handle = api.register_ios_plugin(init_plugin_share)?;
    Ok(Share(handle))
}

/// Access to the share APIs.
pub struct Share<R: Runtime>(PluginHandle<R>);

impl<R: Runtime> Share<R> {
    /// Share content using the native share sheet.
    pub fn share(&self, request: ShareRequest) -> crate::Result<()> {
        self.0
            .run_mobile_plugin("share", request)
            .map_err(Into::into)
    }

    /// Check if sharing is available on this platform.
    pub fn can_share(&self) -> crate::Result<bool> {
        self.0
            .run_mobile_plugin::<CanShareResponse>("canShare", ())
            .map(|r| r.value)
            .map_err(Into::into)
    }
}
