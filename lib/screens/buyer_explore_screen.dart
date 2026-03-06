import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BuyerExploreScreen extends StatelessWidget {
  const BuyerExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: const Center(
        child: Text('Explore Screen - To be implemented'),
      ),
    );
  }
}
