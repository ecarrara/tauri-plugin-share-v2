import SwiftRs
import Tauri
import UIKit
import WebKit

/// Arguments for the share command.
class ShareArgs: Decodable {
    /// URL to share.
    let url: String?
    /// Title for the shared content (may be ignored by some targets).
    let title: String?
    /// Text content to share.
    let text: String?
}

class SharePlugin: Plugin {
    // Share command will be implemented in ENG-133
}

@_cdecl("init_plugin_share")
func initPlugin() -> Plugin {
    return SharePlugin()
}
