import 'package:flutter/material.dart';
import '../../widgets/animated_widgets.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  Widget _buildProgressIndicator() {
    return Row(
      children: [
        _buildProgressItem(
          icon: Icons.local_shipping_outlined,
          label: 'Shipping',
          isDone: true,
        ),
        _buildProgressDivider(isActive: true),
        _buildProgressItem(
          icon: Icons.payment_outlined,
          label: 'Payment',
          isDone: true,
        ),
        _buildProgressDivider(isActive: true),
        _buildProgressItem(
          icon: Icons.check_circle_outline,
          label: 'Review',
          isActive: true,
        ),
      ],
    );
  }

  Widget _buildProgressItem({
    required IconData icon,
    required String label,
    bool isActive = false,
    bool isDone = false,
  }) {
    final color = isDone
        ? const Color(0xFF00C566)
        : isActive
            ? const Color(0xFF00C566)
            : Colors.grey[200];

    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDone ? Icons.check : icon,
              color: isDone || isActive ? Colors.white : Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive || isDone ? Colors.black : Colors.grey,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDivider({required bool isActive}) {
    return Container(
      height: 1,
      width: 30,
      color: isActive ? const Color(0xFF00C566) : Colors.grey[300],
      margin: const EdgeInsets.only(bottom: 24),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const Divider(height: 1),
          child,
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return _buildSection(
      'Order Summary',
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryRow('Subtotal', '\$299.00'),
            const SizedBox(height: 8),
            _buildSummaryRow('Shipping', '\$10.00'),
            const SizedBox(height: 8),
            _buildSummaryRow('Tax', '\$29.90'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(),
            ),
            _buildSummaryRow(
              'Total',
              '\$338.90',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: isTotal ? const Color(0xFF00C566) : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSection(String title, String address) {
    return _buildSection(
      title,
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8FFF3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF00C566),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                address,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return _buildSection(
      'Payment Method',
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8FFF3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/images/visa.png',
                height: 24,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visa ending in 4242',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Expires 12/24',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ScaleOnTap(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildProgressIndicator(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSection(
                  'Items (2)',
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/watch.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: const Text(
                      'Loop Silicone Strong Magnetic Watch',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text('\$19.25'),
                  ),
                ),
                _buildAddressSection(
                  'Shipping Address',
                  'Ahmad Khan\n+92 000-0000000\nSindh, Karachi, XYZ Address\nPostal Code: 75400',
                ),
                _buildOrderSummary(),
                _buildPaymentMethod(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: ScaleOnTap(
              onTap: () {
                // Place order logic
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
