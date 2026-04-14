package com.example.binance_a.core.network

import kotlinx.serialization.Serializable
import retrofit2.http.GET
import retrofit2.http.Tag

data class RequestCredentials(val apiKey: String, val apiSecret: String)

interface BinanceApiService {

    @GET("api/v3/time")
    suspend fun getServerTime(): ServerTimeResponse

    @GET("api/v3/account")
    suspend fun getAccountInfo(
        @Tag credentials: RequestCredentials? = null
    ): AccountInfoResponse

    @GET("api/v3/exchangeInfo")
    suspend fun getExchangeInfo(): ExchangeInfoResponse
}

@Serializable
data class ServerTimeResponse(
    val serverTime: Long
)

@Serializable
data class AccountInfoResponse(
    val makerCommission: Long,
    val takerCommission: Long,
    val buyerCommission: Long,
    val sellerCommission: Long,
    val canTrade: Boolean,
    val canWithdraw: Boolean,
    val canDeposit: Boolean,
    val updateTime: Long,
    val accountType: String,
    val balances: List<Balance>,
    val permissions: List<String>
)

@Serializable
data class Balance(
    val asset: String,
    val free: String,
    val locked: String
)

@Serializable
data class ExchangeInfoResponse(
    val timezone: String,
    val serverTime: Long,
    val symbols: List<SymbolInfo>
)

@Serializable
data class SymbolInfo(
    val symbol: String,
    val status: String,
    val baseAsset: String,
    val quoteAsset: String,
    val filters: List<Filter>
)

@Serializable
data class Filter(
    val filterType: String,
    val minPrice: String? = null,
    val maxPrice: String? = null,
    val tickSize: String? = null,
    val minQty: String? = null,
    val maxQty: String? = null,
    val stepSize: String? = null,
    val minNotional: String? = null
)
