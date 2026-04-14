package com.example.binance_a.core.security

import android.content.Context
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.example.binance_a.core.logging.Logger
import io.mockk.mockk
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class SecureStorageTest {

    private lateinit var secureStorage: SecureStorage

    @Before
    fun setup() {
        val context = ApplicationProvider.getApplicationContext<Context>()
        val logger: Logger = mockk(relaxed = true)
        secureStorage = SecureStorage(context, logger)

        // Ensure starting clean
        secureStorage.clear()
    }

    @Test
    fun testSaveAndGetCredentials() {
        val apiKey = "test_api_key"
        val apiSecret = "test_api_secret"
        val env = "TESTNET"

        secureStorage.saveCredentials(apiKey, apiSecret, env)

        assertEquals(apiKey, secureStorage.getApiKey())
        assertEquals(apiSecret, secureStorage.getApiSecret())
        assertEquals(true, secureStorage.isLoggedIn())
    }

    @Test
    fun testClearCredentials() {
        secureStorage.saveCredentials("key", "secret", "env")
        secureStorage.clear()

        assertNull(secureStorage.getApiKey())
        assertNull(secureStorage.getApiSecret())
        assertEquals(false, secureStorage.isLoggedIn())
    }
}