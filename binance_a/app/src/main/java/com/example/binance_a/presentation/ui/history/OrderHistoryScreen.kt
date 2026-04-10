package com.example.binance_a.presentation.ui.history

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun OrderHistoryScreen() {
    Scaffold(
        topBar = {
            TopAppBar(title = { Text("Order History") })
        }
    ) { padding ->
        Box(modifier = Modifier.padding(padding).fillMaxSize(), contentAlignment = Alignment.Center) {
            Text("Order History Screen (Phase 8)")
        }
    }
}
