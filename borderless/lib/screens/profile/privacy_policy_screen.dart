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
          const Text(
            'Our Policy',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'At QuickMart, we are committed to protecting your privacy and ensuring your user experience is secure and trustworthy. This Privacy Policy outlines how we collect, use, disclose and safeguard the information you provide to us.',
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
              '• Personal Information: We may collect personal information such as name, address, email, phone number, and payment details when you register, make a purchase, or interact with our services.',
              '• Technical Data: We collect information related to your device, browsing actions, and usage patterns.',
              '• Usage Data: We log data about how you use our services, including pages visited, time spent, and features used.',
            ],
          ),
          _buildSection(
            '2. Information Use',
            [
              '• Process transactions and deliver products',
              '• Personalize your shopping experience',
              '• Send promotional communications (with your consent)',
              '• Improve our services and user experience',
              '• Detect and prevent fraudulent activities',
            ],
          ),
          _buildSection(
            '3. Information Sharing',
            [
              '• Third-Party Service Providers: We may share information with trusted service providers who assist us in operating our website and conducting business.',
              '• Legal Compliance: We may disclose personal information if required by law or to protect our rights.',
            ],
          ),
          _buildSection(
            '4. Data Security',
            [
              'We implement appropriate security measures to protect against unauthorized access, alteration, disclosure, or destruction of personal data.',
            ],
          ),
          _buildSection(
            '5. User Rights',
            [
              'Access and correction: You have the right to access, update, or delete your personal information.',
              'Opt-out: You can choose to opt-out of marketing communications at any time.',
            ],
          ),
          _buildSection(
            '6. Children\'s Privacy',
            [
              'Our services are not intended for children under 13. We do not knowingly collect information from children under 13.',
            ],
          ),
          _buildSection(
            '7. Updates to Privacy Policy',
            [
              'We reserve the right to update our Privacy Policy from time to time. Any changes will be posted on this page, and if significant changes are made, we will notify you via email.',
            ],
          ),
        ],
      ),
    );
  }
}
