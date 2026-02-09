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
    
    @objc public func share(_ invoke: Invoke) {
        do {
            let args = try invoke.parseArgs(ShareArgs.self)
            
            var items: [Any] = []
            
            // Add text if provided
            if let text = args.text {
                items.append(text)
            }
            
            // Add URL if provided
            if let urlString = args.url, let url = URL(string: urlString) {
                items.append(url)
            }
            
            // Reject if nothing to share
            if items.isEmpty {
                invoke.reject("Nothing to share: provide at least 'url' or 'text'")
                return
            }
            
            // Present share sheet on main thread
            DispatchQueue.main.async {
                let activityVC = UIActivityViewController(
                    activityItems: items,
                    applicationActivities: nil
                )
                
                // Get the root view controller to present from
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let rootVC = windowScene.windows.first?.rootViewController else {
                    invoke.reject("Could not find root view controller")
                    return
                }
                
                // Handle iPad popover presentation
                if let popover = activityVC.popoverPresentationController {
                    popover.sourceView = rootVC.view
                    popover.sourceRect = CGRect(
                        x: rootVC.view.bounds.midX,
                        y: rootVC.view.bounds.midY,
                        width: 0,
                        height: 0
                    )
                    popover.permittedArrowDirections = []
                }
                
                rootVC.present(activityVC, animated: true) {
                    invoke.resolve()
                }
            }
        } catch {
            invoke.reject("Failed to parse arguments: \(error.localizedDescription)")
        }
    }
    
    @objc public func canShare(_ invoke: Invoke) {
        // iOS always supports sharing
        invoke.resolve(["value": true])
    }
}

@_cdecl("init_plugin_share")
func initPlugin() -> Plugin {
    return SharePlugin()
}
