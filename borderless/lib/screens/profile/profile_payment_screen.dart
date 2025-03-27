import 'package:flutter/material.dart';

class ProfilePaymentScreen extends StatefulWidget {
  const ProfilePaymentScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePaymentScreen> createState() => _ProfilePaymentScreenState();
}

class _ProfilePaymentScreenState extends State<ProfilePaymentScreen> {
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
          'Payment Method',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
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
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter card number' : null,
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
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter CVV' : null,
                    keyboardType: TextInputType.number,
                    hintText: '123',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Save payment method
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
