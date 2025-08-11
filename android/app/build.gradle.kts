plugins {
    id("com.android.application")
    id("kotlin-android")
}

android {
    namespace = "com.example.movie_watchlist"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.movie_watchlist"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

signingConfigs {
    create("release") {
        storeFile = file("upload-keystore.jks") // If in android/app/
        // OR if in android/ folder:
        // storeFile = file("../upload-keystore.jks")
        storePassword = "mypassword123"
        keyAlias = "upload"
        keyPassword = "mypassword123"
    }
}

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }
}

dependencies {
    implementation("androidx.multidex:multidex:2.0.1")
}