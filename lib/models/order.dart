enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
}

class Order {
  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final String buyerName;
  final String buyerPhone;
  final String buyerAddress;
  final int quantity;
  final double totalPrice;
  final OrderStatus status;
  final DateTime orderedAt;
  final DateTime? deliveredAt;
  final String? notes;
  final String artisanId;

  Order({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.buyerName,
    required this.buyerPhone,
    required this.buyerAddress,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.orderedAt,
    this.deliveredAt,
    this.notes,
    required this.artisanId,
  });

  Order copyWith({
    String? id,
    String? productId,
    String? productName,
    String? productImage,
    String? buyerName,
    String? buyerPhone,
    String? buyerAddress,
    int? quantity,
    double? totalPrice,
    OrderStatus? status,
    DateTime? orderedAt,
    DateTime? deliveredAt,
    String? notes,
    String? artisanId,
  }) {
    return Order(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      buyerName: buyerName ?? this.buyerName,
      buyerPhone: buyerPhone ?? this.buyerPhone,
      buyerAddress: buyerAddress ?? this.buyerAddress,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      orderedAt: orderedAt ?? this.orderedAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      notes: notes ?? this.notes,
      artisanId: artisanId ?? this.artisanId,
    );
  }

  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'buyerName': buyerName,
      'buyerPhone': buyerPhone,
      'buyerAddress': buyerAddress,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'status': status.index,
      'orderedAt': orderedAt.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
      'notes': notes,
      'artisanId': artisanId,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    // Parse status safely - handle both string and int
    OrderStatus status;
    try {
      if (json['status'] is String) {
        status = OrderStatus.values.firstWhere(
          (e) => e.name == json['status'],
          orElse: () => OrderStatus.pending,
        );
      } else if (json['status'] is int) {
        status = OrderStatus.values[json['status']];
      } else {
        status = OrderStatus.pending;
      }
    } catch (e) {
      status = OrderStatus.pending;
    }

    // Parse dates safely
    DateTime orderedAt;
    try {
      if (json['orderedAt'] is String) {
        orderedAt = DateTime.parse(json['orderedAt']);
      } else if (json['orderedAt'] != null) {
        orderedAt = (json['orderedAt'] as dynamic).toDate();
      } else {
        orderedAt = DateTime.now();
      }
    } catch (e) {
      orderedAt = DateTime.now();
    }

    DateTime? deliveredAt;
    try {
      if (json['deliveredAt'] != null) {
        if (json['deliveredAt'] is String) {
          deliveredAt = DateTime.parse(json['deliveredAt']);
        } else {
          deliveredAt = (json['deliveredAt'] as dynamic).toDate();
        }
      }
    } catch (e) {
      deliveredAt = null;
    }

    return Order(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? 'Unknown Product',
      productImage: json['productImage'] ?? '',
      buyerName: json['buyerName'] ?? 'Unknown Buyer',
      buyerPhone: json['buyerPhone'] ?? '',
      buyerAddress: json['buyerAddress'] ?? '',
      quantity: json['quantity'] ?? 1,
      totalPrice: ((json['totalPrice'] as num?)?.toDouble()) ?? 0.0,
      status: status,
      orderedAt: orderedAt,
      deliveredAt: deliveredAt,
      notes: json['notes'],
      artisanId: json['artisanId'] ?? '',
    );
  }
}
