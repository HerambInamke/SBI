# ApnaKaarigar - New UI Implementation

## Overview

This document describes the new modern Flutter marketplace UI implementation for ApnaKaarigar, featuring separate buyer and seller experiences with Material Design 3 and an earthy craft-inspired theme.

## Design System

### Color Palette
- **Primary**: #9CAF88 (Sage Green)
- **Accent**: #C6A75E (Soft Gold)
- **Background**: #F4F1EA (Soft Cream)
- **Text**: #2E2E2E (Charcoal)

### Design Principles
- Warm and artisan-inspired
- Minimal and modern marketplace feel
- Card layouts with rounded containers
- Large product images
- Subtle shadows
- Simple bottom navigation

## Implemented Screens

### 1. Welcome Screen (`welcome_screen.dart`)
**Purpose**: Entry point for the application

**Features**:
- App logo with sage green branding
- Tagline: "Empowering Indian Artisans"
- Two primary action buttons:
  - Continue as Buyer (filled button)
  - Continue as Seller (outlined button)

**Navigation**:
- Buyer button → Buyer Login Screen
- Seller button → Seller Login Screen

---

### 2. Buyer Login Screen (`buyer_login_screen.dart`)
**Purpose**: Authentication for buyers

**Features**:
- Clean minimal form with craft-themed illustration
- Email/Phone input field
- Password field with show/hide toggle
- "Forgot Password?" link
- Login button with loading state
- Google Sign-In button with Google logo
- Sign-up link for new users

**Form Validation**:
- Required field validation
- Email/phone format validation
- Password minimum length check

**Navigation**:
- Login success → Buyer Home Screen
- Sign up link → Buyer Signup Screen
- Google login → Buyer Home Screen

---

### 3. Seller Login Screen (`seller_login_screen.dart`)
**Purpose**: Authentication for artisan sellers

**Features**:
- Store-themed illustration
- Tagline: "Join thousands of Indian artisans selling handmade products"
- Toggle between Password and OTP login methods
- Email/Phone input (changes based on login method)
- Password field (only for password method)
- "Forgot Password?" link
- Login/Send OTP button with loading state
- Google Sign-In button
- "Register as Artisan" link

**Unique Features**:
- Dual authentication method (Password/OTP)
- Dynamic form fields based on selected method

**Navigation**:
- Register link → Seller Signup Screen
- Login success → Seller Dashboard (to be implemented)

---

### 4. Buyer Signup Screen (`buyer_signup_screen.dart`)
**Purpose**: New buyer registration

**Features**:
- Full Name field
- Email field
- Phone Number field
- Password field with show/hide toggle
- Create Account button with loading state
- Login link for existing users

**Form Validation**:
- All fields required
- Email format validation
- Password minimum 6 characters
- Phone number validation

---

### 5. Buyer Home Screen (`buyer_home_screen.dart`)
**Purpose**: Main buyer interface with bottom navigation

**Bottom Navigation Tabs**:
1. **Home** - Main feed
2. **Explore** - Browse products
3. **Orders** - Order history
4. **Wishlist** - Saved items
5. **Profile** - User settings

**Home Tab Features**:

#### Header
- Personalized greeting: "Hello, Buyer!"
- Subtitle: "Discover Handcrafted Treasures"
- Notification icon
- Shopping cart icon

#### Search Bar
- Prominent search field
- Placeholder: "Search for crafts, artisans..."
- Filter button (tune icon)
- White background with subtle shadow

#### Featured Crafts Carousel
- Horizontal scrolling cards (320px wide)
- Gradient backgrounds (Sage Green to Soft Gold)
- "NEW ARRIVAL" badge
- Product title and description
- "Explore Now" CTA button
- Decorative background icon

#### Categories Grid
- 3-column grid layout
- 6 categories:
  - Woodwork (carpenter icon)
  - Pottery (flower icon)
  - Textile (clothing icon)
  - Metalwork (handyman icon)
  - Jewelry (diamond icon)
  - Paintings (palette icon)
- Each category has:
  - Circular colored icon background
  - Category name
  - Card with subtle shadow

#### Trending Products
- 2-column grid layout
- Product cards featuring:
  - Product image placeholder
  - Wishlist heart icon (top-right)
  - Product name
  - Artisan name
  - Star rating with review count
  - Price in ₹ (Indian Rupees)
  - Cream-colored cards with rounded corners
  - Tap to view product details

#### Recommended Artisans
- Horizontal scrolling list
- Artisan cards (140px wide) featuring:
  - Circular avatar
  - Artisan name
  - Specialty (e.g., "Woodwork")
  - Star rating
  - Cream-colored cards with rounded corners

---

### 6. Product Detail Screen (`product_detail_screen.dart`)
**Purpose**: Detailed view of a single product

**Features**:

#### Large Product Image Slider
- Full-width image carousel
- Swipe to view multiple product images
- Page indicators showing current image
- Floating back, share, and wishlist buttons

#### Product Information
- Product name (large, bold)
- Star rating with review count
- Number of items sold
- Current price (large, prominent)
- Original price (strikethrough)
- Discount percentage badge

#### Artisan Profile Snippet
- Artisan avatar
- Artisan name
- "Verified Artisan" badge
- "View" button to see full profile

#### Description Section
- Detailed product description
- Multi-line text with proper spacing

#### Materials Used
- Chip-style tags showing materials
- Examples: "Teak Wood", "Natural Varnish", "Hand Tools"

#### Delivery Information
- Highlighted delivery time card
- Shipping icon
- Estimated delivery timeframe

#### Reviews Section
- "Reviews (count)" header with "See All" link
- Review cards showing:
  - Reviewer avatar
  - Reviewer name
  - Star rating
  - Time posted
  - Review text

