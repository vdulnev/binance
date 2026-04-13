package com.example.binance_a.presentation.login

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.binance_a.core.common.Result
import com.example.binance_a.core.logging.Logger
import com.example.binance_a.core.security.SecureStorage
import com.example.binance_a.domain.usecase.VerifyCredentialsUseCase
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.receiveAsFlow
import kotlinx.coroutines.launch
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

@HiltViewModel
class LoginViewModel @Inject constructor(
    private val secureStorage: SecureStorage,
    private val verifyCredentialsUseCase: VerifyCredentialsUseCase,
    private val logger: Logger
) : ViewModel() {

    private val _uiState = MutableStateFlow(LoginUiState())
    val uiState: StateFlow<LoginUiState> = _uiState.asStateFlow()

    private val _loginSuccess = Channel<Unit>(Channel.BUFFERED)
    val loginSuccess = _loginSuccess.receiveAsFlow()

    init {
        logger.d("LoginViewModel initialized")
    }

    fun onApiKeyChange(apiKey: String) {
        _uiState.value = _uiState.value.copy(apiKey = apiKey)
    }

    fun onApiSecretChange(apiSecret: String) {
        _uiState.value = _uiState.value.copy(apiSecret = apiSecret)
    }

    fun onEnvironmentChange(isTestnet: Boolean) {
        logger.d("Environment changed. Testnet: $isTestnet")
        _uiState.value = _uiState.value.copy(isTestnet = isTestnet)
    }

    fun login() {
        val state = _uiState.value
        if (state.apiKey.isBlank() || state.apiSecret.isBlank()) {
            logger.w("Login attempted with blank API Key or Secret")
            _uiState.value = state.copy(error = "API Key and Secret are required")
            return
        }

        logger.i("Attempting login...")
        _uiState.value = state.copy(isLoading = true, error = null)

        viewModelScope.launch {
            try {
                // 1. Save credentials so the Interceptor can use them for verification
                val environment = if (state.isTestnet) "TESTNET" else "MAINNET"
                logger.d("Saving credentials for environment: $environment")
                secureStorage.saveCredentials(state.apiKey, state.apiSecret, environment)

                // 2. Verify credentials (Interceptor will sign this request)
                logger.d("Calling VerifyCredentialsUseCase")
                when (val result = verifyCredentialsUseCase(state.apiKey, state.apiSecret, environment)) {
                    is Result.Success -> {
                        logger.i("Login successful")
                        _uiState.value = _uiState.value.copy(isLoading = false)
                        _loginSuccess.send(Unit)
                    }
                    is Result.Error -> {
                        logger.e(result.exception, "Login verification failed")
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
                logger.e(e, "Unexpected error during login")
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
    val error: String? = null
)
