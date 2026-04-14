package com.example.binance_a.core.security

import android.content.Context
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey
import dagger.hilt.android.qualifiers.ApplicationContext
import androidx.core.content.edit
import com.example.binance_a.core.logging.Logger
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class SecureStorage @Inject constructor(
    @ApplicationContext private val context: Context,
    private val logger: Logger
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

    // Thread-safe in-memory cache to avoid EncryptedSharedPreferences latency/threading issues
    @Volatile
    private var cachedApiKey: String? = null
    @Volatile
    private var cachedApiSecret: String? = null
    @Volatile
    private var cachedEnvironment: String? = null

    private val _isLoggedInFlow = MutableStateFlow(false)
    val isLoggedInFlow: StateFlow<Boolean> = _isLoggedInFlow.asStateFlow()

    init {
        // Initialize cache from disk on startup
        cachedApiKey = sharedPreferences.getString(KEY_API_KEY, null)
        cachedApiSecret = sharedPreferences.getString(KEY_API_SECRET, null)
        cachedEnvironment = sharedPreferences.getString(KEY_ENVIRONMENT, null)
        
        _isLoggedInFlow.value = isLoggedIn()
        
        logger.d("SecureStorage initialized. Instance: ${this.hashCode()}, Initial LoggedIn: ${_isLoggedInFlow.value}")
    }

    companion object {
        private const val KEY_API_KEY = "api_key"
        private const val KEY_API_SECRET = "api_secret"
        private const val KEY_ENVIRONMENT = "environment"
    }

    fun saveCredentials(apiKey: String, apiSecret: String, environment: String) {
        logger.d("SecureStorage(${this.hashCode()}): Saving credentials. API Key length: ${apiKey.length}")
        
        // Update cache first for immediate availability
        cachedApiKey = apiKey
        cachedApiSecret = apiSecret
        cachedEnvironment = environment
        
        // Save to disk asynchronously (or use commit=true for safety)
        sharedPreferences.edit(commit = true) {
            putString(KEY_API_KEY, apiKey)
            putString(KEY_API_SECRET, apiSecret)
            putString(KEY_ENVIRONMENT, environment)
        }
        
        _isLoggedInFlow.value = true
    }

    fun getApiKey(): String? = cachedApiKey

    fun getApiSecret(): String? = cachedApiSecret

    fun getEnvironment(): String? = cachedEnvironment

    fun clear() {
        logger.d("SecureStorage(${this.hashCode()}): Clearing credentials")
        
        cachedApiKey = null
        cachedApiSecret = null
        cachedEnvironment = null
        
        sharedPreferences.edit(commit = true) { clear() }
        _isLoggedInFlow.value = false
    }

    fun isLoggedIn(): Boolean = !cachedApiKey.isNullOrBlank() && !cachedApiSecret.isNullOrBlank()
}
