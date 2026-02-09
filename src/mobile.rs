use serde::de::DeserializeOwned;
use tauri::{
    plugin::{PluginApi, PluginHandle},
    AppHandle, Runtime,
};

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
    // Share methods will be implemented in ENG-131
}
