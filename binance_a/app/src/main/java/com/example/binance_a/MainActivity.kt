package com.example.binance_a

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.example.binance_a.core.logging.Logger
import com.example.binance_a.core.security.SecureStorage
import com.example.binance_a.presentation.navigation.AppNavHost
import com.example.binance_a.presentation.ui.theme.BinanceATheme
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class MainActivity : ComponentActivity() {

    @Inject
    lateinit var secureStorage: SecureStorage

    @Inject
    lateinit var logger: Logger

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        logger.d("MainActivity onCreate")

        enableEdgeToEdge()
        setContent {
            AppContent()
        }
    }

    override fun onStart() {
        super.onStart()
        logger.d("MainActivity onStart")
    }

    override fun onResume() {
        super.onResume()
        logger.d("MainActivity onResume")
    }

    override fun onPause() {
        super.onPause()
        logger.d("MainActivity onPause")
    }

    override fun onStop() {
        super.onStop()
        logger.d("MainActivity onStop")
    }

    override fun onDestroy() {
        super.onDestroy()
        logger.d("MainActivity onDestroy")
    }
}

@Composable
private fun MainActivity.AppContent() {
    val isLoggedIn by secureStorage.isLoggedInFlow.collectAsStateWithLifecycle()
    logger.i("Current isLoggedIn state from SecureStorage: $isLoggedIn")

    BinanceATheme {
        Surface(
            modifier = Modifier.fillMaxSize(),
            color = MaterialTheme.colorScheme.background
        ) {
            AppNavHost(
                isLoggedIn = isLoggedIn,
                logger = logger
            )
        }
    }
}
