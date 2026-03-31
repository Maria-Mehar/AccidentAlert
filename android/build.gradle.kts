plugins {
    id("com.android.application") version "8.6.0" apply false
    id("com.android.library") apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
    id("dev.flutter.flutter-gradle-plugin")  apply false
    id("com.google.gms.google-services") version "4.4.4" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Yahan se BuildDir wali lines hata di hain taake "Different Roots" ka error khatam ho jaye

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}