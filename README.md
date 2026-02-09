# tauri-plugin-share

A Tauri v2 plugin for native share sheet functionality on mobile platforms.

## Why?

The Web Share API (`navigator.share`) is **not supported in Android WebView**, even though it's Chromium-based. This plugin provides a native share API that works on iOS and Android.

| Platform | WebView | navigator.share | This Plugin |
|----------|---------|-----------------|-------------|
| iOS | WKWebView | ✅ Supported | ✅ Native share sheet |
| Android | System WebView | ❌ **Not supported** | ✅ Native share sheet |
| Desktop | - | Varies | ❌ Not supported |

## Installation

```bash
# Add the Rust crate
cargo add tauri-plugin-share

# Add the JavaScript bindings
bun add tauri-plugin-share-api
# or
npm install tauri-plugin-share-api
```

## Setup

### 1. Register the plugin

In your `src-tauri/src/lib.rs`:

```rust
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_share::init())
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
```

### 2. Add permissions

In your `src-tauri/capabilities/default.json`:

```json
{
  "permissions": ["share:default"]
}
```

## Usage

### Basic usage

```typescript
import { share, canShare } from 'tauri-plugin-share-api';

// Check if sharing is available
if (await canShare()) {
  await share({
    url: 'https://example.com',
    title: 'Check this out!',
    text: 'An awesome website',
  });
}
```

### Web Share API polyfill

For drop-in compatibility with existing Web Share API code:

```typescript
import { polyfillNavigatorShare } from 'tauri-plugin-share-api';

// Call once at app startup
polyfillNavigatorShare();

// Now navigator.share works on Android WebView!
await navigator.share({
  url: 'https://example.com',
  title: 'Check this out!',
});
```

## API

### `share(data: ShareData): Promise<void>`

Opens the native share sheet with the provided content.

```typescript
interface ShareData {
  /** URL to share */
  url?: string;
  /** Title (may be ignored by some share targets) */
  title?: string;
  /** Text content to share */
  text?: string;
}
```

### `canShare(data?: ShareData): Promise<boolean>`

Returns `true` if sharing is available on the current platform.

- **iOS/Android**: Always returns `true`
- **Desktop**: Returns `false`

### `polyfillNavigatorShare(): void`

Polyfills `navigator.share` with this plugin's implementation. Only patches if `navigator.share` is not already available.

## Platform notes

### iOS

Uses `UIActivityViewController`. The share sheet appears as a modal with all available share targets.

### Android

Uses `Intent.ACTION_SEND` with `Intent.createChooser()`. The system share sheet shows all apps that can handle text content.

### Desktop

Sharing is not supported on desktop platforms. `canShare()` returns `false` and `share()` throws an error.

## License

MIT
