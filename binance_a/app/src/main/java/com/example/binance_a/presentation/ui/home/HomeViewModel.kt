package com.example.binance_a.presentation.ui.home

import androidx.lifecycle.ViewModel
import com.example.binance_a.core.logging.Logger
import com.example.binance_a.core.security.SecureStorage
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

/**
 * ViewModel for the [HomeScreen].
 */
@HiltViewModel
class HomeViewModel @Inject constructor(
    private val secureStorage: SecureStorage,
    private val logger: Logger
) : ViewModel() {

    /**
     * Clears user credentials and logs out.
     * The [MainActivity] observes the login state from [SecureStorage] and will navigate accordingly.
     */
    fun logout() {
        logger.i("HomeViewModel: Initiating logout.")
        secureStorage.clear()
    }
}
