import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
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
              'Our Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'At QuickMart, we are committed to protecting the privacy and security of our users\' personal information. This Privacy Policy outlines how we collect, use, disclose, and safeguard the information obtained through our e-commerce app. By using QuickMart, you consent to the practices described in this policy.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. Information Collection:',
              [
                'Personal Information: We may collect personal information such as name, address, email, and phone number when you create an account, make a purchase, or interact with our services.',
                'Transaction Details: We collect information related to your purchases, including order history, payment method, and shipping details.',
                'Usage Data: We may collect data on how you interact with our app, such as browsing activity, search queries, and preferences.',
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              '2. Information Use:',
              [
                'Provide Services: We use the collected information to process orders, deliver products, and provide customer support.',
                'Personalization: We may use your information to personalize your shopping experience, recommend products, and display targeted advertisements.',
                'Communication: We may use your contact information to send important updates, promotional offers, and newsletters. You can opt out of marketing communications at any time.',
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              '3. Information Sharing:',
              [
                'Service Providers: We may share information with trusted third-party service providers who assist us in operating our app, conducting business, or servicing you.',
                'Legal Requirements: We may disclose information when required by law or to protect our rights, privacy, safety, or property.',
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              '4. Data Security:',
              [
                'We implement appropriate security measures to protect your information from unauthorized access, alteration, disclosure, or destruction.',
                'While we strive to protect your personal information, no method of transmission over the internet is 100% secure.',
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              '5. Your Rights:',
              [
                'Access and update your personal information',
                'Request deletion of your data',
                'Opt out of marketing communications',
                'Contact us with privacy concerns',
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
