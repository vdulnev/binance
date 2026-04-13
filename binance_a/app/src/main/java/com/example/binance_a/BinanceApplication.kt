package com.example.binance_a

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

@HiltAndroidApp
class BinanceApplication : Application() {

    override fun onCreate() {
        super.onCreate()
    }
}
