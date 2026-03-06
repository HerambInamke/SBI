import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SellerSignupScreen extends StatelessWidget {
  const SellerSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Register as Artisan', style: TextStyle(color: AppTheme.textPrimary)),
      ),
      body: const Center(
        child: Text('Seller Signup Screen - To be implemented'),
      ),
    );
  }
}
