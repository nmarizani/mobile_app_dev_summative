import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'profile_shipping_screen.dart';
import 'profile_payment_screen.dart';
import 'change_password_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_conditions_screen.dart';
import 'order_history_screen.dart';
import 'faqs_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkTheme = false;

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF00C566),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmed Raza',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'ahmedraza@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Edit profile logic
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 24, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.black87,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildHeader(),
            ),
            _buildSection('Personal Information'),
            _buildListTile(
              icon: Icons.local_shipping_outlined,
              title: 'Shipping Address',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileShippingScreen(),
                ),
              ),
            ),
            _buildListTile(
              icon: Icons.payment_outlined,
              title: 'Payment Method',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePaymentScreen(),
                ),
              ),
            ),
            _buildListTile(
              icon: Icons.history,
              title: 'Order History',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderHistoryScreen(),
                ),
              ),
            ),
            _buildSection('Support & Information'),
            _buildListTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              ),
            ),
            _buildListTile(
              icon: Icons.description_outlined,
              title: 'Terms & Conditions',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsConditionsScreen(),
                ),
              ),
            ),
            _buildListTile(
              icon: Icons.help_outline,
              title: 'FAQs',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FAQsScreen(),
                ),
              ),
            ),
            _buildSection('Account Management'),
            _buildListTile(
              icon: Icons.lock_outline,
              title: 'Change Password',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordScreen(),
                ),
              ),
            ),
            _buildListTile(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Theme',
              trailing: CupertinoSwitch(
                value: _isDarkTheme,
                activeColor: const Color(0xFF00C566),
                onChanged: (value) {
                  setState(() {
                    _isDarkTheme = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
