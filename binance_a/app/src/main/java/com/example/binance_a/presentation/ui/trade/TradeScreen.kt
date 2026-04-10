package com.example.binance_a.presentation.ui.trade

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TradeScreen() {
    Scaffold(
        topBar = {
            TopAppBar(title = { Text("Trade") })
        }
    ) { padding ->
        Box(modifier = Modifier.padding(padding).fillMaxSize(), contentAlignment = Alignment.Center) {
            Text("Trade Screen (Phase 5)")
        }
    }
}
