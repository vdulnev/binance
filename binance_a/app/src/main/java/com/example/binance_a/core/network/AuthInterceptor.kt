package com.example.binance_a.core.network

import com.example.binance_a.core.security.SecureStorage
import okhttp3.Interceptor
import okhttp3.Response
import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec

class AuthInterceptor(
    private val secureStorage: SecureStorage,
    private val timeSyncManager: TimeSyncManager
) : Interceptor {

    override fun intercept(chain: Interceptor.Chain): Response {
        val originalRequest = chain.request()
        val apiKey = secureStorage.getApiKey()

        // If no API key, proceed without signing (for public endpoints)
        if (apiKey.isNullOrEmpty()) {
            return chain.proceed(originalRequest)
        }

        val timestamp = timeSyncManager.getServerTimestamp()
        val url = originalRequest.url.newBuilder()
            .addQueryParameter("timestamp", timestamp.toString())
            .build()

        val query = url.encodedQuery.orEmpty()
        val apiSecret = secureStorage.getApiSecret().orEmpty()
        val signature = hmacSha256(apiSecret, query)

        val signedUrl = url.newBuilder()
            .addQueryParameter("signature", signature)
            .build()

        val signedRequest = originalRequest.newBuilder()
            .url(signedUrl)
            .header("X-MBX-APIKEY", apiKey)
            .build()

        return chain.proceed(signedRequest)
    }

    private fun hmacSha256(key: String, data: String): String {
        val mac = Mac.getInstance("HmacSHA256")
        mac.init(SecretKeySpec(key.toByteArray(Charsets.UTF_8), "HmacSHA256"))
        val hash = mac.doFinal(data.toByteArray(Charsets.UTF_8))
        return hash.joinToString("") { "%02x".format(it) }
    }
}
