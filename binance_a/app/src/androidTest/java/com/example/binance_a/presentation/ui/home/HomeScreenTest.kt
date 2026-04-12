package com.example.binance_a.presentation.ui.home

import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithContentDescription
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.performClick
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test

class HomeScreenTest {

    @get:Rule
    val composeTestRule = createComposeRule()

    @Test
    fun homeScreen_displaysPortfolioAndActions() {
        composeTestRule.setContent {
            HomeScreen()
        }

        // Check TopBar
        composeTestRule.onNodeWithText("Binance Client").assertExists()
        composeTestRule.onNodeWithContentDescription("Logout").assertExists()

        // Check Portfolio Section
        composeTestRule.onNodeWithText("Total Portfolio").assertExists()
        composeTestRule.onNodeWithText("$12,345.67 USDT").assertExists()
        composeTestRule.onNodeWithText("Portfolio").assertExists()
        composeTestRule.onNodeWithText("Market").assertExists()

        // Check Quick Actions
        composeTestRule.onNodeWithText("Trade").assertExists()
        composeTestRule.onNodeWithText("Order History").assertExists()
        composeTestRule.onNodeWithText("Favorites").assertExists()
        composeTestRule.onNodeWithText("Settings").assertExists()
    }

    @Test
    fun homeScreen_logoutClick_triggersCallback() {
        var logoutClicked = false

        composeTestRule.setContent {
            HomeScreen(onLogout = { logoutClicked = true })
        }

        composeTestRule.onNodeWithContentDescription("Logout").performClick()

        assertTrue("Logout callback was not triggered", logoutClicked)
    }
}