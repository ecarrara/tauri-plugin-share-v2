import { invoke } from '@tauri-apps/api/core'

/**
 * Data to be shared via the native share sheet.
 *
 * At least one of `url`, `title`, or `text` should be provided.
 *
 * @example
 * ```typescript
 * const data: ShareData = {
 *   url: 'https://example.com',
 *   title: 'Check this out!',
 *   text: 'An awesome website'
 * }
 * ```
 */
export interface ShareData {
  /** URL to share. */
  url?: string
  /** Title for the shared content (may be ignored by some share targets). */
  title?: string
  /** Text content to share. */
  text?: string
}

/**
 * Share content using the native share sheet.
 *
 * On mobile platforms (iOS/Android), this opens the native share dialog.
 * On desktop, content is copied to the clipboard.
 *
 * @param data - The content to share
 * @throws If sharing fails or no content is provided
 *
 * @example
 * ```typescript
 * import { share } from 'tauri-plugin-share-api'
 *
 * await share({
 *   url: 'https://example.com',
 *   title: 'Check this out!',
 *   text: 'An awesome website'
 * })
 * ```
 */
export async function share(data: ShareData): Promise<void> {
  await invoke('plugin:share|share', { payload: data })
}

/**
 * Check if sharing is available on the current platform.
 *
 * @param data - Optional data to check if it can be shared
 * @returns true if sharing is available
 *
 * @example
 * ```typescript
 * import { canShare } from 'tauri-plugin-share-api'
 *
 * if (await canShare()) {
 *   // Show share button
 * }
 * ```
 */
export async function canShare(data?: ShareData): Promise<boolean> {
  return await invoke<boolean>('plugin:share|can_share', { payload: data ?? {} })
}

/**
 * Polyfill `navigator.share` and `navigator.canShare` with this plugin's implementation.
 *
 * This allows existing Web Share API code to work in Tauri mobile apps
 * without modification.
 *
 * @example
 * ```typescript
 * import { polyfillNavigatorShare } from 'tauri-plugin-share-api'
 *
 * // Call once at app startup
 * polyfillNavigatorShare()
 *
 * // Now navigator.share works on Android WebView
 * await navigator.share({ url: 'https://example.com' })
 * ```
 */
export function polyfillNavigatorShare(): void {
  if (typeof navigator === 'undefined') return

  const nav = navigator as Navigator & {
    share?: (data: ShareData) => Promise<void>
    canShare?: (data?: ShareData) => boolean
  }

  // Only polyfill if not already available
  if (!nav.share) {
    nav.share = share
  }

  if (!nav.canShare) {
    // Web API canShare is synchronous, but we make it work
    nav.canShare = (_data?: ShareData) => true
  }
}
