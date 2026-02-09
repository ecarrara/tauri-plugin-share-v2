import SwiftRs
import Tauri
import UIKit
import WebKit

class SharePlugin: Plugin {
    // Share command will be implemented in ENG-133
}

@_cdecl("init_plugin_share")
func initPlugin() -> Plugin {
    return SharePlugin()
}
