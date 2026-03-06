import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import '../models/order.dart' as app_models;
import '../models/artisan.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection references
  CollectionReference<Map<String, dynamic>> get _artisansCollection =>
      _db.collection('artisans');
  
  CollectionReference<Map<String, dynamic>> get _productsCollection =>
      _db.collection('products');
  
  CollectionReference<Map<String, dynamic>> get _ordersCollection =>
      _db.collection('orders');

  // ==================== ARTISAN OPERATIONS ====================

  // Create artisan profile
  Future<void> createArtisan(Artisan artisan) async {
    await _artisansCollection.doc(artisan.id).set(artisan.toJson());
  }

  // Get artisan by ID
  Future<Artisan?> getArtisan(String artisanId) async {
    final doc = await _artisansCollection.doc(artisanId).get();
    if (doc.exists) {
      return Artisan.fromJson({...doc.data()!, 'id': doc.id});
    }
    return null;
  }

  // Update artisan profile
  Future<void> updateArtisan(Artisan artisan) async {
    await _artisansCollection.doc(artisan.id).update(artisan.toJson());
  }

  // Update artisan fields (partial update)
  Future<void> updateArtisanFields(String artisanId, Map<String, dynamic> data) async {
    await _artisansCollection.doc(artisanId).update(data);
  }

  // Stream artisan data
  Stream<Artisan?> streamArtisan(String artisanId) {
    return _artisansCollection.doc(artisanId).snapshots().map((doc) {
      if (doc.exists) {
        return Artisan.fromJson({...doc.data()!, 'id': doc.id});
      }
      return null;
    });
  }

  // ==================== PRODUCT OPERATIONS ====================

  // Create product
  Future<String> createProduct(Product product, String artisanId) async {
    final docRef = await _productsCollection.add({
      ...product.toJson(),
      'artisanId': artisanId,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  // Get product by ID
  Future<Product?> getProduct(String productId) async {
    final doc = await _productsCollection.doc(productId).get();
    if (doc.exists) {
      return Product.fromJson({...doc.data()!, 'id': doc.id});
    }
    return null;
  }

  // Update product
  Future<void> updateProduct(Product product) async {
    await _productsCollection.doc(product.id).update({
      ...product.toJson(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Update product fields (partial update)
  Future<void> updateProductFields(String productId, Map<String, dynamic> data) async {
    await _productsCollection.doc(productId).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Delete product
  Future<void> deleteProduct(String productId) async {
    await _productsCollection.doc(productId).delete();
  }

  // Get all products for an artisan
  Future<List<Product>> getArtisanProducts(String artisanId) async {
    final query = await _productsCollection
        .where('artisanId', isEqualTo: artisanId)
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs
        .map((doc) => Product.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  // Stream products for an artisan
  Stream<List<Product>> streamArtisanProducts(String artisanId) {
    return _productsCollection
        .where('artisanId', isEqualTo: artisanId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Product.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  // Search products by category
  Future<List<Product>> getProductsByCategory(String artisanId, String category) async {
    final query = await _productsCollection
        .where('artisanId', isEqualTo: artisanId)
        .where('category', isEqualTo: category)
        .get();

    return query.docs
        .map((doc) => Product.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  // Update product stock
  Future<void> updateProductStock(String productId, int newQuantity) async {
    await _productsCollection.doc(productId).update({
      'stockQuantity': newQuantity,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ==================== ORDER OPERATIONS ====================

  // Create order
  Future<String> createOrder(app_models.Order order) async {
    final docRef = await _ordersCollection.add({
      ...order.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  // Get order by ID
  Future<app_models.Order?> getOrder(String orderId) async {
    final doc = await _ordersCollection.doc(orderId).get();
    if (doc.exists) {
      return app_models.Order.fromJson({...doc.data()!, 'id': doc.id});
    }
    return null;
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId, app_models.OrderStatus status) async {
    await _ordersCollection.doc(orderId).update({
      'status': status.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Get all orders for an artisan
  Future<List<app_models.Order>> getArtisanOrders(String artisanId) async {
    final query = await _ordersCollection
        .where('artisanId', isEqualTo: artisanId)
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs
        .map((doc) => app_models.Order.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  // Stream orders for an artisan
  Stream<List<app_models.Order>> streamArtisanOrders(String artisanId) {
    return _ordersCollection
        .where('artisanId', isEqualTo: artisanId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => app_models.Order.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  // Get orders by status
  Future<List<app_models.Order>> getOrdersByStatus(String artisanId, app_models.OrderStatus status) async {
    final query = await _ordersCollection
        .where('artisanId', isEqualTo: artisanId)
        .where('status', isEqualTo: status.name)
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs
        .map((doc) => app_models.Order.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  // Get pending orders count
  Future<int> getPendingOrdersCount(String artisanId) async {
    final query = await _ordersCollection
        .where('artisanId', isEqualTo: artisanId)
        .where('status', isEqualTo: 'pending')
        .count()
        .get();
    
    return query.count ?? 0;
  }

  // ==================== ANALYTICS OPERATIONS ====================

  // Get total revenue
  Future<double> getTotalRevenue(String artisanId) async {
    final query = await _ordersCollection
        .where('artisanId', isEqualTo: artisanId)
        .where('status', isEqualTo: 'delivered')
        .get();

    double total = 0;
    for (var doc in query.docs) {
      total += (doc.data()['totalPrice'] as num?)?.toDouble() ?? 0;
    }
    return total;
  }

  // Get order count by status
  Future<Map<String, int>> getOrderCountsByStatus(String artisanId) async {
    final query = await _ordersCollection
        .where('artisanId', isEqualTo: artisanId)
        .get();

    final counts = <String, int>{};
    for (var doc in query.docs) {
      final status = doc.data()['status'] as String? ?? 'unknown';
      counts[status] = (counts[status] ?? 0) + 1;
    }
    return counts;
  }
}
