#!/bin/bash
# Patch build.gradle.kts for release signing

GRADLE_FILE="src-tauri/gen/android/app/build.gradle.kts"

# Add imports only if they don't already exist
if ! grep -q "import java.io.FileInputStream" "$GRADLE_FILE"; then
    sed -i '1s/^/import java.io.FileInputStream\n/' "$GRADLE_FILE"
fi

if ! grep -q "import java.util.Properties" "$GRADLE_FILE"; then
    sed -i '1s/^/import java.util.Properties\n/' "$GRADLE_FILE"
fi

# Add signing config before buildTypes (only if not already added)
if ! grep -q "signingConfigs" "$GRADLE_FILE"; then
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
fi

# Update release buildType to use signing config (only if not already done)
if ! grep -q 'signingConfig = signingConfigs.getByName("release")' "$GRADLE_FILE"; then
    sed -i 's/getByName("release") {/getByName("release") {\n            signingConfig = signingConfigs.getByName("release")/' "$GRADLE_FILE"
fi

echo "Android signing patched successfully"
