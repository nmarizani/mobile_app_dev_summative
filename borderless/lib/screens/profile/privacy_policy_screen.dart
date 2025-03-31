import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

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
          'Privacy Policy',
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
            'At QuickMart, we are committed to protecting the privacy and security of our users\' personal information. This Privacy Policy outlines how we collect, use, disclose, and safeguard the information obtained through our e-commerce app. By using QuickMart, you consent to the practices described in this policy.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            '1. Information Collection',
            [
              '• Personal Information: We may collect personal information such as name, address, email, and phone number when you create an account, make a purchase, or interact with our services.',
              '• Transaction Details: We collect information related to your purchases, including order history, payment method, and shipping details.',
              '• Usage Data: We may collect data on how you interact with our app, such as browsing activity, search queries, and preferences.',
            ],
          ),
          _buildSection(
            '2. Information Use',
            [
              '• Provide Services: We use the collected information to process orders, deliver products, and provide customer support.',
              '• Personalization: We may use your information to personalize your shopping experience, recommend products, and display targeted advertisements.',
              '• Communication: We may use your contact information to send important updates, promotional offers, and newsletters. You can opt-out of these communications at any time.',
            ],
          ),
          _buildSection(
            '3. Information Sharing',
            [
              '• Third-Party Service Providers: We may share your information with trusted third-party service providers who assist us in operating our app, fulfilling orders, and improving our services.',
              '• Legal Compliance: We may disclose personal information if required by law or in response to a valid legal request from authorities.',
            ],
          ),
          _buildSection(
            '4. Data Security',
            [
              '• We implement appropriate security measures to protect your information from unauthorized access, alteration, disclosure, or destruction.',
              '• However, please note that no data transmission over the internet or electronic storage is 100% secure. We cannot guarantee absolute security of your information.',
            ],
          ),
          _buildSection(
            '5. User Rights',
            [
              '• Access and Update: You have the right to access, correct, or update your personal information stored in our app.',
              '• Data Retention: We retain your personal information as long as necessary to provide our services and comply with legal obligations.',
            ],
          ),
          _buildSection(
            '6. Children\'s Privacy',
            [
              '• QuickMart is not intended for children under the age of 13. We do not knowingly collect or solicit personal information from children.',
            ],
          ),
          _buildSection(
            '7. Updates to the Privacy Policy',
            [
              '• We reserve the right to update this Privacy Policy from time to time. Any changes will be posted on our app, and the revised policy will be effective upon posting.',
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'If you have any questions or concerns about our Privacy Policy, please contact our customer support. By using QuickMart, you acknowledge that you have read and understood this Privacy Policy and agree to its terms and conditions.',
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
