package com.example.binance_a.core.network

import com.example.binance_a.core.security.SecureStorage
import io.mockk.every
import io.mockk.mockk
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.mockwebserver.MockResponse
import okhttp3.mockwebserver.MockWebServer
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Before
import org.junit.Test

class AuthInterceptorTest {

    private lateinit var mockWebServer: MockWebServer
    private lateinit var secureStorage: SecureStorage
    private lateinit var timeSyncManager: TimeSyncManager
    private lateinit var authInterceptor: AuthInterceptor
    private lateinit var okHttpClient: OkHttpClient

    @Before
    fun setup() {
        mockWebServer = MockWebServer()
        mockWebServer.start()

        secureStorage = mockk(relaxed = true)
        timeSyncManager = mockk(relaxed = true)

        authInterceptor = AuthInterceptor(secureStorage, timeSyncManager)

        okHttpClient = OkHttpClient.Builder()
            .addInterceptor(authInterceptor)
            .build()
    }

    @After
    fun teardown() {
        mockWebServer.shutdown()
    }

    @Test
    fun `when api key is null, request proceeds without signing`() {
        every { secureStorage.getApiKey() } returns null

        mockWebServer.enqueue(MockResponse().setResponseCode(200))

        val request = Request.Builder()
            .url(mockWebServer.url("/api/v3/ticker/price"))
            .build()

        okHttpClient.newCall(request).execute()

        val recordedRequest = mockWebServer.takeRequest()
        assertNull(recordedRequest.getHeader("X-MBX-APIKEY"))
        assertNull(recordedRequest.requestUrl?.queryParameter("signature"))
    }

    @Test
    fun `when api key is present, request is signed with signature and timestamp`() {
        every { secureStorage.getApiKey() } returns "my_api_key"
        every { secureStorage.getApiSecret() } returns "my_api_secret"
        every { timeSyncManager.getServerTimestamp() } returns 1600000000000L

        mockWebServer.enqueue(MockResponse().setResponseCode(200))

        val request = Request.Builder()
            .url(mockWebServer.url("/api/v3/order?symbol=BTCUSDT"))
            .build()

        okHttpClient.newCall(request).execute()

        val recordedRequest = mockWebServer.takeRequest()
        assertEquals("my_api_key", recordedRequest.getHeader("X-MBX-APIKEY"))
        
        val requestUrl = recordedRequest.requestUrl!!
        assertEquals("1600000000000", requestUrl.queryParameter("timestamp"))
        
        // Ensure signature exists
        val signature = requestUrl.queryParameter("signature")
        assert(signature != null && signature.isNotEmpty())
    }

    @Test
    fun `when api key has newlines, they are sanitized`() {
        every { secureStorage.getApiKey() } returns "my_api_key\nwith_newline\r"
        every { secureStorage.getApiSecret() } returns "secret"
        every { timeSyncManager.getServerTimestamp() } returns 1600000000000L

        mockWebServer.enqueue(MockResponse().setResponseCode(200))

        val request = Request.Builder()
            .url(mockWebServer.url("/api/v3/order"))
            .build()

        okHttpClient.newCall(request).execute()

        val recordedRequest = mockWebServer.takeRequest()
        // Newlines should be stripped as per AuthInterceptor implementation
        assertEquals("my_api_keywith_newline", recordedRequest.getHeader("X-MBX-APIKEY"))
    }
}