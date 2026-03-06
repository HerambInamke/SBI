import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BuyerOrdersScreen extends StatelessWidget {
  const BuyerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildOrderCard(context, index);
        },
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, int index) {
    final statuses = [
      OrderStatus.delivered,
      OrderStatus.shipped,
      OrderStatus.processing,
      OrderStatus.pending,
      OrderStatus.delivered,
    ];
    
    final status = statuses[index % statuses.length];
    
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
                      'Order #${1000 + index}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Placed on ${_getDate(index)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textLight,
                          ),
                    ),
                  ],
                ),
                _buildStatusChip(status),
              ],
            ),
          ),
          
          // Product Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Product Image
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
                
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Handcrafted Item ${index + 1}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'by Artisan ${index + 1}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textLight,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '₹${(index + 1) * 500}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Tracking Progress Bar
          if (status != OrderStatus.delivered)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildTrackingProgress(status),
            ),
          
          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Track Order'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('View Details'),
                  ),
                ),
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
      case OrderStatus.processing:
        color = AppTheme.infoColor;
        text = 'Processing';
        break;
      case OrderStatus.shipped:
        color = AppTheme.primaryColor;
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

  Widget _buildTrackingProgress(OrderStatus currentStatus) {
    final stages = [
      OrderStatus.pending,
      OrderStatus.processing,
      OrderStatus.shipped,
      OrderStatus.delivered,
    ];
    
    final currentIndex = stages.indexOf(currentStatus);
    
    return Column(
      children: [
        // Progress Bar
        Row(
          children: List.generate(stages.length, (index) {
            final isCompleted = index <= currentIndex;
            final isLast = index == stages.length - 1;
            
            return Expanded(
              child: Row(
                children: [
                  // Circle
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isCompleted ? AppTheme.primaryColor : AppTheme.backgroundColor,
                      border: Border.all(
                        color: isCompleted ? AppTheme.primaryColor : AppTheme.textLight,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: isCompleted
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                  
                  // Line
                  if (!isLast)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isCompleted ? AppTheme.primaryColor : AppTheme.textLight,
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
        
        const SizedBox(height: 8),
        
        // Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStageLabel('Pending', currentStatus == OrderStatus.pending),
            _buildStageLabel('Processing', currentStatus == OrderStatus.processing),
            _buildStageLabel('Shipped', currentStatus == OrderStatus.shipped),
            _buildStageLabel('Delivered', currentStatus == OrderStatus.delivered),
          ],
        ),
      ],
    );
  }

  Widget _buildStageLabel(String label, bool isActive) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        color: isActive ? AppTheme.primaryColor : AppTheme.textLight,
      ),
    );
  }

  String _getDate(int index) {
    final dates = [
      'Dec 15, 2025',
      'Jan 5, 2026',
      'Feb 10, 2026',
      'Mar 1, 2026',
      'Nov 20, 2025',
    ];
    return dates[index % dates.length];
  }
}

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
}
