package com.example.binance_a.core.logging

import android.content.Context
import android.content.pm.ApplicationInfo
import dagger.hilt.android.qualifiers.ApplicationContext
import timber.log.Timber
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Implementation of [Logger] using Timber.
 * Initialized once (as a singleton) to plant the Timber tree if the app is debuggable.
 */
@Singleton
class TimberLogger @Inject constructor(
    @ApplicationContext context: Context
) : Logger {

    init {
        val isDebuggable = (context.applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE) != 0
        if (isDebuggable && Timber.treeCount == 0) {
            // Plant the merged tree which gives clickable links AND pretty borders!
            Timber.plant(MergedLoggerTree())
            Timber.d("TimberLogger initialized and MergedLoggerTree planted.")
        }
    }

    override fun d(message: String, vararg args: Any?) {
        Timber.d(message, *args)
    }

    override fun i(message: String, vararg args: Any?) {
        Timber.i(message, *args)
    }

    override fun w(message: String, vararg args: Any?) {
        Timber.w(message, *args)
    }

    override fun e(message: String, vararg args: Any?) {
        Timber.e(message, *args)
    }

    override fun e(throwable: Throwable, message: String?, vararg args: Any?) {
        Timber.e(throwable, message, *args)
    }
}
