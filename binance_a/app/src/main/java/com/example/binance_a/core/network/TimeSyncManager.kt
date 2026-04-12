package com.example.binance_a.core.network

import kotlin.time.Duration.Companion.minutes
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class TimeSyncManager @Inject constructor() {
    @Volatile
    var offset: Long = 0L
        private set

    @Volatile
    var lastSyncTime: Long = 0L
        private set

    fun isSyncStale(): Boolean {
        return System.currentTimeMillis() - lastSyncTime > 30.minutes.inWholeMilliseconds
    }

    fun updateOffset(serverTime: Long) {
        offset = serverTime - System.currentTimeMillis()
        lastSyncTime = System.currentTimeMillis()
    }

    fun getServerTimestamp(): Long = System.currentTimeMillis() + offset
}
