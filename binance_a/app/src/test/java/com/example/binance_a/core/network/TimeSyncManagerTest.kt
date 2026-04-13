package com.example.binance_a.core.network

import com.example.binance_a.core.logging.Logger
import io.mockk.mockk
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import kotlin.math.abs
import kotlin.time.Duration.Companion.minutes

class TimeSyncManagerTest {

    private lateinit var logger: Logger
    private lateinit var timeSyncManager: TimeSyncManager

    @Before
    fun setup() {
        logger = mockk(relaxed = true)
        timeSyncManager = TimeSyncManager(logger)
    }

    @Test
    fun `initial state has zero offset and zero lastSyncTime`() {
        assertEquals(0L, timeSyncManager.offset)
        assertEquals(0L, timeSyncManager.lastSyncTime)
    }

    @Test
    fun `isSyncStale returns true when lastSyncTime is 0`() {
        assertTrue(timeSyncManager.isSyncStale())
    }

    @Test
    fun `updateOffset calculates correct offset and sets lastSyncTime`() {
        val serverTime = System.currentTimeMillis() + 5000L // 5 seconds ahead
        timeSyncManager.updateOffset(serverTime)

        // Give a small tolerance due to execution time diff
        val tolerance = 50L
        assertTrue(abs(timeSyncManager.offset - 5000L) <= tolerance)
        assertTrue(System.currentTimeMillis() - timeSyncManager.lastSyncTime <= tolerance)
    }

    @Test
    fun `getServerTimestamp returns correctly adjusted time`() {
        val serverTime = System.currentTimeMillis() - 10000L // 10 seconds behind
        timeSyncManager.updateOffset(serverTime)

        val predictedServerTime = timeSyncManager.getServerTimestamp()
        val actualSystemTime = System.currentTimeMillis()
        
        // Tolerance needed because time moves
        val tolerance = 50L
        val expected = actualSystemTime - 10000L
        
        assertTrue(abs(predictedServerTime - expected) <= tolerance)
    }
}