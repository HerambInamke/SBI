# ApnaKaarigar - Troubleshooting Guide

## App Keeps Crashing - Fixed Issues

### ✅ Issues Fixed:

1. **Argument Mismatch Errors** - All method signatures now match their calls
2. **Data Parsing Crashes** - Safe parsing for Firestore Timestamps and null values
3. **Empty Image Arrays** - Proper checks before accessing product images
4. **Order Status Parsing** - Handles both string and integer status values
5. **Missing Error Handling** - Added try-catch blocks in critical paths
6. **Empty Data States** - Graceful handling when no products/orders exist

### 🔧 How to Run the App:

#### Option 1: Using the Batch File (Windows)
```bash
run_app.bat
```

#### Option 2: Manual Commands
```bash
# Clean build cache
flutter clean

# Get dependencies
flutter pub get

# Run the app
flutter run
```

### 📱 Testing the App:

1. **First Launch**: The app will show the login/signup screen
2. **Create Account**: Sign up with email and password
3. **Empty State**: You'll see empty products/orders - this is normal for new accounts
4. **Add Products**: Use the "Add Product" button to create your first product

### 🐛 If App Still Crashes:

#### Check Console Output
Look for error messages in the console. Common issues:

1. **Firebase Connection Error**
   - Ensure you have internet connection
   - Check if Firebase project is properly configured
   - Verify `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) exists

2. **Build Errors**
   ```bash
   flutter clean
   flutter pub get
   flutter pub upgrade
   ```

3. **Gradle Issues (Android)**
   ```bash
   cd android
   ./gradlew clean
   cd ..
   flutter run
   ```

#### Enable Debug Logging
Add this to see detailed logs:
```bash
flutter run --verbose
```

### 🔍 Common Error Messages:

#### "PlatformException"
- Usually Firebase initialization issue
- Check internet connection
- Verify Firebase configuration files

#### "Null check operator used on a null value"
- This should be fixed now with safe null checks
- If you see this, note which file/line and report it

#### "RangeError (index): Invalid value"
- This was caused by empty image arrays - now fixed
- If you see this, it might be in a different location

### 📊 Checking Firestore Data:

1. Go to Firebase Console
2. Navigate to Firestore Database
3. Check if these collections exist:
   - `artisans` - Should have your user profile
   - `products` - Will be empty initially
   - `orders` - Will be empty initially

### 🆘 Still Having Issues?

1. **Clear App Data** (if testing on device):
   - Settings > Apps > ApnaKaarigar > Clear Data

2. **Reinstall the App**:
   ```bash
   flutter clean
   flutter pub get
   flutter run --uninstall-first
   ```

3. **Check Flutter Version**:
   ```bash
   flutter --version
   ```
   Should be Flutter 3.x or higher

4. **Check Dart Version**:
   ```bash
   dart --version
   ```
   Should be Dart 3.11.0 or higher

### 📝 Reporting Issues:

If the app still crashes, provide:
1. Full console output
2. Steps to reproduce
3. Device/emulator information
4. Screenshot of error (if visible)

### ✨ Features Working:

- ✅ User Authentication (Email/Password)
- ✅ Empty state handling
- ✅ Safe data loading
- ✅ Error boundaries
- ✅ Graceful fallbacks
- ✅ Image loading with placeholders
- ✅ Null-safe data parsing

### 🎯 Next Steps After App Runs:

1. Create your artisan profile
2. Add your first product
3. Test the AI assistant
4. Explore all features

---

**Note**: The fixes applied ensure the app won't crash even with:
- Empty Firestore collections
- Missing images
- Null data fields
- Network errors
- Invalid data formats
