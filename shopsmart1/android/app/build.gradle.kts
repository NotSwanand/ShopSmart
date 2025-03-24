plugins {
    id("com.android.application")
    id("com.google.gms.google-services")  // ✅ Firebase Plugin
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")  // ✅ Flutter Plugin should be last
}

android {
    namespace = "com.example.shopsmart1"
    compileSdk = 35  // ✅ Updated to latest SDK

    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.shopsmart1"
        minSdk = 23
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")  // ✅ Change to "release" for production
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:32.7.1"))  // ✅ Latest Firebase BOM
    implementation("com.google.firebase:firebase-auth")  // ✅ Firebase Authentication
    implementation("com.google.android.gms:play-services-auth:20.7.0")  // ✅ Google Sign-In
}
