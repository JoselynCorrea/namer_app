// Top-level build file for common configuration
buildscript {
    repositories {
        google()
        mavenCentral()
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Keep a simple clean task
tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
