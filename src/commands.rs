use tauri::{command, AppHandle, Runtime};

use crate::models::*;
use crate::Result;
use crate::ShareExt;

#[command]
pub(crate) async fn share<R: Runtime>(
    app: AppHandle<R>,
    payload: ShareRequest,
) -> Result<()> {
    app.share().share(payload)
}

#[command]
pub(crate) async fn can_share<R: Runtime>(app: AppHandle<R>) -> Result<bool> {
    app.share().can_share()
}
