package com.example.binance_a.presentation.ui.home

import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.example.binance_a.presentation.ui.theme.BinanceATheme

@Composable
fun HomeScreen(
    onLogout: () -> Unit = {}
) {
    Scaffold(
        topBar = { TopBar(onLogout = onLogout) }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
        ) {
            PortfolioSection()
            QuickActions()
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TopBar(
    onLogout: () -> Unit
) {
    TopAppBar(
        title = { Text("Binance Client") },
        actions = {
            IconButton(onClick = onLogout) {
                Icon(Icons.Default.Logout, contentDescription = "Logout")
            }
        }
    )
}

@Composable
fun PortfolioSection() {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp)
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text("Total Portfolio", style = MaterialTheme.typography.titleMedium)
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = "$12,345.67 USDT",
                style = MaterialTheme.typography.displaySmall.copy(fontWeight = FontWeight.Bold)
            )
            Spacer(modifier = Modifier.height(16.dp))
            Row {
                TextButton(onClick = { /* Navigate to Portfolio */ }) {
                    Icon(Icons.Default.AccountBalanceWallet, contentDescription = null)
                    Spacer(modifier = Modifier.width(8.dp))
                    Text("Portfolio")
                }
                Spacer(modifier = Modifier.width(16.dp))
                TextButton(onClick = { /* Navigate to Market */ }) {
                    Icon(Icons.Default.TrendingUp, contentDescription = null)
                    Spacer(modifier = Modifier.width(8.dp))
                    Text("Market")
                }
            }
        }
    }
}

@Composable
fun QuickActions() {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp),
        verticalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        OutlinedButton(
            onClick = { /* Navigate to Trade */ },
            modifier = Modifier.fillMaxWidth()
        ) {
            Icon(Icons.Default.SwapHoriz, contentDescription = null)
            Spacer(modifier = Modifier.width(8.dp))
            Text("Trade")
        }

        OutlinedButton(
            onClick = { /* Navigate to Order History */ },
            modifier = Modifier.fillMaxWidth()
        ) {
            Icon(Icons.Default.History, contentDescription = null)
            Spacer(modifier = Modifier.width(8.dp))
            Text("Order History")
        }

        OutlinedButton(
            onClick = { /* Navigate to Favorites */ },
            modifier = Modifier.fillMaxWidth()
        ) {
            Icon(Icons.Default.Star, contentDescription = null)
            Spacer(modifier = Modifier.width(8.dp))
            Text("Favorites")
        }

        OutlinedButton(
            onClick = { /* Navigate to Settings */ },
            modifier = Modifier.fillMaxWidth()
        ) {
            Icon(Icons.Default.Settings, contentDescription = null)
            Spacer(modifier = Modifier.width(8.dp))
            Text("Settings")
        }
    }
}
