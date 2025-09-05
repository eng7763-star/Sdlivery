# Sdelivery – Flutter + Firebase (Driver/Student/Admin)

Quick start:
1) Add your Firebase files:
   - Put your `google-services.json` into `android/app/google-services.json` (replace the placeholder).
2) Install deps:
   ```bash
   flutter pub get
   ```
3) Run locally:
   ```bash
   flutter run
   ```
4) GitHub Actions:
   - Add repo *Secrets*: `GOOGLE_SERVICES_JSON`, `KEYSTORE_BASE64`, `KEYSTORE_PASSWORD`, `KEY_ALIAS`, `KEY_PASSWORD`, `PLAY_STORE_JSON` (optional).
   - Workflows included:
     - `.github/workflows/build-apk.yml` (debug APK artifact)
     - `.github/workflows/build-release.yml` (release APK + AAB artifacts)
     - `.github/workflows/release-on-tag.yml` (publish to Play on tag)
