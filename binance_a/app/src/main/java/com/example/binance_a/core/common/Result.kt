package com.example.binance_a.core.common

sealed class Result<out T> {
    data class Success<T>(val data: T) : Result<T>()
    data class Error(val exception: BinanceException) : Result<Nothing>()
    object Loading : Result<Nothing>()
}

class BinanceException(
    val code: Int? = null,
    message: String,
    cause: Throwable? = null
) : Exception(message, cause) {
    companion object {
        fun fromApiError(apiCode: Int, apiMessage: String): BinanceException {
            return BinanceException(
                code = apiCode,
                message = apiMessage
            )
        }
    }
}
