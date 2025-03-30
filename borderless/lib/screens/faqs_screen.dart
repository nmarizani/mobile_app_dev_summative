import 'package:flutter/material.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'FAQs',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFAQItem(
            'Can I cancel my order?',
            'Yes only if the order is not dispatched yet. You can contact our customer service department to get your order canceled.',
          ),
          _buildFAQItem(
            'Will I receive the same product I see in the photo?',
            'Actual product color may vary from the images shown. Every monitor or mobile display has a different capability to display colors, and every individual may see these colors differently. In addition, lighting conditions at the time the photo was taken can also affect an image\'s color.',
          ),
          _buildFAQItem(
            'How can I recover the forgotten password?',
            'If you have forgotten your password, you can recover it from "Login - Forgotten your password?" section. You will receive an e-mail with a link to enter and confirm your new password.',
          ),
          _buildFAQItem(
            'Is my personal information confidential?',
            'Your personal information is confidential. We do not rent, sell, barter or trade email addresses. When you place an order with us, we collect your name, address, telephone number, credit card information and your email address. We use this information to fulfill your order and to communicate with you about your order. All your information is kept confidential and will not be disclosed to anybody unless ordered by government authorities.',
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
