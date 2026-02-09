# Changelog

## [0.1.0] - 2026-02-09

Initial release.

### Features

- Native share sheet on iOS via `UIActivityViewController`
- Native share sheet on Android via `Intent.ACTION_SEND`
- TypeScript API with `share()`, `canShare()`, and `polyfillNavigatorShare()`
- Full Tauri v2 permissions support

### Platform Support

| Platform | Status |
|----------|--------|
| iOS | ✅ Supported |
| Android | ✅ Supported |
| Desktop | ❌ Not supported (returns error) |