#### Bottom Action Bar
- Quantity selector (- / number / +)
- "Add to Cart" button (primary color)
- "Buy Now" button (accent color)
- Fixed at bottom with shadow
- Snackbar feedback on actions

**Navigation**:
- Back button returns to previous screen
- Share button (placeholder)
- Wishlist toggle (heart icon)

---

### 7. Placeholder Screens

The following screens are created with basic structure for future implementation:

- **Buyer Explore Screen** (`buyer_explore_screen.dart`)
- **Buyer Orders Screen** (`buyer_orders_screen.dart`)
- **Buyer Wishlist Screen** (`buyer_wishlist_screen.dart`)
- **Buyer Profile Screen** (`buyer_profile_screen.dart`)
- **Seller Signup Screen** (`seller_signup_screen.dart`)

---

## UI Components & Patterns

### Card Design
```dart
Container(
  decoration: BoxDecoration(
    color: AppTheme.cardColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  ),
)
```

### Input Fields
- Filled white background
- 12px border radius
- Sage green focus border
- Prefix icons for context
- Proper validation messages

### Buttons
- **Primary (Elevated)**: Sage green background, white text, 56px height
- **Secondary (Outlined)**: Sage green border, sage green text
- **Loading State**: Circular progress indicator

### Bottom Navigation
- Fixed 5 items
- Outlined icons when inactive
- Filled icons when active
- Sage green selection color
- White background with top shadow

---

## Google Sign-In Integration

Both buyer and seller login screens include Google Sign-In buttons:

```dart
OutlinedButton.icon(
  icon: Image.asset('assets/google_logo.png', height: 24),
  label: const Text('Continue with Google'),
)
```

**Note**: Google logo asset needs to be added to `assets/` folder and referenced in `pubspec.yaml`.

---

## Navigation Flow

```
Welcome Screen
├── Buyer Login
│   ├── Buyer Signup
│   └── Buyer Home (with bottom nav)
│       ├── Home Tab
│       ├── Explore Tab
│       ├── Orders Tab
│       ├── Wishlist Tab
│       └── Profile Tab
└── Seller Login
    ├── Seller Signup
    └── Seller Dashboard (to be implemented)
```

---

## File Structure

```
lib/
├── main.dart                          # App entry point
├── theme/
│   └── app_theme.dart                 # Theme configuration
└── screens/
    ├── welcome_screen.dart            # ✅ Implemented
    ├── buyer_login_screen.dart        # ✅ Implemented
    ├── buyer_signup_screen.dart       # ✅ Implemented
    ├── buyer_home_screen.dart         # ✅ Implemented (with recommended artisans)
    ├── product_detail_screen.dart     # ✅ Implemented
    ├── buyer_explore_screen.dart      # 🔲 Placeholder
    ├── buyer_orders_screen.dart       # 🔲 Placeholder
    ├── buyer_wishlist_screen.dart     # 🔲 Placeholder
    ├── buyer_profile_screen.dart      # 🔲 Placeholder
    ├── seller_login_screen.dart       # ✅ Implemented
    └── seller_signup_screen.dart      # 🔲 Placeholder
```

---

## Next Steps

### Immediate Tasks
1. Add Google logo asset to `assets/` folder
2. Update `pubspec.yaml` to include assets
3. Implement Firebase Google Sign-In authentication
4. Complete Buyer Explore screen with filtering
5. Complete Buyer Orders screen with order tracking
6. Complete Buyer Wishlist screen
7. Complete Buyer Profile screen
8. Implement Seller Signup screen
9. Create Seller Dashboard and related screens
10. Add real product images
11. Implement artisan profile detail page
12. Connect product detail to real data

### Future Enhancements
1. Add product detail screen
2. Implement shopping cart functionality
3. Add payment integration
4. Create artisan profile pages
5. Implement real-time order tracking
6. Add push notifications
7. Implement search functionality
8. Add product filtering and sorting
9. Create review and rating system
10. Add social sharing features

---

## Testing Checklist

- [ ] Welcome screen navigation works
- [ ] Buyer login form validation
- [ ] Seller login form validation
- [ ] Login method toggle (Password/OTP) works
- [ ] Password show/hide toggle works
- [ ] Loading states display correctly
- [ ] Bottom navigation switches tabs
- [ ] Search bar is functional
- [ ] Category cards are tappable
- [ ] Product cards navigate to detail screen
- [ ] Featured carousel scrolls horizontally
- [ ] Recommended artisans scroll horizontally
- [ ] Product detail image slider works
- [ ] Product detail page indicators update
- [ ] Wishlist toggle works on detail page
- [ ] Quantity selector increments/decrements
- [ ] Add to Cart shows feedback
- [ ] Buy Now shows feedback
- [ ] Review cards display correctly
- [ ] Back navigation works from detail page
- [ ] Google Sign-In button appears
- [ ] All screens are responsive
- [ ] Theme colors are consistent
- [ ] Shadows and elevations look good

---

## Known Issues

1. Google logo asset not included - needs to be added
2. Placeholder screens need full implementation
3. Firebase authentication not connected
4. No actual data - using mock/placeholder content
5. Search functionality not implemented
6. Category filtering not implemented
7. Product detail navigation not implemented
8. Wishlist functionality not implemented
9. Cart functionality not implemented

---

## Design Assets Needed

1. **Google Logo**: `assets/google_logo.png`
2. **App Logo**: High-res version for splash screen
3. **Category Icons**: Custom craft-specific icons (optional)
4. **Product Images**: Sample handcraft product photos
5. **Artisan Photos**: Sample artisan profile pictures
6. **Illustrations**: Craft-themed illustrations for empty states

---

**Last Updated**: March 2026
**Version**: 1.0.0
**Status**: Initial Implementation Complete
