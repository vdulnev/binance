# Binance Client — Android Implementation Specification

> **Status:** Draft
> **Author:** vd
> **Created:** 2026-04-07
> **Last Updated:** 2026-04-07
> **Version:** 0.1.0
> **Parent Spec:** [../docs/SPEC.md](SPEC.md)

---

## 1. Overview

This document outlines the technical implementation of the **Binance Client** for Android, based on the platform-agnostic [SPEC.md](SPEC.md). It leverages modern Android development practices, Jetpack Compose, and the latest recommended libraries to deliver a high-performance, secure, and maintainable application.

## 2. Tech Stack

| Category            | Choice                                                                 | Rationale                                                         |
|---------------------|------------------------------------------------------------------------|-------------------------------------------------------------------|
| **Language**        | Kotlin (Latest Stable)                                                 | Official language, null safety, coroutines                        |
| **UI Framework**    | Jetpack Compose + Material 3                                           | Declarative UI, consistent theming, rich ecosystem                |
| **Navigation**      | Navigation 3 (`androidx.navigation3:navigation3-runtime`)           | Back stack as state, type-safe, simple Compose integration       |
| **Architecture**    | MVVM (Model-View-ViewModel) + Repository Pattern                       | Separation of concerns, testability                               |
| **State Management**| Kotlin StateFlow + ViewModel                                           | Lifecycle-aware, reactive UI updates                              |
| **Dependency Injection**| Hilt (`com.google.dagger:hilt-android`)                                | Compile-time safety, standard Android DI                          |
| **Networking (REST)**| Retrofit (`com.squareup.retrofit2:retrofit`) + OkHttp                  | Mature, widely used, excellent interceptor support                |
| **Networking (WS)** | OkHttp WebSocket or Ktor Client (CIO engine)                           | Low-latency streaming                                             |
| **Serialization**   | Kotlinx Serialization (`org.jetbrains.kotlinx:kotlinx-serialization`)  | Multiplatform, type-safe, fast                                    |
| **Local DB**        | Room (`androidx.room:room-runtime`)                                    | SQLite abstraction, Flow support, compile-time checks             |
| **Preferences**     | DataStore Preferences (`androidx.datastore:datastore-preferences`)     | Asynchronous key-value storage                                    |
| **Secure Storage**  | EncryptedSharedPreferences (`androidx.security:security-crypto`)       | AES-256 GCM encryption backed by Android Keystore                 |
| **Async**           | Kotlin Coroutines (`org.jetbrains.kotlinx:kotlinx-coroutines-android`) | Structured concurrency                                            |
| **Charts**          | Custom Compose Canvas / Vico (`com.patrykandpatrick:vico`)             | Native Compose rendering, high performance                        |
| **Logging**         | Timber (`com.jakewharton.timber:timber`) + Logback                     | Flexible logging trees                                            |

## 3. Architecture

The app follows **Clean Architecture** principles with three distinct layers:

```
┌─────────────────────────────────────────────────┐
│                  Presentation Layer             │
│  (Compose UI, ViewModel, StateFlow, Hilt Modules)│
└─────────────────────────────────────────────────┘
                       ▲
                       │
┌─────────────────────────────────────────────────┐
│                   Domain Layer                  │
│     (UseCases, Repository Interfaces, Models)   │
└─────────────────────────────────────────────────┘
                       ▲
                       │
┌─────────────────────────────────────────────────┐
│                    Data Layer                   │
│ (Repositories, DataSources: Retrofit, Room, WS) │
└─────────────────────────────────────────────────┘
```

### 3.1 Module Structure

```
:app (Production Code)
├── main/java/com/example/binance_a/
│   ├── core/
│   │   ├── common/        # Base classes, Result wrapper, Constants
│   │   ├── network/       # Retrofit setup, AuthInterceptor, WS Manager
│   │   ├── security/      # EncryptedStorage, KeyManager
│   │   └── util/          # Extensions, Formatters, TimeSync
│   ├── data/
│   │   ├── repository/    # DataRepository, MarketRepository implementations
│   │   ├── local/         # Room DAOs, DataStore
│   │   ├── remote/        # Binance API Services, WS DTOs
│   │   └── model/         # Room Entities, Network DTOs, Mappers
│   ├── domain/
│   │   ├── repository/    # Repository Interfaces
│   │   ├── usecase/       # LoginUseCase, PlaceOrderUseCase, etc.
│   │   └── model/         # Domain Models
│   └── presentation/
│       ├── navigation/    # NavDisplay, BackStack, Routes
│       ├── ui/
│       │   ├── login/     # LoginScreen, LoginViewModel
│       │   ├── portfolio/ # PortfolioScreen, etc.
│       │   ├── trade/     # TradeScreen, OrderForm
│       │   └── theme/     # Color, Type, Theme
│       └── components/    # Reusable Composables (Chart, OrderBook, etc.)
├── main/res/
└── main/AndroidManifest.xml
```

