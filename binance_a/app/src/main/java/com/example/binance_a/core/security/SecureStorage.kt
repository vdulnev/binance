package com.example.binance_a.core.security

import android.content.Context
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Inject
import javax.inject.Singleton
import androidx.core.content.edit

@Singleton
class SecureStorage @Inject constructor(
    @ApplicationContext private val context: Context
) {
    private val masterKey = MasterKey.Builder(context)
        .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
        .build()

    private val sharedPreferences = EncryptedSharedPreferences.create(
        context,
        "binance_secure_prefs",
        masterKey,
        EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
        EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
    )

    companion object {
        private const val KEY_API_KEY = "api_key"
        private const val KEY_API_SECRET = "api_secret"
        private const val KEY_ENVIRONMENT = "environment"
    }

    fun saveCredentials(apiKey: String, apiSecret: String, environment: String) {
        sharedPreferences.edit(commit = true) {
            putString(KEY_API_KEY, apiKey)
                .putString(KEY_API_SECRET, apiSecret)
                .putString(KEY_ENVIRONMENT, environment)
        }
    }

    fun getApiKey(): String? = sharedPreferences.getString(KEY_API_KEY, null)

    fun getApiSecret(): String? = sharedPreferences.getString(KEY_API_SECRET, null)

    fun clear() {
        sharedPreferences.edit(commit = true) { clear() }
    }

    fun isLoggedIn(): Boolean = getApiKey() != null && getApiSecret() != null
}
