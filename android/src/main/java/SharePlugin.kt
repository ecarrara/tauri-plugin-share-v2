package com.plugin.share

import android.app.Activity
import app.tauri.annotation.Command
import app.tauri.annotation.InvokeArg
import app.tauri.annotation.TauriPlugin
import app.tauri.plugin.JSObject
import app.tauri.plugin.Plugin
import app.tauri.plugin.Invoke

@TauriPlugin
class SharePlugin(private val activity: Activity): Plugin(activity) {
    // Share command will be implemented in ENG-132
}
