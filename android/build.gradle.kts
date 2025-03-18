// Repositories configuration
allprojects {
    repositories {
        google()
        mavenCentral()
        // jcenter() // Uncomment only if necessary, as it's deprecated.
    }
}

// Custom build directory setup
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build")
rootProject.layout.buildDirectory.set(newBuildDir.get())

subprojects {
    // Set custom build directory for each subproject
    layout.buildDirectory.set(newBuildDir.get().dir(name))

    // Ensure 'app' project is evaluated first if needed
    evaluationDependsOn(":app")
}

// Clean task to delete the custom build directory
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
