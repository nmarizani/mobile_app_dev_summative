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
          Text(
            'Welcome to QuickMart! These Terms and Conditions ("Terms") govern your use of our e-commerce app. By accessing or using QuickMart, you agree to be bound by these Terms. Please read them carefully before proceeding.',
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
              '• You must create an account to use certain features of QuickMart.',
              '• You are responsible for providing accurate and up-to-date information during the registration process.',
              '• You must safeguard your account credentials and notify us immediately of any unauthorized access or use of your account.',
            ],
          ),
          _buildSection(
            '2. Product Information and Pricing',
            [
              '• QuickMart strives to provide accurate product descriptions, images, and pricing information.',
              '• We reserve the right to modify product details and prices without prior notice.',
              '• In the event of an error, we may cancel or refuse orders placed for incorrectly priced products.',
            ],
          ),
          _buildSection(
            '3. Order Placement and Fulfillment',
            [
              '• By placing an order on QuickMart, you agree to purchase the selected products at the stated price.',
              '• We reserve the right to accept or reject any order, and we may cancel orders due to product unavailability, pricing errors, or suspected fraudulent activity.',
              '• Once an order is confirmed, we will make reasonable efforts to fulfill and deliver it in a timely manner.',
            ],
          ),
          _buildSection(
            '4. Payment',
            [
              '• QuickMart supports various payment methods, including credit/debit cards and online payment platforms.',
              '• By providing payment information, you represent and warrant that you are authorized to use the chosen payment method.',
              '• All payments are subject to verification and approval by relevant financial institutions.',
            ],
          ),
          _buildSection(
            '5. Shipping and Delivery',
            [
              '• QuickMart will make reasonable efforts to ensure timely delivery of products.',
              '• Shipping times may vary based on factors beyond our control, such as location, weather conditions, or carrier delays.',
              '• Risk of loss or damage to products passes to you upon delivery.',
            ],
          ),
          _buildSection(
            '6. Returns and Refunds',
            [
              '• QuickMart\'s return and refund policies are outlined separately and govern the process for returning products and seeking refunds.',
              '• Certain products may be non-returnable or subject to specific conditions.',
            ],
          ),
          _buildSection(
            '7. Intellectual Property',
            [
              '• QuickMart and its content, including logos, trademarks, text, images, and software, are protected by intellectual property rights.',
              '• You may not use, reproduce, modify, distribute, or display any part of QuickMart without our prior written consent.',
            ],
          ),
          _buildSection(
            '8. User Conduct',
            [
              '• You agree to use QuickMart in compliance with applicable laws and regulations.',
              '• You will not engage in any activity that disrupts or interferes with the functioning of QuickMart or infringes upon the rights of others.',
              '• Any unauthorized use or attempt to access restricted areas or user accounts is strictly prohibited.',
            ],
          ),
          _buildSection(
            '9. Limitation of Liability',
            [
              '• QuickMart and its affiliates shall not be liable for any direct, indirect, incidental, consequential, or punitive damages arising from the use or inability to use our app or any products purchased through it.',
              '• We do not guarantee the accuracy, completeness, or reliability of information provided on QuickMart.',
            ],
          ),
          _buildSection(
            '10. Governing Law',
            [
              '• These Terms shall be governed by and construed in accordance with the laws of [Jurisdiction].',
              '• Any disputes arising out of or relating to these Terms shall be resolved in the courts of [Jurisdiction].',
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'If you have any questions or concerns regarding these Terms and Conditions, please contact our customer support. By using QuickMart, you acknowledge that you have read, understood, and agreed to these Terms and Conditions.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