## 4. Detailed Implementation

### 4.1 Authentication & Security

- **Storage:** Credentials (`apiKey`, `apiSecret`) are stored in `EncryptedSharedPreferences`.
- **Verification:** On login, the app calls `VerifyCredentialsUseCase` which hits `GET /api/v3/account`.
- **Time Sync:** A `TimeSyncManager` runs periodically or on auth error (`-1021`) to fetch server time and calculate the offset. The offset is applied to request timestamps.
- **Interceptor:** An OkHttp `Interceptor` adds `X-MBX-APIKEY`, `timestamp`, and `signature` to every request. It reads credentials from secure storage and signs the query string using HMAC-SHA256.

```kotlin
// Example Interceptor logic
class AuthInterceptor @Inject constructor(
    private val secureStorage: SecureStorage,
    private val timeSync: TimeSyncManager
) : Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response {
        val request = chain.request()
        val apiKey = secureStorage.getApiKey() ?: return chain.proceed(request)
        
        val timestamp = System.currentTimeMillis() + timeSync.offset
        val url = request.url.newBuilder()
            .addQueryParameter("timestamp", timestamp.toString())
            .build()
        
        val signature = HmacUtils.hmacSha256Hex(secureStorage.getApiSecret(), url.encodedQuery)
        val signedUrl = url.newBuilder().addQueryParameter("signature", signature).build()
        
        val newRequest = request.newBuilder()
            .url(signedUrl)
            .header("X-MBX-APIKEY", apiKey)
            .build()
            
        return chain.proceed(newRequest)
    }
}
```

### 4.2 WebSocket Management

- **Client:** Use OkHttp WebSocket for simplicity or Ktor for structured concurrency.
- **Manager:** A `WebSocketManager` singleton handles connection lifecycle.
- **Reconnection:** Implements exponential backoff (max 30s).
- **Subscription:** Uses a `SharedFlow` to manage subscriptions. The manager tracks active streams and resubscribes on reconnect.
- **Data Flow:** Raw WS messages are deserialized and emitted via `StateFlow`s (e.g., `tickerFlow`, `orderBookFlow`).

### 4.3 Local Persistence (Room)

- **Database:** `BinanceDatabase`.
- **Entities:** `FavoriteEntity`, `PriceAlertEntity`, `CachedOrderEntity`.
- **DAOs:** Provide `Flow<List<T>>` for reactive UI updates.
- **Caching:** Portfolio snapshots and order history are cached to Room. The UI observes the Flow, showing cached data immediately while the network request refreshes it.

```kotlin
@Entity(tableName = "price_alerts")
data class PriceAlertEntity(
    @PrimaryKey val id: String = UUID.randomUUID().toString(),
    val symbol: String,
    val market: String, // "SPOT" or "FUTURES"
    val direction: String, // "ABOVE" or "BELOW"
    val price: BigDecimal,
    val enabled: Boolean = true
)
```

### 4.4 UI & Compose

- **Navigation:** Single Activity architecture with `NavHost`.
- **Theming:** Material 3 `MaterialTheme` with a custom `ColorScheme` for Light/Dark. Toggled via `SettingsViewModel` observing `DataStore`.
- **Layouts:** 
    - `Scaffold` for top-level screens.
    - `LazyColumn`/`LazyRow` for lists (OrderBook, Favorites).
    - Custom `Modifier` for charts.
- **Charts:** 
    - Implement candlestick chart using Compose Canvas for maximum control and performance.
    - Overlay indicators (MA, RSI) using `Path` and `DrawScope`.
    - Handle touch events for crosshair and drawing tools.

### 4.5 Error Handling

- **Result Wrapper:** 
  ```kotlin
  sealed class Result<out T> {
      data class Success<T>(val data: T) : Result<T>()
      data class Error(val exception: BinanceException) : Result<Nothing>()
      object Loading : Result<Nothing>()
  }
  ```
- **Global Handler:** A `CoroutineExceptionHandler` in ViewModelScope catches unhandled exceptions and posts UI events (Snackbars).
- **Network Errors:** Mapped to user-friendly strings via `ResourceProvider`.

