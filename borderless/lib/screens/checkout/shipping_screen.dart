import 'package:flutter/material.dart';
import '../../widgets/animated_widgets.dart';
import 'payment_screen.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _postalCodeController = TextEditingController();
  String? _selectedProvince;
  String? _selectedCity;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: [
        _buildProgressItem(
          icon: Icons.local_shipping_outlined,
          label: 'Shipping',
          isActive: true,
        ),
        _buildProgressDivider(isActive: true),
        _buildProgressItem(
          icon: Icons.payment_outlined,
          label: 'Payment',
          isActive: false,
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
    required bool isActive,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF00C566) : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey,
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    Widget? prefix,
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
            hintText: 'Enter ${label.toLowerCase()}',
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
            prefixIcon: prefix,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            validator: (value) =>
                value == null ? 'Please select ${label.toLowerCase()}' : null,
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
                  _buildTextField(
                    label: 'Full Name',
                    controller: _nameController,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter your name'
                        : null,
                  ),
                  _buildTextField(
                    label: 'Phone Number',
                    controller: _phoneController,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter phone number'
                        : null,
                    keyboardType: TextInputType.phone,
                    prefix: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/pk_flag.png',
                            width: 24,
                            height: 16,
                          ),
                          const SizedBox(width: 4),
                          const Text('+92'),
                          const SizedBox(width: 4),
                          Container(
                            width: 1,
                            height: 24,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildDropdown(
                    label: 'Province',
                    value: _selectedProvince,
                    items: const ['Sindh', 'Punjab', 'KPK', 'Balochistan'],
                    onChanged: (value) {
                      setState(() {
                        _selectedProvince = value;
                        _selectedCity =
                            null; // Reset city when province changes
                      });
                    },
                  ),
                  _buildDropdown(
                    label: 'City',
                    value: _selectedCity,
                    items: _selectedProvince == 'Sindh'
                        ? const ['Karachi', 'Hyderabad', 'Sukkur']
                        : const ['Select Province First'],
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value;
                      });
                    },
                  ),
                  _buildTextField(
                    label: 'Street Address',
                    controller: _streetController,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter street address'
                        : null,
                  ),
                  _buildTextField(
                    label: 'Postal Code',
                    controller: _postalCodeController,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter postal code'
                        : null,
                    keyboardType: TextInputType.number,
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
                  // Navigate to payment screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
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
                    'Save',
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
