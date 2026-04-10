package com.example.binance_a.presentation.ui.portfolio

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PortfolioScreen() {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Portfolio") },
                actions = {
                    // Refresh button
                    IconButton(onClick = { /* Refresh */ }) {
                        Icon(
                            Icons.Filled.Refresh,
                            contentDescription = "Refresh"
                        )
                    }
                }
            )
        }
    ) { padding ->
        LazyColumn(
            modifier = Modifier.padding(padding),
            contentPadding = PaddingValues(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            item {
                TotalBalanceCard()
            }
            item {
                Spacer(modifier = Modifier.height(16.dp))
                Text("Balances", style = MaterialTheme.typography.titleMedium)
                Spacer(modifier = Modifier.height(8.dp))
            }
            item {
                AssetListItem(
                    symbol = "BTC",
                    free = "0.5",
                    locked = "0.0",
                    totalValue = "45,678.90 USDT"
                )
            }
            item {
                AssetListItem(
                    symbol = "ETH",
                    free = "10.5",
                    locked = "0.0",
                    totalValue = "18,234.50 USDT"
                )
            }
            item {
                AssetListItem(
                    symbol = "USDT",
                    free = "5,000.00",
                    locked = "0.00",
                    totalValue = "5,000.00 USDT"
                )
            }
        }
    }
}

@Composable
fun TotalBalanceCard() {
    Card(
        modifier = Modifier.fillMaxWidth(),
        colors = CardColors(
            containerColor = MaterialTheme.colorScheme.primaryContainer,
            contentColor = MaterialTheme.colorScheme.onPrimaryContainer,
            disabledContainerColor = MaterialTheme.colorScheme.onPrimaryContainer.copy(0.12f),
            disabledContentColor = MaterialTheme.colorScheme.onPrimaryContainer.copy(0.38f)
        )
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text("Total Portfolio Value", style = MaterialTheme.typography.bodyMedium)
            Spacer(modifier = Modifier.height(4.dp))
            Text(
                text = "$68,913.40 USDT",
                style = MaterialTheme.typography.displaySmall.copy(fontWeight = FontWeight.Bold)
            )
            Spacer(modifier = Modifier.height(8.dp))
            Row {
                Text("Spot: $10,000.00 USDT")
                Spacer(modifier = Modifier.width(16.dp))
                Text("Futures: $58,913.40 USDT")
            }
        }
    }
}

@Composable
fun AssetListItem(
    symbol: String,
    free: String,
    locked: String,
    totalValue: String
) {
    Card(modifier = Modifier.fillMaxWidth()) {
        Row(
            modifier = Modifier.padding(16.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Column {
                Text(symbol, style = MaterialTheme.typography.titleMedium)
                Text("Free: $free | Locked: $locked", style = MaterialTheme.typography.bodySmall)
            }
            Text(totalValue, style = MaterialTheme.typography.titleMedium)
        }
    }
}
