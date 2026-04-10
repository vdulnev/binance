package com.example.binance_a.domain.usecase

import com.example.binance_a.core.common.BinanceException
import com.example.binance_a.core.common.Constants
import com.example.binance_a.core.common.Result
import com.example.binance_a.core.network.BinanceApiService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
class VerifyCredentialsUseCase(
    private val apiService: BinanceApiService
) {
    suspend operator fun invoke(
        apiKey: String,
        apiSecret: String,
        environment: String
    ): Result<Unit> {
        return withContext(Dispatchers.IO) {
            try {
                // The AuthInterceptor will handle signing using the credentials
                // stored temporarily in SecureStorage by the login flow.
                apiService.getAccountInfo()
                Result.Success(Unit)
            } catch (e: Exception) {
                val binanceException = if (e.message?.contains("code") == true) {
                    BinanceException(message = e.message ?: "Verification failed")
                } else {
                    BinanceException(message = e.message ?: "Verification failed")
                }
                Result.Error(binanceException)
            }
        }
    }
}
