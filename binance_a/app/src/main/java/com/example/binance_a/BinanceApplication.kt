package com.example.binance_a

import android.app.Application
import android.content.pm.ApplicationInfo
import com.example.binance_a.core.logging.MergedLoggerTree
import timber.log.Timber

class BinanceApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        val isDebuggable = (applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE) != 0
        if (isDebuggable) {
            // Plant the merged tree which gives clickable links AND pretty borders!
            Timber.plant(MergedLoggerTree())
        }
    }
}
