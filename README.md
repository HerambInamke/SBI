# ApnaKaarigar 🎨

A Flutter-based mobile marketplace platform empowering Indian artisans and craftspeople to showcase, manage, and sell their handcrafted products directly to customers.

## 📱 About

ApnaKaarigar (meaning "Our Artisan" in Hindi) is a comprehensive business management solution designed specifically for traditional Indian artisans. The platform enables craftspeople to digitize their businesses, manage inventory, track orders, and leverage AI-powered tools to enhance their product listings and marketing efforts.

## ✨ Key Features

### 🔐 Authentication & Profile Management
- Email/password authentication
- Phone number OTP verification
- Artisan profile with shop details
- Verification badge system
- Profile customization with images

### 📦 Product Management
- Add/edit/delete products with multiple images
- Support for various craft categories:
  - Woodwork
  - Pottery
  - Textile
  - Metalwork
  - Jewelry
  - Paintings
  - Other crafts
- Stock quantity tracking
- Product ratings and reviews
- AI-generated product descriptions
- Tag and keyword management

### 📋 Order Management
- Real-time order tracking with status updates:
  - Pending → Confirmed → Processing → Shipped → Delivered/Cancelled
- Order history with buyer details
- Pending orders alerts
- Revenue analytics
- Order count by status

### 🏠 Dashboard
- Artisan profile overview
- Key metrics at a glance:
  - Total products
  - Total orders
  - Revenue tracking
- Pending orders notifications
- Quick action buttons
- Recent products grid

### 🤖 AI Assistant
- Generate compelling product descriptions
- Create marketing content for social media (Instagram, WhatsApp, Facebook)
- Pricing suggestions based on material cost and labor
- Product tag generation
- Chat-based assistance

### 📊 Analytics
- Total revenue calculation
- Order statistics by status
- Product performance tracking
- Sales insights

## 🛠️ Tech Stack

### Framework & Language
- **Flutter** 3.x
- **Dart** 3.11.0+

### Backend & Services
- **Firebase Core** 3.8.1
- **Firebase Authentication** 5.3.4
- **Cloud Firestore** 5.6.0
- **Firebase Storage** 12.4.0

### UI & Media
- **Material Design 3** with custom theme
- **Image Picker** 1.1.2
- **Cached Network Image** 3.4.1

### Utilities
- **UUID** 4.5.1
- **Intl** 0.20.1

## 🎨 Design System

The app features a calming, earthy color palette inspired by traditional Indian crafts:

- **Primary**: Sage Green (#9CAF88)
- **Accent**: Soft Gold (#C6A75E)
- **Background**: Soft Cream (#F4F1EA)
- **Text**: Charcoal (#2E2E2E)

## 📁 Project Structure

```
lib/
├── main.dart                      # App entry point
├── firebase_options.dart          # Firebase configuration
├── models/                        # Data models
│   ├── product.dart
│   ├── order.dart
│   └── artisan.dart
├── screens/                       # UI screens
│   ├── auth_wrapper.dart
│   ├── auth_screen.dart
│   ├── home_screen.dart
│   ├── products_screen.dart
│   ├── add_product_screen.dart
│   ├── product_detail_screen.dart
│   ├── orders_screen.dart
│   ├── ai_assistant_screen.dart
│   └── profile_screen.dart
├── services/                      # Business logic
│   ├── auth_service.dart
│   ├── firestore_service.dart
│   ├── storage_service.dart
│   ├── ai_service.dart
│   ├── user_data_provider.dart
│   └── mock_data_service.dart
├── theme/
│   └── app_theme.dart
└── widgets/                       # Reusable components
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.x or higher
- Dart 3.11.0 or higher
- Android Studio / Xcode (for mobile development)
- Firebase account

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_application_1
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication (Email/Password and Phone)
   - Create a Firestore database
   - Enable Firebase Storage
   - Download configuration files:
     - Android: `google-services.json` → `android/app/`
     - iOS: `GoogleService-Info.plist` → `ios/Runner/`

4. **Run the app**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android
The app is configured with package name: `com.apnikaarigar.sbi`

If you encounter build issues:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

#### iOS
```bash
cd ios
pod install
cd ..
flutter run
```

#### Web
```bash
flutter run -d chrome
```

## 🔧 Configuration

### Firebase Collections

The app uses three main Firestore collections:

1. **artisans** - Artisan profiles
   - Profile information
   - Shop details
   - Verification status
   - Ratings and statistics

2. **products** - Product listings
   - Product details
   - Images and pricing
   - Stock management
   - Ratings and reviews

3. **orders** - Order records
   - Order details
   - Status tracking
   - Buyer information
   - Payment details

### Firebase Storage Structure

```
artisans/
└── {artisanId}/
    ├── profile.jpg
    └── products/
        └── {productId}/
            └── {imageUUID}.jpg
```

## 📖 Documentation

Additional documentation is available in the `DOCS/` folder:

- **FIX_ANDROID_CRASH.md** - Android package structure and troubleshooting
- **PACKAGE_STRUCTURE_EXPLAINED.md** - Detailed Android package configuration
- **TROUBLESHOOTING.md** - Common issues and solutions

## 🐛 Known Issues & Fixes

### Android ClassNotFoundException
If you encounter `ClassNotFoundException` on Android, ensure:
- Package name matches in `build.gradle.kts`, `AndroidManifest.xml`, and `MainActivity.kt`
- Folder structure matches package name: `kotlin/com/apnikaarigar/sbi/`

See `DOCS/FIX_ANDROID_CRASH.md` for detailed fix instructions.

### App Crashes
All major crash issues have been fixed:
- ✅ Safe null handling
- ✅ Empty state management
- ✅ Proper error boundaries
- ✅ Graceful data parsing

See `DOCS/TROUBLESHOOTING.md` for more information.

## 🧪 Testing

### Running Tests
```bash
flutter test
```

### Testing the App
1. Launch the app
2. Create an account using email/password
3. Complete your artisan profile
4. Add your first product
5. Test the AI assistant features
6. Explore order management

## 🔒 Security

- Firebase Authentication for secure user management
- Firestore security rules (configure in Firebase Console)
- Storage security rules for image uploads
- No sensitive data stored locally

## 🌐 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows

## 📝 License

This project is private and not published to pub.dev.

## 🤝 Contributing

This is a private project. For contributions or questions, please contact the project maintainers.

## 📧 Support

For issues or questions:
1. Check the `DOCS/` folder for troubleshooting guides
2. Review Firebase Console for backend issues
3. Check Flutter logs: `flutter run --verbose`

## 🎯 Roadmap

- [ ] Real AI API integration (OpenAI, Google AI)
- [ ] Payment gateway integration
- [ ] Customer-facing marketplace app
- [ ] Multi-language support
- [ ] Advanced analytics dashboard
- [ ] Social media integration
- [ ] Inventory management alerts
- [ ] Bulk product upload

## 🙏 Acknowledgments

Built with Flutter and Firebase to empower traditional Indian artisans in the digital age.

---

**Version**: 1.0.0+1  
**Last Updated**: March 2026
