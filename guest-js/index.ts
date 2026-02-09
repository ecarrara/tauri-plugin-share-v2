import { invoke } from '@tauri-apps/api/core'

/**
 * Data to be shared via the native share sheet.
 */
export interface ShareData {
  /** URL to share. */
  url?: string
  /** Title for the shared content (may be ignored by some targets). */
  title?: string
  /** Text content to share. */
  text?: string
}

// API functions will be implemented in ENG-135
