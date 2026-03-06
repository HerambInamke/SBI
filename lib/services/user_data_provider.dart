import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/artisan.dart';
import '../models/product.dart';
import '../models/order.dart';
import 'firestore_service.dart';

class UserDataProvider extends ChangeNotifier {
  static final UserDataProvider _instance = UserDataProvider._internal();
  factory UserDataProvider() => _instance;
  UserDataProvider._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Artisan? _currentArtisan;
  List<Product> _products = [];
  List<Order> _orders = [];
  bool _isLoading = false;

  // Getters
  User? get currentUser => _auth.currentUser;
  Artisan? get currentArtisan => _currentArtisan;
  List<Product> get products => _products;
  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _auth.currentUser != null;

  String get artisanId => _auth.currentUser?.uid ?? '';

  // Computed properties
  int get pendingOrdersCount => _orders.where((o) => o.status == OrderStatus.pending).length;
  int get totalOrdersCount => _orders.length;
  double get totalRevenue => _orders
      .where((o) => o.status == OrderStatus.delivered)
      .fold(0.0, (sum, o) => sum + o.totalPrice);
  int get productsCount => _products.length;

  // Initialize user data after login
  Future<void> loadUserData() async {
    if (currentUser == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      // Load artisan profile
      _currentArtisan = await _firestoreService.getArtisan(currentUser!.uid);
      
      // Load products
      _products = await _firestoreService.getArtisanProducts(currentUser!.uid);
      
      // Load orders
      _orders = await _firestoreService.getArtisanOrders(currentUser!.uid);
    } catch (e) {
      debugPrint('Error loading user data: $e');
      // Initialize with empty data on error
      _currentArtisan = null;
      _products = [];
      _orders = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Refresh products
  Future<void> refreshProducts() async {
    if (currentUser == null) return;
    try {
      _products = await _firestoreService.getArtisanProducts(currentUser!.uid);
      notifyListeners();
    } catch (e) {
      debugPrint('Error refreshing products: $e');
    }
  }

  // Refresh orders
  Future<void> refreshOrders() async {
    if (currentUser == null) return;
    try {
      _orders = await _firestoreService.getArtisanOrders(currentUser!.uid);
      notifyListeners();
    } catch (e) {
      debugPrint('Error refreshing orders: $e');
    }
  }

  // Add product
  Future<String?> addProduct(Product product) async {
    try {
      final productId = await _firestoreService.createProduct(product, artisanId);
      await refreshProducts();
      
      // Update artisan product count
      if (_currentArtisan != null) {
        await _firestoreService.updateArtisanFields(_currentArtisan!.id, {
          'totalProducts': _products.length,
        });
      }
      
      return productId;
    } catch (e) {
      debugPrint('Error adding product: $e');
      return null;
    }
  }

  // Update product
  Future<bool> updateProduct(String productId, Map<String, dynamic> data) async {
    try {
      await _firestoreService.updateProductFields(productId, data);
      await refreshProducts();
      return true;
    } catch (e) {
      debugPrint('Error updating product: $e');
      return false;
    }
  }

  // Delete product
  Future<bool> deleteProduct(String productId) async {
    try {
      await _firestoreService.deleteProduct(productId);
      await refreshProducts();
      return true;
    } catch (e) {
      debugPrint('Error deleting product: $e');
      return false;
    }
  }

  // Update order status
  Future<bool> updateOrderStatus(String orderId, OrderStatus status) async {
    try {
      await _firestoreService.updateOrderStatus(orderId, status);
      await refreshOrders();
      return true;
    } catch (e) {
      debugPrint('Error updating order: $e');
      return false;
    }
  }

  // Update artisan profile
  Future<bool> updateProfile(Map<String, dynamic> data) async {
    if (currentUser == null) return false;
    try {
      await _firestoreService.updateArtisanFields(currentUser!.uid, data);
      _currentArtisan = await _firestoreService.getArtisan(currentUser!.uid);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error updating profile: $e');
      return false;
    }
  }

  // Clear data on logout
  void clearData() {
    _currentArtisan = null;
    _products = [];
    _orders = [];
    notifyListeners();
  }

  // Categories
  List<String> getCategories() {
    return [
      'All',
      'Woodwork',
      'Pottery',
      'Textile',
      'Metalwork',
      'Jewelry',
      'Paintings',
      'Other',
    ];
  }
}
