import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/ai_chat_bubble.dart';

class SellerAIAssistantScreen extends StatefulWidget {
  const SellerAIAssistantScreen({super.key});

  @override
  State<SellerAIAssistantScreen> createState() => _SellerAIAssistantScreenState();
}

class _SellerAIAssistantScreenState extends State<SellerAIAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addWelcomeMessage() {
    setState(() {
      _messages.add(
        ChatMessage(
          text: 'Hello! I\'m your AI assistant. I can help you with:\n\n'
              '• Generate product descriptions\n'
              '• Suggest pricing strategies\n'
              '• Create hashtags for social media\n'
              '• Write Instagram captions\n\n'
              'How can I help you today?',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add(
            ChatMessage(
              text: _generateAIResponse(text),
              isUser: false,
              timestamp: DateTime.now(),
            ),
          );
          _isTyping = false;
        });
        _scrollToBottom();
      }
    });
  }

  String _generateAIResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();

    if (lowerMessage.contains('description') || lowerMessage.contains('describe')) {
      return 'I\'d be happy to help you create a compelling product description! '
          'Please provide:\n\n'
          '1. Product name\n'
          '2. Category (Woodwork, Pottery, etc.)\n'
          '3. Materials used\n'
          '4. Any special features\n\n'
          'I\'ll craft a beautiful description that highlights your craftsmanship!';
    } else if (lowerMessage.contains('price') || lowerMessage.contains('pricing')) {
      return 'For pricing suggestions, I need to know:\n\n'
          '• Material cost\n'
          '• Time spent creating\n'
          '• Similar products in market\n'
          '• Your target profit margin\n\n'
          'Based on market analysis, handcrafted items typically sell for 3-5x the material cost. '
          'Would you like me to calculate a specific price?';
    } else if (lowerMessage.contains('hashtag') || lowerMessage.contains('tags')) {
      return 'Here are trending hashtags for handcrafted products:\n\n'
          '#HandmadeInIndia #IndianCrafts #ArtisanMade\n'
          '#HandcraftedWithLove #SupportLocalArtisans\n'
          '#TraditionalCrafts #MadeInIndia #Handmade\n'
          '#CraftedWithCare #IndianHandicraft\n\n'
          'Tell me your product category for more specific hashtags!';
    } else if (lowerMessage.contains('instagram') || lowerMessage.contains('caption')) {
      return 'I can create engaging Instagram captions! Here\'s an example:\n\n'
          '✨ "Every piece tells a story of tradition and craftsmanship. '
          'Handcrafted with love by skilled Indian artisans. '
          'Bring home a piece of heritage today! 🎨"\n\n'
          '#HandmadeInIndia #ArtisanCrafts #SupportLocal\n\n'
          'Would you like me to customize this for your specific product?';
    } else {
      return 'I understand you\'re asking about "${userMessage}". '
          'I can help you with:\n\n'
          '📝 Product descriptions\n'
          '💰 Pricing strategies\n'
          '🏷️ Hashtag suggestions\n'
          '📸 Instagram captions\n\n'
          'Which would you like help with?';
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textLight.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            _buildQuickActionButton(
              'Generate Product Description',
              Icons.description_outlined,
              () {
                Navigator.pop(context);
                _sendMessage('Help me generate a product description');
              },
            ),
            _buildQuickActionButton(
              'Suggest Pricing',
              Icons.currency_rupee,
              () {
                Navigator.pop(context);
                _sendMessage('Help me with pricing strategy');
              },
            ),
            _buildQuickActionButton(
              'Create Hashtags',
              Icons.tag,
              () {
                Navigator.pop(context);
                _sendMessage('Generate hashtags for my product');
              },
            ),
            _buildQuickActionButton(
              'Instagram Caption',
              Icons.photo_camera_outlined,
              () {
                Navigator.pop(context);
                _sendMessage('Create an Instagram caption');
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.accentColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: AppTheme.backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.accentColor, AppTheme.primaryColor],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.auto_awesome, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Text('AI Assistant'),
          ],
        ),
        backgroundColor: AppTheme.accentColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showQuickActions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return AIChatBubble(message: _messages[index]);
                    },
                  ),
          ),

          // Typing Indicator
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTypingDot(0),
                        const SizedBox(width: 4),
                        _buildTypingDot(1),
                        const SizedBox(width: 4),
                        _buildTypingDot(2),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Input Area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _showQuickActions,
                    color: AppTheme.accentColor,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Ask me anything...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppTheme.backgroundColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.accentColor, AppTheme.primaryColor],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () => _sendMessage(_messageController.text),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.accentColor.withValues(alpha: 0.1),
                  AppTheme.primaryColor.withValues(alpha: 0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome,
              size: 60,
              color: AppTheme.accentColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'AI Assistant Ready',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'Ask me anything about your products',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, -4 * (value * (index % 2 == 0 ? 1 : -1))),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppTheme.textLight,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
      onEnd: () {
        if (mounted) setState(() {});
      },
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