## 5. Key Features Implementation

### 5.1 Charting (Compose Canvas)

- **Drawing:** `Canvas` composable iterates over `klineList`.
- **Grid:** Custom `Modifier` draws price/time grids.
- **Interactions:** `detectDragGestures` for panning, `detectTapGestures` for crosshair.
- **Performance:** Only render visible candles. Use `remember` for expensive calculations.

### 5.2 Order Entry Form

- **Validation:** ViewModel validates inputs against `ExchangeInfo` filters (lot size, tick size, min notional).
- **Feedback:** Real-time validation errors displayed below text fields.
- **Confirmation:** `AlertDialog` for destructive actions (Place/Cancel).

### 5.3 Notifications (Price Alerts)

- **Service:** `WorkManager` or `ForegroundService` to monitor prices in background (subject to OS constraints).
- **Delivery:** `NotificationManagerCompat` for local notifications.
- **Evaluation:** Compare live ticker prices against active alerts in Room.

## 6. Testing Strategy

| Type              | Tools                                     | Scope                                       |
|-------------------|-------------------------------------------|---------------------------------------------|
| Unit Tests        | JUnit 5, MockK, Turbine                   | UseCases, Repositories, Interceptor logic   |
| Integration Tests | MockWebServer, Room in-memory DB          | Data layer flows, API responses             |
| UI Tests          | Compose Testing, Espresso                 | Screen rendering, user interactions         |
| E2E               | Testnet API, UI Automator                 | Login → Trade → History                     |

## 7. Build Configuration

```kotlin
// build.gradle.kts (:app)
android {
    namespace = "com.example.binance_a"
    compileSdk = 35
    
    defaultConfig {
        applicationId = "com.example.binance_a"
        minSdk = 26
        targetSdk = 35
        versionCode = 1
        versionName = "0.1.0"
        
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }
    
    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
    
    buildFeatures {
        compose = true
    }
    
    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.1" // Align with Kotlin version
    }
}

dependencies {
    // Core
    implementation("androidx.core:core-ktx:1.13.1")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.8.4")
    implementation("androidx.lifecycle:lifecycle-viewmodel-compose:2.8.4")
    
    // Compose
    implementation(platform("androidx.compose:compose-bom:2024.08.00"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.material3:material3")
    // Navigation 3
    implementation("androidx.navigation3:navigation3-runtime:1.1.0-alpha04")
    implementation("androidx.navigation3:navigation3-ui:1.1.0-alpha04")
    
    // DI
    implementation("com.google.dagger:hilt-android:2.52")
    kapt("com.google.dagger:hilt-compiler:2.52")
    
    // Network
    implementation("com.squareup.retrofit2:retrofit:2.11.0")
    implementation("com.squareup.okhttp3:okhttp:4.12.0")
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.7.1")
    implementation("com.squareup.retrofit2:converter-kotlinx-serialization:2.11.0")
    
    // Local Storage
    implementation("androidx.room:room-runtime:2.6.1")
    implementation("androidx.room:room-ktx:2.6.1")
    kapt("androidx.room:room-compiler:2.6.1")
    implementation("androidx.datastore:datastore-preferences:1.1.1")
    implementation("androidx.security:security-crypto:1.1.0-alpha06")
}
```

## 8. Implementation Plan Alignment

This Android spec directly supports the phases outlined in the parent [SPEC.md](SPEC.md):

| Phase | Android Focus Areas |
|-------|---------------------|
| 1     | Hilt setup, Retrofit/OkHttp, EncryptedSharedPreferences, Login Screen/Flow |
| 2     | DataStore for env toggle, Navigation routes, Secure logout flow |
| 3     | Portfolio UI (LazyColumn), Room caching, WebSocket User Data Stream |
| 4     | Market list UI, Favorites Room integration, WS Manager for depth/ticker |
| 5     | Trade UI (Compose forms), Validation UseCases, Order confirmation dialogs |
| 6     | Futures-specific UI toggles, Position management in ViewModel |
| 7     | Compose Canvas Chart implementation, Indicator calculations |
| 8     | History screens with Room paging, Offline support |
| 9     | Alert Room CRUD, Background worker for price monitoring |
| 10    | Deposit/Withdraw UI, SAPI endpoints |
| 11    | Theme switcher, Timber integration, Error handling polish |
| 12    | Testnet E2E testing, Profiling, Lint/Rules setup |
