import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SellerOrdersScreen extends StatefulWidget {
  const SellerOrdersScreen({super.key});

  @override
  State<SellerOrdersScreen> createState() => _SellerOrdersScreenState();
}

class _SellerOrdersScreenState extends State<SellerOrdersScreen> {
  final List<SellerOrder> _orders = [
    SellerOrder(
      id: '1001',
      buyerName: 'Priya Sharma',
      buyerPhone: '+91 98765 43210',
      buyerAddress: '123 MG Road, Bangalore, Karnataka - 560001',
      productName: 'Handcrafted Wooden Vase',
      productImage: 'placeholder',
      quantity: 1,
      totalPrice: 1299,
      paymentStatus: 'Paid',
      orderStatus: OrderStatus.pending,
      orderDate: 'Mar 5, 2026',
    ),
    SellerOrder(
      id: '1002',
      buyerName: 'Rahul Verma',
      buyerPhone: '+91 87654 32109',
      buyerAddress: '456 Park Street, Mumbai, Maharashtra - 400001',
      productName: 'Clay Pottery Set',
      productImage: 'placeholder',
      quantity: 2,
      totalPrice: 1798,
      paymentStatus: 'Paid',
      orderStatus: OrderStatus.processing,
      orderDate: 'Mar 4, 2026',
    ),
    SellerOrder(
      id: '1003',
      buyerName: 'Anjali Patel',
      buyerPhone: '+91 76543 21098',
      buyerAddress: '789 Ring Road, Ahmedabad, Gujarat - 380001',
      productName: 'Handwoven Textile',
      productImage: 'placeholder',
      quantity: 1,
      totalPrice: 1599,
      paymentStatus: 'COD',
      orderStatus: OrderStatus.shipped,
      orderDate: 'Mar 3, 2026',
    ),
  ];

  void _updateOrderStatus(int index, OrderStatus newStatus) {
    setState(() {
      _orders[index].orderStatus = newStatus;
    });
    
    String statusText = '';
    switch (newStatus) {
      case OrderStatus.confirmed:
        statusText = 'confirmed';
        break;
      case OrderStatus.processing:
        statusText = 'processing';
        break;
      case OrderStatus.shipped:
        statusText = 'shipped';
        break;
      case OrderStatus.delivered:
        statusText = 'delivered';
        break;
      default:
        statusText = 'updated';
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order $statusText successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Orders Management'),
        backgroundColor: AppTheme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: _orders.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(index);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 100,
            color: AppTheme.textLight.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'No orders yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'Orders will appear here',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textLight,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(int index) {
    final order = _orders[index];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${order.id}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.orderDate,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textLight,
                          ),
                    ),
                  ],
                ),
                _buildStatusChip(order.orderStatus),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Buyer Info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 18, color: AppTheme.primaryColor),
                          const SizedBox(width: 8),
                          Text(
                            'Buyer Information',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        order.buyerName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.buyerPhone,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.buyerAddress,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Product Info
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.image_outlined,
                        size: 35,
                        color: AppTheme.primaryColor.withValues(alpha: 0.3),
                      ),
                    ),
                    
                    const SizedBox(width: 12),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.productName,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Quantity: ${order.quantity}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.textLight,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '₹${order.totalPrice}',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppTheme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: order.paymentStatus == 'Paid'
                                      ? AppTheme.successColor.withValues(alpha: 0.1)
                                      : AppTheme.warningColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  order.paymentStatus,
                                  style: TextStyle(
                                    color: order.paymentStatus == 'Paid'
                                        ? AppTheme.successColor
                                        : AppTheme.warningColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Action Buttons
                _buildActionButtons(index, order.orderStatus),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case OrderStatus.pending:
        color = AppTheme.warningColor;
        text = 'Pending';
        break;
      case OrderStatus.confirmed:
        color = AppTheme.infoColor;
        text = 'Confirmed';
        break;
      case OrderStatus.processing:
        color = AppTheme.primaryColor;
        text = 'Processing';
        break;
      case OrderStatus.shipped:
        color = AppTheme.accentColor;
        text = 'Shipped';
        break;
      case OrderStatus.delivered:
        color = AppTheme.successColor;
        text = 'Delivered';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildActionButtons(int index, OrderStatus currentStatus) {
    List<Widget> buttons = [];
    
    switch (currentStatus) {
      case OrderStatus.pending:
        buttons = [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _updateOrderStatus(index, OrderStatus.confirmed),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.successColor,
              ),
              child: const Text('Confirm'),
            ),
          ),
        ];
        break;
        
      case OrderStatus.confirmed:
        buttons = [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _updateOrderStatus(index, OrderStatus.processing),
              child: const Text('Start Processing'),
            ),
          ),
        ];
        break;
        
      case OrderStatus.processing:
        buttons = [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _updateOrderStatus(index, OrderStatus.shipped),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
              ),
              child: const Text('Mark as Shipped'),
            ),
          ),
        ];
        break;
        
      case OrderStatus.shipped:
        buttons = [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _updateOrderStatus(index, OrderStatus.delivered),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.successColor,
              ),
              child: const Text('Mark as Delivered'),
            ),
          ),
        ];
        break;
        
      case OrderStatus.delivered:
        buttons = [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: AppTheme.successColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Order Completed',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppTheme.successColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ];
        break;
    }
    
    return Row(
      children: buttons,
    );
  }
}

enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
}

class SellerOrder {
  final String id;
  final String buyerName;
  final String buyerPhone;
  final String buyerAddress;
  final String productName;
  final String productImage;
  final int quantity;
  final double totalPrice;
  final String paymentStatus;
  OrderStatus orderStatus;
  final String orderDate;

  SellerOrder({
    required this.id,
    required this.buyerName,
    required this.buyerPhone,
    required this.buyerAddress,
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.totalPrice,
    required this.paymentStatus,
    required this.orderStatus,
    required this.orderDate,
  });
}
