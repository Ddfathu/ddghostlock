#!/bin/bash
set -e

# Target perubahan
NEW_PKG="com.kunci.setan"
NEW_APP_NAME="KunciSetan"

# Asal perubahan (hasil dari run sebelumnya)
OLD_PKG="com.mycustom.ghostlock"
OLD_PATH="com/mycustom/ghostlock"
NEW_PATH="${NEW_PKG//.//}"

echo "[*] Mengganti ke nama dan package baru..."
echo "[*] Package: $OLD_PKG -> $NEW_PKG"
echo "[*] Nama   : $NEW_APP_NAME"

# 1. Update Nama Aplikasi
sed -i -E "s|<string name=\"app_name\">.*</string>|<string name=\"app_name\">$NEW_APP_NAME</string>|g" app/src/main/res/values/strings.xml
if [ -f app/src/main/res/values-zh/strings.xml ]; then
    sed -i -E "s|<string name=\"app_name\">.*</string>|<string name=\"app_name\">$NEW_APP_NAME</string>|g" app/src/main/res/values-zh/strings.xml
fi

# 2. Update Gradle & AndroidManifest
find . -maxdepth 3 -type f \( -name "*.gradle.kts" -o -name "AndroidManifest.xml" \) -exec sed -i "s|$OLD_PKG|$NEW_PKG|g" {} +

# 3. Update kode Kotlin dan AIDL
find app/src/ profile-core/src/ -type f \( -name "*.kt" -o -name "*.aidl" \) -exec sed -i "s|$OLD_PKG|$NEW_PKG|g" {} +

# 4. Pindahkan folder direktori package
move_package_dir() {
    local base_dir="$1"
    if [ -d "$base_dir/$OLD_PATH" ]; then
        echo "[+] Pindah folder: $base_dir/$OLD_PATH -> $base_dir/$NEW_PATH"
        mkdir -p "$base_dir/$NEW_PATH"
        cp -r "$base_dir/$OLD_PATH"/* "$base_dir/$NEW_PATH"/
        rm -rf "$base_dir/$OLD_PATH"
        find "$base_dir" -type d -empty -delete 2>/dev/null || true
    fi
}

move_package_dir "app/src/main/kotlin"
move_package_dir "app/src/main/aidl"
move_package_dir "app/src/test/kotlin"
move_package_dir "profile-core/src/main/kotlin"
move_package_dir "profile-core/src/test/kotlin"

# 5. Beri izin execute ke gradlew & bersihkan cache
chmod +x gradlew
./gradlew clean

echo "[✓] Selesai diubah ke $NEW_PKG!"
