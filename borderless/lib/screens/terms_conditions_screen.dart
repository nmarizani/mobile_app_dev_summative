import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

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
          'Terms & Conditions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to QuickMart! These Terms and Conditions ("Terms") govern your use of our e-commerce app. By accessing or using QuickMart, you agree to be bound by these Terms. Please read them carefully before proceeding.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. Account Registration:',
              [
                'You must create an account to use certain features of QuickMart.',
                'You are responsible for providing accurate and up-to-date information during the registration process.',
                'You must safeguard your account credentials and notify us immediately of any unauthorized access or use of your account.',
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              '2. Product Information and Pricing:',
              [
                'QuickMart strives to provide accurate product descriptions, images, and pricing information.',
                'We reserve the right to modify product details and prices without prior notice.',
                'In the event of an error, we may cancel or refuse orders placed for incorrectly priced products.',
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              '3. Order Placement and Fulfillment:',
              [
                'By placing an order on QuickMart, you agree to purchase the selected products at the stated price.',
                'We reserve the right to refuse or cancel any order for any reason.',
                'Delivery times are estimates and may vary based on location and other factors.',
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              '4. Payment and Security:',
              [
                'We accept various payment methods as displayed in the app.',
                'All payment information is encrypted and processed securely.',
                'You agree to pay all charges at the prices listed for your purchases.',
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              '5. Returns and Refunds:',
              [
                'Please refer to our Return Policy for detailed information.',
                'Certain items may not be eligible for return or refund.',
                'Refunds will be processed using the original payment method.',
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              '6. Intellectual Property:',
              [
                'All content on QuickMart is protected by copyright and other intellectual property rights.',
                'You may not use our content without express permission.',
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              '7. Limitation of Liability:',
              [
                'QuickMart is not liable for any indirect, incidental, or consequential damages.',
                'Our liability is limited to the amount paid for the products.',
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Last updated: ${DateTime.now().toString().split(' ')[0]}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        ...points.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                point,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.grey[600],
                ),
              ),
            )),
      ],
    );
  }
}
