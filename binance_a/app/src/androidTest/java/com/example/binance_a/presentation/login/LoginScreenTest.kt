package com.example.binance_a.presentation.login

import androidx.compose.ui.test.assertIsDisplayed
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performTextInput
import com.example.binance_a.core.network.TimeSyncManager
import com.example.binance_a.core.security.SecureStorage
import com.example.binance_a.domain.usecase.VerifyCredentialsUseCase
import io.mockk.mockk
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Rule
import org.junit.Test

class LoginScreenTest {

    @get:Rule
    val composeTestRule = createComposeRule()

    private lateinit var viewModel: LoginViewModel

    @Before
    fun setup() {
        val secureStorage: SecureStorage = mockk(relaxed = true)
        val verifyCredentialsUseCase: VerifyCredentialsUseCase = mockk(relaxed = true)
        val timeSyncManager: TimeSyncManager = mockk(relaxed = true)
        
        viewModel = LoginViewModel(secureStorage, verifyCredentialsUseCase, timeSyncManager)
    }

    @Test
    fun loginScreen_displaysInitialElements() {
        composeTestRule.setContent {
            LoginScreen(viewModel = viewModel, onLoginSuccess = {})
        }

        composeTestRule.onNodeWithText("Binance Client").assertIsDisplayed()
        composeTestRule.onNodeWithText("API Key").assertIsDisplayed()
        composeTestRule.onNodeWithText("API Secret").assertIsDisplayed()
        composeTestRule.onNodeWithText("Use Testnet").assertIsDisplayed()
        composeTestRule.onNodeWithText("Login").assertIsDisplayed()
    }

    @Test
    fun loginScreen_updatesInputFields() {
        composeTestRule.setContent {
            LoginScreen(viewModel = viewModel, onLoginSuccess = {})
        }

        composeTestRule.onNodeWithText("API Key").performTextInput("test_key")
        composeTestRule.onNodeWithText("API Secret").performTextInput("test_secret")

        // In a real UI test, we might want to test the text box content directly,
        // but since we're using a real view model, we can just assert its state changed.
        assertTrue(viewModel.uiState.value.apiKey == "test_key")
        assertTrue(viewModel.uiState.value.apiSecret == "test_secret")
    }
}