package com.example.binance_a.presentation.login

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.binance_a.core.common.Constants
import com.example.binance_a.core.common.Result
import com.example.binance_a.core.network.TimeSyncManager
import com.example.binance_a.core.security.SecureStorage
import com.example.binance_a.domain.usecase.VerifyCredentialsUseCase
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import timber.log.Timber
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

@HiltViewModel
class LoginViewModel @Inject constructor(
    private val secureStorage: SecureStorage,
    private val verifyCredentialsUseCase: VerifyCredentialsUseCase,
    private val timeSyncManager: TimeSyncManager
) : ViewModel() {

    private val _uiState = MutableStateFlow(LoginUiState())
    val uiState: StateFlow<LoginUiState> = _uiState.asStateFlow()

    init {
        Timber.d("LoginViewModel initialized")
    }

    fun onApiKeyChange(apiKey: String) {
        _uiState.value = _uiState.value.copy(apiKey = apiKey)
    }

    fun onApiSecretChange(apiSecret: String) {
        _uiState.value = _uiState.value.copy(apiSecret = apiSecret)
    }

    fun onEnvironmentChange(isTestnet: Boolean) {
        Timber.d("Environment changed. Testnet: $isTestnet")
        _uiState.value = _uiState.value.copy(isTestnet = isTestnet)
    }

    fun login() {
        val state = _uiState.value
        if (state.apiKey.isBlank() || state.apiSecret.isBlank()) {
            Timber.w("Login attempted with blank API Key or Secret")
            _uiState.value = state.copy(error = "API Key and Secret are required")
            return
        }

        Timber.i("Attempting login...")
        _uiState.value = state.copy(isLoading = true, error = null)

        viewModelScope.launch {
            try {
                // 1. Save credentials so the Interceptor can use them for verification
                val environment = if (state.isTestnet) "TESTNET" else "MAINNET"
                Timber.d("Saving credentials for environment: $environment")
                secureStorage.saveCredentials(state.apiKey, state.apiSecret, environment)

                // 2. Verify credentials (Interceptor will sign this request)
                Timber.d("Calling VerifyCredentialsUseCase")
                when (val result = verifyCredentialsUseCase(state.apiKey, state.apiSecret, environment)) {
                    is Result.Success -> {
                        Timber.i("Login successful")
                        // TODO: Perform time sync
                        // timeSyncManager.syncTime()
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            isLoggedIn = true
                        )
                    }
                    is Result.Error -> {
                        Timber.e(result.exception, "Login verification failed")
                        // Verification failed, clear sensitive data
                        secureStorage.clear()
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            error = result.exception.message ?: "Login failed"
                        )
                    }
                    is Result.Loading -> {}
                }
            } catch (e: Exception) {
                Timber.e(e, "Unexpected error during login")
                secureStorage.clear()
                _uiState.value = _uiState.value.copy(
                    isLoading = false,
                    error = e.message ?: "Unexpected error"
                )
            }
        }
    }
}

data class LoginUiState(
    val apiKey: String = "",
    val apiSecret: String = "",
    val isTestnet: Boolean = false,
    val isLoading: Boolean = false,
    val isLoggedIn: Boolean = false,
    val error: String? = null
)
