# tauri-plugin-share

A Tauri v2 plugin for native share sheet functionality on mobile platforms.

## Features

- **iOS**: Uses `UIActivityViewController` for native share sheet
- **Android**: Uses `Intent.ACTION_SEND` for native share sheet
- **Desktop**: Falls back to clipboard copy

## Why?

The Web Share API (`navigator.share`) is not supported in Android WebView, even though it's Chromium-based. This plugin provides a unified share API that works across all Tauri-supported platforms.

| Platform | WebView | navigator.share | This Plugin |
|----------|---------|-----------------|-------------|
| iOS | WKWebView | ✅ Supported | ✅ Works |
| Android | System WebView | ❌ **Not supported** | ✅ Works |
| Desktop | - | Varies | ✅ Clipboard fallback |

## Installation

```bash
# Rust
cargo add tauri-plugin-share

# JavaScript bindings
bun add tauri-plugin-share-api
# or
npm install tauri-plugin-share-api
```

## Setup

Register the plugin in your Tauri app:

```rust
fn main() {
    tauri::Builder::default()
        .plugin(tauri_plugin_share::init())
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
```

## Usage

```typescript
import { share } from 'tauri-plugin-share-api';

await share({
  url: 'https://example.com',
  title: 'Check this out!',
  text: 'An awesome link to share',
});
```

## Permissions

Add to your `capabilities/default.json`:

```json
{
  "permissions": ["share:default"]
}
```

## License

MIT
