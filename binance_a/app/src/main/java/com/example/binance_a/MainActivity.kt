package com.example.binance_a

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import dagger.hilt.android.AndroidEntryPoint
import com.example.binance_a.core.logging.Logger
import com.example.binance_a.core.security.SecureStorage
import com.example.binance_a.presentation.ui.theme.BinanceATheme
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

        val initialLoggedInState = secureStorage.isLoggedIn()
        logger.i("Initial isLoggedIn state: $initialLoggedInState")

        enableEdgeToEdge()
        setContent {
            BinanceATheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    com.example.binance_a.presentation.navigation.AppNavHost(
                        isLoggedIn = initialLoggedInState, 
                        logger = logger,
                        onLogout = {
                            logger.i("Logout requested from AppNavHost")
                            secureStorage.clear()
                            // Note: Realistically, you'd trigger navigation or activity restart
                        }
                    )
                }
            }
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
