# release.ps1
$ErrorActionPreference = "Stop"

# Paths & IDs
$apkPath = "build\app\outputs\flutter-apk\app-release.apk"
$firebaseAppId = "1:725835190067:android:50a3f907dd986f7ce53846"
$testerGroup = "testers"

# 1️⃣ Build APK
Write-Host "Building Flutter release APK..." -ForegroundColor Cyan
flutter build apk --release

# 2️⃣ Verify APK exists
if (-not (Test-Path $apkPath)) {
    Write-Host "❌ APK not found at $apkPath" -ForegroundColor Red
    exit 1
}

# 3️⃣ Upload APK using GROUP
Write-Host "Uploading APK to Firebase App Distribution..." -ForegroundColor Cyan

$firebaseArgs = @(
    "appdistribution:distribute"
    $apkPath
    "--app"
    $firebaseAppId
    "--groups"
    $testerGroup
    "--release-notes"
    "Bug fixes and performance improvements"
)

Start-Process -NoNewWindow -Wait -FilePath "firebase.cmd" -ArgumentList $firebaseArgs

Write-Host "✅ Release process completed!" -ForegroundColor Green

firebase.cmd appdistribution:distribute $apkPath `
  --app $firebaseAppId `
  --groups $testerGroup `
  --release-notes "Bug fixes and performance improvements"

