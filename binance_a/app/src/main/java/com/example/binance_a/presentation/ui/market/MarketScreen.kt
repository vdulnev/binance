package com.example.binance_a.presentation.ui.market

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MarketScreen() {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Market") },
                actions = {
                    IconButton(onClick = { /* Search */ }) {
                        Icon(
                            Icons.Filled.Search,
                            contentDescription = "Search"
                        )
                    }
                }
            )
        }
    ) { padding ->
        Box(modifier = Modifier.padding(padding)) {
            // Market list will be implemented in Phase 4
            Column(
                modifier = Modifier.fillMaxSize(),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center
            ) {
                Text("Market Screen (Phase 4)", style = MaterialTheme.typography.headlineMedium)
            }
        }
    }
}
