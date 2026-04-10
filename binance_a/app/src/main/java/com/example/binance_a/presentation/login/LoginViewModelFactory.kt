package com.example.binance_a.presentation.login

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.example.binance_a.core.network.TimeSyncManager
import com.example.binance_a.core.security.SecureStorage
import com.example.binance_a.domain.usecase.VerifyCredentialsUseCase

class LoginViewModelFactory(
    private val secureStorage: SecureStorage,
    private val verifyCredentialsUseCase: VerifyCredentialsUseCase,
    private val timeSyncManager: TimeSyncManager
) : ViewModelProvider.Factory {
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(LoginViewModel::class.java)) {
            @Suppress("UNCHECKED_CAST")
            return LoginViewModel(secureStorage, verifyCredentialsUseCase, timeSyncManager) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}
