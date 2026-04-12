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
import timber.log.Timber
import com.example.binance_a.core.security.SecureStorage
import com.example.binance_a.presentation.ui.theme.BinanceATheme
import javax.inject.Inject

@AndroidEntryPoint
class MainActivity : ComponentActivity() {

    @Inject
    lateinit var secureStorage: SecureStorage

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Timber.d("MainActivity onCreate")

        val initialLoggedInState = secureStorage.isLoggedIn()
        Timber.i("Initial isLoggedIn state: $initialLoggedInState")

        enableEdgeToEdge()
        setContent {
            BinanceATheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    com.example.binance_a.presentation.navigation.AppNavHost(
                        isLoggedIn = initialLoggedInState, 
                        onLogout = {
                            Timber.i("Logout requested from AppNavHost")
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
        Timber.d("MainActivity onStart")
    }

    override fun onResume() {
        super.onResume()
        Timber.d("MainActivity onResume")
    }

    override fun onPause() {
        super.onPause()
        Timber.d("MainActivity onPause")
    }

    override fun onStop() {
        super.onStop()
        Timber.d("MainActivity onStop")
    }

    override fun onDestroy() {
        super.onDestroy()
        Timber.d("MainActivity onDestroy")
    }
}
