package com.example.binance_a.presentation.navigation

import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Modifier
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation3.ui.NavDisplay
import androidx.navigation3.runtime.rememberNavBackStack
import androidx.navigation3.runtime.NavKey
import androidx.navigation3.runtime.NavEntry
import kotlinx.serialization.Serializable
import com.example.binance_a.core.logging.Logger
import com.example.binance_a.presentation.login.LoginScreen
import com.example.binance_a.presentation.login.LoginViewModel
import com.example.binance_a.presentation.ui.alerts.PriceAlertsScreen
import com.example.binance_a.presentation.ui.favorites.FavoritesScreen
import com.example.binance_a.presentation.ui.history.OrderHistoryScreen
import com.example.binance_a.presentation.ui.home.HomeScreen
import com.example.binance_a.presentation.ui.market.MarketScreen
import com.example.binance_a.presentation.ui.portfolio.PortfolioScreen
import com.example.binance_a.presentation.ui.settings.SettingsScreen
import com.example.binance_a.presentation.ui.trade.TradeScreen

@Composable
fun AppNavHost(
    isLoggedIn: Boolean,
    logger: Logger,
    modifier: Modifier = Modifier,
    onLogout: () -> Unit = {}
) {
    val initialEntry = if (isLoggedIn) AppRoute.Home else AppRoute.Login
    val backStack = rememberNavBackStack(initialEntry)

    LaunchedEffect(backStack.lastOrNull()) {
        logger.d("Navigated to: ${backStack.lastOrNull()?.javaClass?.simpleName}")
    }

    NavDisplay(
        backStack = backStack,
        modifier = modifier
    ) { key ->
        NavEntry(key) {
            when (key) {
                AppRoute.Login -> {
                    val loginViewModel: LoginViewModel = hiltViewModel()
                    LoginScreen(
                        viewModel = loginViewModel,
                        onLoginSuccess = {
                            logger.i("Login flow complete. Navigating to Home.")
                            backStack.add(AppRoute.Home)
                        }
                    )
                }
                AppRoute.Home -> HomeScreen(
                    onLogout = {
                        logger.i("Logout triggered. Navigating to Login.")
                        onLogout()
                    }
                )
                AppRoute.Portfolio -> PortfolioScreen()
                AppRoute.Market -> MarketScreen()
                AppRoute.Trade -> TradeScreen()
                AppRoute.OrderHistory -> OrderHistoryScreen()
                AppRoute.Favorites -> FavoritesScreen()
                AppRoute.PriceAlerts -> PriceAlertsScreen()
                AppRoute.Settings -> SettingsScreen()
                else -> {
                    logger.w("Unknown route encountered: $key")
                }
            }
        }
    }
}

@Serializable
sealed class AppRoute : NavKey {
    @Serializable data object Login : AppRoute()
    @Serializable data object Home : AppRoute()
    @Serializable data object Portfolio : AppRoute()
    @Serializable data object Market : AppRoute()
    @Serializable data object Trade : AppRoute()
    @Serializable data object OrderHistory : AppRoute()
    @Serializable data object Favorites : AppRoute()
    @Serializable data object PriceAlerts : AppRoute()
    @Serializable data object Settings : AppRoute()
}
