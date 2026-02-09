#!/bin/bash
# Patch build.gradle.kts for release signing

GRADLE_FILE="src-tauri/gen/android/app/build.gradle.kts"

# Add import at the top
sed -i '1s/^/import java.io.FileInputStream\nimport java.util.Properties\n\n/' "$GRADLE_FILE"

# Add signing config before buildTypes
sed -i '/^android {/a\
    signingConfigs {\
        create("release") {\
            val keystorePropertiesFile = rootProject.file("keystore.properties")\
            val keystoreProperties = Properties()\
            if (keystorePropertiesFile.exists()) {\
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))\
            }\
            keyAlias = keystoreProperties["keyAlias"] as String?\
            keyPassword = keystoreProperties["password"] as String?\
            storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }\
            storePassword = keystoreProperties["password"] as String?\
        }\
    }' "$GRADLE_FILE"

# Update release buildType to use signing config
sed -i 's/getByName("release") {/getByName("release") {\n            signingConfig = signingConfigs.getByName("release")/' "$GRADLE_FILE"

echo "Android signing patched successfully"
