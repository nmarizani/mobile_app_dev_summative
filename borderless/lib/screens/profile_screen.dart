import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import 'shipping_address_screen.dart';
import 'payment_method_screen.dart';
import 'order_history_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_conditions_screen.dart';
import 'faqs_screen.dart';
import 'change_password_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {
              // TODO: Navigate to notifications screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserInfo(),
            const SizedBox(height: 24),
            _buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!),
              image: const DecorationImage(
                image: NetworkImage('assets/images/profile_image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'john.doe@example.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
            onPressed: () {
              // TODO: Navigate to edit profile screen
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.location_on_outlined,
          title: 'Shipping Address',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ShippingAddressScreen(),
            ),
          ),
        ),
        _buildMenuItem(
          icon: Icons.payment_outlined,
          title: 'Payment Method',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentMethodScreen(),
            ),
          ),
        ),
        _buildMenuItem(
          icon: Icons.history_outlined,
          title: 'Order History',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrderHistoryScreen(),
            ),
          ),
        ),
        _buildMenuItem(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PrivacyPolicyScreen(),
            ),
          ),
        ),
        _buildMenuItem(
          icon: Icons.description_outlined,
          title: 'Terms & Conditions',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TermsConditionsScreen(),
            ),
          ),
        ),
        _buildMenuItem(
          icon: Icons.help_outline_outlined,
          title: 'FAQs',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FAQsScreen(),
            ),
          ),
        ),
        _buildMenuItem(
          icon: Icons.lock_outline,
          title: 'Change Password',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChangePasswordScreen(),
            ),
          ),
        ),
        _buildMenuItem(
          icon: Icons.logout,
          title: 'Logout',
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Logout'),
                content: const Text(
                  'Are you sure you want to logout?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(Logout());
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
