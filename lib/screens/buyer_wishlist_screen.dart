import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BuyerWishlistScreen extends StatelessWidget {
  const BuyerWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Wishlist'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: const Center(
        child: Text('Wishlist Screen - To be implemented'),
      ),
    );
  }
}
