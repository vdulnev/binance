package com.example.binance_a

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import timber.log.Timber
import com.example.binance_a.core.network.AuthInterceptor
import com.example.binance_a.core.network.NetworkModule
import com.example.binance_a.core.network.TimeSyncManager
import com.example.binance_a.core.security.SecureStorage
import com.example.binance_a.domain.usecase.VerifyCredentialsUseCase
import com.example.binance_a.presentation.login.LoginViewModel
import com.example.binance_a.presentation.ui.theme.BinanceATheme

class MainActivity : ComponentActivity() {

    // Temp direct init for testing UI
    lateinit var secureStorage: SecureStorage
    lateinit var loginViewModel: LoginViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Timber.d("MainActivity onCreate")
        secureStorage = SecureStorage(this)
        
        val timeSyncManager = TimeSyncManager()
        val authInterceptor = AuthInterceptor(secureStorage, timeSyncManager)
        val okHttpClient = NetworkModule.provideOkHttpClient(authInterceptor, NetworkModule.provideLoggingInterceptor())
        val retrofit = NetworkModule.provideRetrofit(okHttpClient)
        val apiService = NetworkModule.provideBinanceApiService(retrofit)
        val verifyUseCase = VerifyCredentialsUseCase(apiService)
        
        loginViewModel = LoginViewModel(secureStorage, verifyUseCase, timeSyncManager)

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
                        loginViewModel = loginViewModel,
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
