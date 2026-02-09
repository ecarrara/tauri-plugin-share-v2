package com.plugin.share

import org.junit.Test
import org.junit.Assert.*

/**
 * Unit tests for SharePlugin.
 */
class SharePluginTest {
    @Test
    fun pluginPackageIsCorrect() {
        assertEquals("com.plugin.share", SharePlugin::class.java.`package`?.name)
    }
}
