plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.movie_watchlist"
    compileSdk = flutter.compileSdkVersion

    ndkVersion = "27.0.12077973"

    // Disable split APKs
    splits {
      abi {
        isEnable = false
      }
    }

    // **LEGACY NATIVE LIBS PACKAGING**
    packaging {
      jniLibs {
        useLegacyPackaging = true
      }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }
    defaultConfig {
        applicationId = "com.example.movie_watchlist"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
    signingConfigs {
        create("release") {
            storeFile = file("keystore.jks")
            storePassword = "mypass123"
            keyAlias = "release_key"
            keyPassword = "mypass123"
        }
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            isShrinkResources = false // ✅ This will prevent the error
            signingConfig = signingConfigs.getByName("release")
        }
    }

}

flutter {
    source = "../.."
}
