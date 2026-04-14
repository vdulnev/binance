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
    fun topBar_displaysTitle() {
        composeTestRule.setContent {
            TopBar(onLogout = {})
        }

        composeTestRule.onNodeWithText("Binance Client").assertExists()
        composeTestRule.onNodeWithContentDescription("Logout").assertExists()
    }

    @Test
    fun topBar_logoutClick_triggersCallback() {
        var logoutClicked = false

        composeTestRule.setContent {
            TopBar(onLogout = { logoutClicked = true })
        }

        composeTestRule.onNodeWithContentDescription("Logout").performClick()

        assertTrue("Logout callback was not triggered", logoutClicked)
    }

    @Test
    fun portfolioSection_displaysContent() {
        composeTestRule.setContent {
            PortfolioSection()
        }

        composeTestRule.onNodeWithText("Total Portfolio").assertExists()
        composeTestRule.onNodeWithText("$12,345.67 USDT").assertExists()
        composeTestRule.onNodeWithText("Portfolio").assertExists()
        composeTestRule.onNodeWithText("Market").assertExists()
    }

    @Test
    fun quickActions_displaysAllButtons() {
        composeTestRule.setContent {
            QuickActions()
        }

        composeTestRule.onNodeWithText("Trade").assertExists()
        composeTestRule.onNodeWithText("Order History").assertExists()
        composeTestRule.onNodeWithText("Favorites").assertExists()
        composeTestRule.onNodeWithText("Settings").assertExists()
    }
}
