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

// API functions will be implemented in ENG-135
