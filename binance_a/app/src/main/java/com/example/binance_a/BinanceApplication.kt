package com.example.binance_a

import android.app.Application
import android.content.pm.ApplicationInfo
import com.example.binance_a.core.logging.MergedLoggerTree
import dagger.hilt.android.HiltAndroidApp
import timber.log.Timber

@HiltAndroidApp
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
