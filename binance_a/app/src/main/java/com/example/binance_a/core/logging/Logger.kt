package com.example.binance_a.core.logging

/**
 * Interface for logging messages.
 */
interface Logger {
    fun d(message: String, vararg args: Any?)
    fun i(message: String, vararg args: Any?)
    fun w(message: String, vararg args: Any?)
    fun e(message: String, vararg args: Any?)
    fun e(throwable: Throwable, message: String? = null, vararg args: Any?)
}
