@echo off
echo ========================================
echo Android Build Fix and Rebuild Script
echo ========================================
echo.

echo [1/6] Cleaning Flutter build cache...
flutter clean
echo.

echo [2/6] Cleaning Android Gradle cache...
cd android
call gradlew clean
cd ..
echo.

echo [3/6] Removing old build directories...
if exist "android\app\build" rmdir /s /q "android\app\build"
if exist "android\build" rmdir /s /q "android\build"
if exist "build" rmdir /s /q "build"
echo.

echo [4/6] Getting Flutter dependencies...
flutter pub get
echo.

echo [5/6] Verifying MainActivity location...
if exist "android\app\src\main\kotlin\com\apnikaarigar\sbi\MainActivity.kt" (
    echo ✓ MainActivity found in correct location
) else (
    echo ✗ ERROR: MainActivity not found!
    echo Expected: android\app\src\main\kotlin\com\apnikaarigar\sbi\MainActivity.kt
    pause
    exit /b 1
)
echo.

echo [6/6] Building and running app...
echo.
echo NOTE: This will take a few minutes on first build...
echo.
flutter run

pause
