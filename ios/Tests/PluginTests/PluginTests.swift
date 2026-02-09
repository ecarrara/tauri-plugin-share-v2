import XCTest
@testable import tauri_plugin_share

final class SharePluginTests: XCTestCase {
    func testPluginInitialization() throws {
        let plugin = SharePlugin()
        XCTAssertNotNil(plugin)
    }
}
