# release.ps1
$ErrorActionPreference = "Stop"

# Paths & IDs
$apkPath = "build\app\outputs\flutter-apk\app-release.apk"
$firebaseAppId = "1:725835190067:android:50a3f907dd986f7ce53846"
$testerGroup = "testers"
$testerEmails = "tester1nouransamer5@gmail.com,tester2alibesar28@gmail.com,tester3rahmaashraf.dev@gmail.com"

# 1️⃣ Build APK
Write-Host "Building Flutter release APK..." -ForegroundColor Cyan
flutter build apk --release

# 2️⃣ Verify APK exists
if (-not (Test-Path $apkPath)) {
    Write-Host "❌ APK not found at $apkPath" -ForegroundColor Red
    exit 1
}

# 3️⃣ Upload APK — use firebase.cmd for Windows
Write-Host "Uploading APK to Firebase App Distribution..." -ForegroundColor Cyan

# Use either group OR testers, not both at the same time if you know one exists
$firebaseArgs = @(
    "appdistribution:distribute"
    $apkPath
    "--app"
    $firebaseAppId
    "--testers"
    $testerEmails
)

# Run firebase.cmd instead of firebase
Start-Process -NoNewWindow -Wait -FilePath "firebase.cmd" -ArgumentList $firebaseArgs

Write-Host "✅ Release process completed!" -ForegroundColor Green
