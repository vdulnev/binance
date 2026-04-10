package com.example.binance_a.core.logging

import com.orhanobut.logger.AndroidLogAdapter
import com.orhanobut.logger.Logger
import com.orhanobut.logger.PrettyFormatStrategy
import timber.log.Timber

/**
 * A Timber Tree that merges DetailedDebugTree and PrettyLoggerTree.
 * It generates a clickable Logcat tag (FileName:LineNumber) and uses
 * Orhan Obut's Logger to wrap the log in aesthetic ASCII borders.
 */
class MergedLoggerTree : Timber.DebugTree() {
    init {
        val formatStrategy = PrettyFormatStrategy.newBuilder()
            .showThreadInfo(true)       // Show thread info
            .methodOffset(4)            // Skip 5 internal Timber/Logger methods so it starts at your code!
            .build()
            
        Logger.clearLogAdapters()
        Logger.addLogAdapter(AndroidLogAdapter(formatStrategy))
    }

    override fun log(priority: Int, tag: String?, message: String, t: Throwable?) {
        // Pipes the log and custom tag to Logger for formatting
        Logger.log(priority, tag, message, t)
    }
}
