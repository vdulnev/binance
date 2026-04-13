package com.example.binance_a.domain.usecase

import com.example.binance_a.core.common.BinanceException
import com.example.binance_a.core.common.Result
import com.example.binance_a.core.logging.Logger
import com.example.binance_a.core.network.BinanceApiService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import javax.inject.Inject

class VerifyCredentialsUseCase @Inject constructor(
    private val apiService: BinanceApiService,
    private val logger: Logger
) {
    suspend operator fun invoke(
        apiKey: String,
        apiSecret: String,
        environment: String
    ): Result<Unit> {
        return withContext(Dispatchers.IO) {
            try {
                logger.d("Starting credentials verification for environment: $environment")
                // The AuthInterceptor will handle signing using the credentials
                // stored temporarily in SecureStorage by the login flow.
                apiService.getAccountInfo()
                logger.d("Credentials verification successful")
                Result.Success(Unit)
            } catch (e: Exception) {
                logger.e(e, "Credentials verification failed")
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
