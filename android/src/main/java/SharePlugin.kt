package com.plugin.share

import android.app.Activity
import android.content.Intent
import app.tauri.annotation.Command
import app.tauri.annotation.InvokeArg
import app.tauri.annotation.TauriPlugin
import app.tauri.plugin.JSObject
import app.tauri.plugin.Plugin
import app.tauri.plugin.Invoke

@InvokeArg
class ShareArgs {
    var url: String? = null
    var title: String? = null
    var text: String? = null
}

@TauriPlugin
class SharePlugin(private val activity: Activity): Plugin(activity) {

    @Command
    fun share(invoke: Invoke) {
        val args = invoke.parseArgs(ShareArgs::class.java)

        // Build the share text: combine text and URL if both present
        val shareText = buildString {
            args.text?.let { append(it) }
            args.url?.let { url ->
                if (isNotEmpty()) append("\n")
                append(url)
            }
        }

        if (shareText.isEmpty()) {
            invoke.reject("Nothing to share: provide at least 'url' or 'text'")
            return
        }

        val intent = Intent(Intent.ACTION_SEND).apply {
            type = "text/plain"
            args.title?.let { putExtra(Intent.EXTRA_SUBJECT, it) }
            putExtra(Intent.EXTRA_TEXT, shareText)
        }

        val chooserTitle = args.title ?: "Share"
        val chooser = Intent.createChooser(intent, chooserTitle)

        activity.startActivity(chooser)
        invoke.resolve(JSObject())
    }

    @Command
    fun canShare(invoke: Invoke) {
        // On Android, we can always share text content
        val ret = JSObject()
        ret.put("value", true)
        invoke.resolve(ret)
    }
}
