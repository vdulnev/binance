package com.example.binance_a.core.network

import com.example.binance_a.core.logging.Logger
import kotlin.time.Duration.Companion.minutes
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class TimeSyncManager @Inject constructor(
    private val logger: Logger
) {
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
        val currentLocalTime = System.currentTimeMillis()
        offset = serverTime - currentLocalTime
        lastSyncTime = currentLocalTime
        logger.i("Time sync updated. Offset: ${offset}ms, Last sync: $lastSyncTime")
    }

    fun getServerTimestamp(): Long = System.currentTimeMillis() + offset
}
