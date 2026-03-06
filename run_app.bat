@echo off
echo ========================================
echo ApnaKaarigar App Launcher
echo ========================================
echo.

echo Checking Flutter installation...
flutter doctor -v
echo.

echo Cleaning build cache...
flutter clean
echo.

echo Getting dependencies...
flutter pub get
echo.

echo Starting app...
echo.
echo NOTE: If the app crashes, check the console output above for errors.
echo.

flutter run

pause
