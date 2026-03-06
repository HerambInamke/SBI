import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/user_data_provider.dart';
import '../services/ai_service.dart';
import '../theme/app_theme.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserDataProvider _dataProvider = UserDataProvider();
  final AIService _aiService = AIService();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _materialController = TextEditingController();

  String _selectedCategory = 'Woodwork';
  bool _isGeneratingDescription = false;
  List<String> _generatedTags = [];

  @override
  Widget build(BuildContext context) {
    final categories = _dataProvider.getCategories().where((c) => c != 'All').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: [
          TextButton(
            onPressed: _saveProduct,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Image upload section
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.textLight.withValues(alpha: 0.3),
                  style: BorderStyle.solid,
                ),
              ),
              child: InkWell(
                onTap: _pickImage,
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_photo_alternate,
                        size: 40,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Add Product Photos',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Up to 5 photos • JPG, PNG',
                      style: TextStyle(
                        color: AppTheme.textLight,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Product name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Product Name *',
                hintText: 'e.g., Hand-carved Wooden Elephant',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a product name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Category dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Category *'),
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedCategory = value!);
              },
            ),
            const SizedBox(height: 16),

            // Material (optional)
            TextFormField(
              controller: _materialController,
              decoration: const InputDecoration(
                labelText: 'Material',
                hintText: 'e.g., Teak wood, Brass, Cotton',
              ),
            ),
            const SizedBox(height: 16),

            // Description with AI generate button
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description *',
                hintText: 'Describe your product...',
                alignLabelWithHint: true,
                suffixIcon: _buildAIButton(),
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            if (_isGeneratingDescription)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'AI is writing your description...',
                      style: TextStyle(
                        color: AppTheme.accentColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),

            // Price and Stock row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price (₹) *',
                      prefixText: '₹ ',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Invalid';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _stockController,
                    decoration: const InputDecoration(
                      labelText: 'Stock Quantity *',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Invalid';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // AI Generated Tags
            if (_generatedTags.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.auto_awesome, size: 18, color: AppTheme.accentColor),
                  const SizedBox(width: 8),
                  const Text(
                    'AI Suggested Tags',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _generatedTags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () {
                      setState(() => _generatedTags.remove(tag));
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],

            // AI Tools Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.accentColor.withValues(alpha: 0.1),
                    AppTheme.primaryColor.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.accentColor.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.auto_awesome, color: AppTheme.accentColor),
                      SizedBox(width: 8),
                      Text(
                        'AI Tools',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildAIToolChip(
                        'Generate Description',
                        Icons.description,
                        _generateDescription,
                      ),
                      _buildAIToolChip(
                        'Suggest Tags',
                        Icons.tag,
                        _generateTags,
                      ),
                      _buildAIToolChip(
                        'Price Help',
                        Icons.currency_rupee,
                        _showPricingHelp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Save button
            ElevatedButton(
              onPressed: _saveProduct,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Add Product'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAIButton() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: _generateDescription,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.accentColor, AppTheme.primaryLight],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, size: 16, color: Colors.white),
              SizedBox(width: 4),
              Text(
                'AI',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAIToolChip(String label, IconData icon, VoidCallback onTap) {
    return ActionChip(
      avatar: Icon(icon, size: 18, color: AppTheme.primaryColor),
      label: Text(label),
      onPressed: onTap,
      backgroundColor: Colors.white,
    );
  }

  void _pickImage() {
    // In a real app, this would open image picker
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image picker would open here')),
    );
  }

  Future<void> _generateDescription() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a product name first')),
      );
      return;
    }

    setState(() => _isGeneratingDescription = true);

    final description = await _aiService.generateProductDescription(
      productName: _nameController.text,
      category: _selectedCategory,
      material: _materialController.text.isNotEmpty ? _materialController.text : null,
    );

    setState(() {
      _descriptionController.text = description;
      _isGeneratingDescription = false;
    });
  }

  Future<void> _generateTags() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a product name first')),
      );
      return;
    }

    final tags = await _aiService.generateTags(
      productName: _nameController.text,
      category: _selectedCategory,
      description: _descriptionController.text,
    );

    setState(() {
      _generatedTags = tags;
    });
  }

  void _showPricingHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.lightbulb, color: AppTheme.accentColor),
            SizedBox(width: 8),
            Text('Pricing Tips'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Consider these factors:\n'),
            Text('1. Material cost'),
            Text('2. Time spent (₹100-200/hour)'),
            Text('3. Add 30-50% profit margin'),
            Text('4. Compare with similar products'),
            Text('5. Factor in uniqueness\n'),
            Text('💡 Use the AI Assistant for detailed pricing suggestions!'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        // Create product object
        final product = Product(
          id: '', // Will be assigned by Firestore
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          price: double.parse(_priceController.text),
          category: _selectedCategory,
          images: [], // TODO: Add image upload functionality
          artisanId: _dataProvider.artisanId,
          createdAt: DateTime.now(),
          stockQuantity: int.parse(_stockController.text),
          isAvailable: true,
          tags: _generatedTags,
          rating: 0.0,
          reviewCount: 0,
        );

        // Save to Firebase
        final productId = await _dataProvider.addProduct(product);

        // Close loading dialog
        if (mounted) Navigator.pop(context);

        if (productId != null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product added successfully!'),
                backgroundColor: AppTheme.successColor,
              ),
            );
            Navigator.pop(context, true); // Return true to indicate success
          }
        } else {
          throw Exception('Failed to save product');
        }
      } catch (e) {
        // Close loading dialog
        if (mounted) Navigator.pop(context);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving product: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _materialController.dispose();
    super.dispose();
  }
}
