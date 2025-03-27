import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  Widget _buildSection(String title, List<String> content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        ...content.map((text) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            )),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Terms & Conditions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Welcome to QuickMart! Please terms and conditions carefully. By using our services and making purchases, you agree to be bound by these terms. If you do not agree to these terms, please do not use our services.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            '1. Account Registration',
            [
              '• You must register an account to use our app',
              '• You are responsible for providing accurate and complete information',
              '• Keep your account credentials secure',
              '• You are solely responsible for all activities that occur under your account',
            ],
          ),
          _buildSection(
            '2. Product Information and Pricing',
            [
              '• We strive to display accurate product information',
              '• Prices are subject to change without notice',
              '• We reserve the right to modify product descriptions',
              '• Product availability is not guaranteed',
            ],
          ),
          _buildSection(
            '3. Order Payment and Fulfillment',
            [
              '• By placing an order on QuickMart, you agree to pay the full amount specified',
              '• We accept various payment methods',
              '• Orders are subject to verification',
              '• All payments are subject to verification and approval',
            ],
          ),
          _buildSection(
            '4. Shipping',
            [
              '• Delivery times are estimates only',
              '• Shipping costs are calculated based on location and order size',
              '• We are not responsible for delays beyond our control',
            ],
          ),
          _buildSection(
            '5. Returns and Refunds',
            [
              '• Return requests must be made within 7 days of delivery',
              '• Items must be unused and in original packaging',
              '• Refunds will be processed within 5-7 business days',
              '• Shipping costs for returns are the responsibility of the customer',
            ],
          ),
          _buildSection(
            '6. Intellectual Property',
            [
              'All content, trademarks, and other intellectual property on our platform are owned by QuickMart or its licensors.',
            ],
          ),
          _buildSection(
            '7. Limitation of Liability',
            [
              'QuickMart shall not be liable for any indirect, incidental, special, consequential, or punitive damages.',
            ],
          ),
          _buildSection(
            '8. User Guidelines',
            [
              '• You agree to use QuickMart in compliance with applicable laws',
              '• You will not engage in any activity that disrupts our services',
              '• You will not attempt to gain unauthorized access',
            ],
          ),
        ],
      ),
    );
  }
}
