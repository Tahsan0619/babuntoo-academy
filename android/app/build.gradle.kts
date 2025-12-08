plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.babuntoo_academy"
    compileSdk = 35 // 34 is current Flutter stable, 35 is fine but best for all plugin support is 34 now
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // Application package name (change before publishing to Play Store!)
        applicationId = "com.example.babuntoo_academy"
        // --- CRUCIAL FOR DEVICE SUPPORT: ---
        minSdk = 21           // <--- Minimum for virtually all Android phones in use (Lollipop, 2014+)
        targetSdk = 35        // Always latest for Play Store, 34 is recommended currently
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // --- ABI Filters: Add this block! ---
        ndk {
            abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86_64")
        }
    }

    buildTypes {
        release {
            // TODO: Replace with your release signing config before publishing!
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // (Optional) If you want to generate separate APKs for each ABI:
    /*splits {
        abi {
            isEnable = true
            reset()
            include("armeabi-v7a", "arm64-v8a", "x86_64")
            isUniversalApk = false
        }
    }*/
}

flutter {
    source = "../.."
}
