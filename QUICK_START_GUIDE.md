# ApnaKaarigar - Quick Start Guide

## 🚀 Running the App

```bash
# Clean and get dependencies
flutter clean
flutter pub get

# Run the app
flutter run
```

## 📱 Navigation Guide

### Buyer Flow
1. **Welcome Screen** → Tap "Continue as Buyer"
2. **Login Screen** → Enter credentials or tap "Sign Up"
3. **Home Screen** → Browse products, categories, artisans
4. **Product Detail** → Tap any product card
5. **Cart** → Tap "Add to Cart" button
6. **Checkout** → Fill address and payment details
7. **Order Success** → View confirmation
8. **Orders** → Track your orders (bottom nav)
9. **Profile** → Manage account (bottom nav)

### Seller Flow
1. **Welcome Screen** → Tap "Continue as Seller"
2. **Login Screen** → Enter credentials (Password or OTP)
3. **Dashboard** → View stats and quick actions
4. **Products** → Manage inventory (bottom nav)
5. **Orders** → Process orders (bottom nav)
6. **AI Assistant** → Get help (bottom nav)
7. **Profile** → Settings (bottom nav)

## 🎨 Key Screens

### Buyer Screens (Fully Functional)
- ✅ Home with search, categories, products
- ✅ Product detail with reviews
- ✅ Cart with quantity management
- ✅ Checkout with form validation
- ✅ Orders with tracking progress
- ✅ Profile with settings

### Seller Screens
- ✅ Dashboard with analytics
- 🔲 Products (placeholder)
- 🔲 Orders (placeholder)
- 🔲 AI Assistant (placeholder)
- 🔲 Profile (placeholder)

## 🔧 Testing Features

### Cart & Checkout
```
1. Browse products on home screen
2. Tap any product → Product Detail
3. Adjust quantity → Tap "Add to Cart"
4. View cart → Adjust quantities
5. Tap "Proceed to Checkout"
6. Fill delivery address
7. Select payment method
8. Tap "Place Order"
9. See success screen
```

### Order Tracking
```
1. Go to Orders tab (bottom nav)
2. View order list with status
3. See progress bar for active orders
4. Tap "Track Order" or "View Details"
```

### Profile Management
```
1. Go to Profile tab (bottom nav)
2. View stats (Orders, Wishlist)
3. Access account settings
4. Manage addresses, payment methods
5. Logout option at bottom
```

## 🎯 Demo Credentials

### Buyer
- Email: buyer@test.com
- Password: test123

### Seller
- Email: seller@test.com
- Password: test123
- Or use OTP option

## 📊 Seller Dashboard Features

### Stats Cards
- Revenue: ₹45,230
- Orders: 127
- Products: 24
- Rating: 4.8

### Quick Actions
- Add Product
- AI Assistant

### Alerts
- Pending Orders notification

## 🎨 Design System

### Colors
```dart
Primary: #9CAF88 (Sage Green)
Accent: #C6A75E (Soft Gold)
Background: #F4F1EA (Soft Cream)
Text: #2E2E2E (Charcoal)
```

### Components
- Card radius: 16px
- Button height: 56px
- Shadow: 0.05 alpha
- Bottom nav: 5 items

## 📝 Known Limitations

1. **Mock Data**: All products, orders, artisans use placeholder data
2. **Images**: Using icon placeholders (add real images to assets/)
3. **Firebase**: Not connected (authentication is simulated)
4. **Google Sign-In**: Button present but not functional
5. **Search**: UI present but not functional
6. **Filters**: UI present but not functional
7. **Wishlist**: Icon present but not saving
8. **Seller Screens**: 4 tabs are placeholders

## 🔜 Next Steps

### Priority 1 - Data Integration
- [ ] Connect to Firebase
- [ ] Implement real authentication
- [ ] Load products from Firestore
- [ ] Save cart to database
- [ ] Process real orders

### Priority 2 - Complete Features
- [ ] Implement search functionality
- [ ] Add category filtering
- [ ] Complete wishlist feature
- [ ] Implement seller product management
- [ ] Add seller order processing

### Priority 3 - Assets
- [ ] Add Google logo
- [ ] Add product images
- [ ] Add artisan photos
- [ ] Add app logo
- [ ] Add category icons

## 🐛 Troubleshooting

### App won't run
```bash
flutter clean
flutter pub get
flutter run
```

### Build errors
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter run
```

### Hot reload not working
- Press 'r' in terminal
- Or restart app with 'R'

## 📞 Support

For issues or questions:
1. Check DOCS/TROUBLESHOOTING.md
2. Review DOCS/NEW_UI_IMPLEMENTATION.md
3. Check Firebase Console for backend issues

---

**Happy Testing! 🎉**
