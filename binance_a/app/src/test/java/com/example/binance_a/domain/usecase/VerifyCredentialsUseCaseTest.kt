package com.example.binance_a.domain.usecase

import com.example.binance_a.core.common.Result
import com.example.binance_a.core.logging.Logger
import com.example.binance_a.core.network.BinanceApiService
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.mockk
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test

class VerifyCredentialsUseCaseTest {

    private lateinit var apiService: BinanceApiService
    private lateinit var logger: Logger
    private lateinit var useCase: VerifyCredentialsUseCase

    @Before
    fun setup() {
        apiService = mockk()
        logger = mockk(relaxed = true)
        useCase = VerifyCredentialsUseCase(apiService, logger)
    }

    @Test
    fun `invoke returns success when api call is successful`() = runTest {
        // Arrange
        val mockResponse = com.example.binance_a.core.network.AccountInfoResponse(
            makerCommission = 0L, takerCommission = 0L, buyerCommission = 0L, sellerCommission = 0L,
            canTrade = true, canWithdraw = true, canDeposit = true, updateTime = 12345L,
            accountType = "SPOT", balances = emptyList(), permissions = emptyList()
        )
        coEvery { apiService.getAccountInfo() } returns mockResponse

        // Act
        val result = useCase("test_key", "test_secret", "MAINNET")

        // Assert
        assertTrue(result is Result.Success)
        coVerify { apiService.getAccountInfo() }
    }

    @Test
    fun `invoke returns error when api call throws exception`() = runTest {
        // Arrange
        val exceptionMessage = "Network error"
        coEvery { apiService.getAccountInfo() } throws RuntimeException(exceptionMessage)

        // Act
        val result = useCase("test_key", "test_secret", "MAINNET")

        // Assert
        assertTrue(result is Result.Error)
        assertEquals(exceptionMessage, (result as Result.Error).exception.message)
        coVerify { apiService.getAccountInfo() }
    }
}