import 'package:flutter/material.dart';
import '../../widgets/animated_widgets.dart';
import 'review_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardHolderController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expirationController = TextEditingController();
  final _cvvController = TextEditingController();
  int _selectedPaymentMethod = 0;

  @override
  void dispose() {
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _expirationController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

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
          isActive: true,
        ),
        _buildProgressDivider(isActive: false),
        _buildProgressItem(
          icon: Icons.check_circle_outline,
          label: 'Review',
          isActive: false,
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

  Widget _buildPaymentMethod({
    required String image,
    required String name,
    required int index,
  }) {
    final isSelected = _selectedPaymentMethod == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8FFF3) : Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF00C566) : Colors.grey[200]!,
          ),
        ),
        child: Image.asset(
          image,
          height: 24,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hintText ?? 'Enter ${label.toLowerCase()}',
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
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
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildPaymentMethod(
                          image: 'assets/images/paypal.png',
                          name: 'PayPal',
                          index: 0,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildPaymentMethod(
                          image: 'assets/images/google_pay.png',
                          name: 'Google Pay',
                          index: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    label: 'Card Holder Name',
                    controller: _cardHolderController,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter card holder name'
                        : null,
                  ),
                  _buildTextField(
                    label: 'Card Number',
                    controller: _cardNumberController,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter card number'
                        : null,
                    keyboardType: TextInputType.number,
                    hintText: '4111 1111 1111 1111',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'Expiration',
                          controller: _expirationController,
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Please enter expiration'
                              : null,
                          hintText: 'MM/YY',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          label: 'CVV',
                          controller: _cvvController,
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Please enter CVV'
                              : null,
                          keyboardType: TextInputType.number,
                          hintText: '123',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: ScaleOnTap(
              onTap: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Navigate to review screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReviewScreen(),
                    ),
                  );
                }
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
                    'Continue',
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
