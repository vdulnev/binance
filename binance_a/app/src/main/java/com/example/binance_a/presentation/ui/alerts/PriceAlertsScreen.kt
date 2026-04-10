package com.example.binance_a.presentation.ui.alerts

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PriceAlertsScreen() {
    Scaffold(
        topBar = {
            TopAppBar(title = { Text("Price Alerts") })
        }
    ) { padding ->
        Box(modifier = Modifier.padding(padding).fillMaxSize(), contentAlignment = Alignment.Center) {
            Text("Price Alerts Screen (Phase 9)")
        }
    }
}
