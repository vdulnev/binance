package com.example.binance_a.presentation.login

import com.example.binance_a.core.common.Result
import com.example.binance_a.core.logging.Logger
import com.example.binance_a.core.network.TimeSyncManager
import com.example.binance_a.core.security.SecureStorage
import com.example.binance_a.domain.usecase.VerifyCredentialsUseCase
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.mockk
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.resetMain
import kotlinx.coroutines.test.runTest
import kotlinx.coroutines.test.setMain
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

@OptIn(ExperimentalCoroutinesApi::class)
class LoginViewModelTest {

    private lateinit var secureStorage: SecureStorage
    private lateinit var verifyCredentialsUseCase: VerifyCredentialsUseCase
    private lateinit var timeSyncManager: TimeSyncManager
    private lateinit var logger: Logger
    private lateinit var viewModel: LoginViewModel

    private val testDispatcher = StandardTestDispatcher()

    @Before
    fun setup() {
        Dispatchers.setMain(testDispatcher)
        secureStorage = mockk(relaxed = true)
        verifyCredentialsUseCase = mockk()
        timeSyncManager = mockk(relaxed = true)
        logger = mockk(relaxed = true)

        viewModel = LoginViewModel(secureStorage, verifyCredentialsUseCase, timeSyncManager, logger)
    }

    @After
    fun tearDown() {
        Dispatchers.resetMain()
    }

    @Test
    fun `login with blank credentials shows error`() = runTest {
        viewModel.login()

        assertEquals("API Key and Secret are required", viewModel.uiState.value.error)
        assertEquals(false, viewModel.uiState.value.isLoading)
        coVerify(exactly = 0) { secureStorage.saveCredentials(any(), any(), any()) }
    }

    @Test
    fun `login success updates state and saves credentials`() = runTest {
        viewModel.onApiKeyChange("valid_key")
        viewModel.onApiSecretChange("valid_secret")
        viewModel.onEnvironmentChange(true) // Testnet

        coEvery { 
            verifyCredentialsUseCase("valid_key", "valid_secret", "TESTNET") 
        } returns Result.Success(Unit)

        viewModel.login()
        advanceUntilIdle()

        assertEquals(true, viewModel.uiState.value.isLoggedIn)
        assertEquals(false, viewModel.uiState.value.isLoading)
        assertEquals(null, viewModel.uiState.value.error)

        coVerify { secureStorage.saveCredentials("valid_key", "valid_secret", "TESTNET") }
    }

    @Test
    fun `login failure clears credentials and shows error`() = runTest {
        viewModel.onApiKeyChange("valid_key")
        viewModel.onApiSecretChange("invalid_secret")

        coEvery { 
            verifyCredentialsUseCase("valid_key", "invalid_secret", "MAINNET") 
        } returns Result.Error(com.example.binance_a.core.common.BinanceException(message = "Invalid signature"))

        viewModel.login()
        advanceUntilIdle()

        assertEquals(false, viewModel.uiState.value.isLoggedIn)
        assertEquals("Invalid signature", viewModel.uiState.value.error)

        coVerify { secureStorage.clear() }
    }

    @Test
    fun `unexpected exception during login clears credentials and shows error`() = runTest {
        viewModel.onApiKeyChange("valid_key")
        viewModel.onApiSecretChange("valid_secret")

        coEvery { 
            verifyCredentialsUseCase(any(), any(), any()) 
        } throws RuntimeException("Network crash")

        viewModel.login()
        advanceUntilIdle()

        assertEquals(false, viewModel.uiState.value.isLoggedIn)
        assertEquals("Network crash", viewModel.uiState.value.error)
        
        coVerify { secureStorage.clear() }
    }
}