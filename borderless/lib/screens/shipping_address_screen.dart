import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _postalCodeController = TextEditingController();

  String? _selectedProvince;
  String? _selectedCity;

  final Map<String, List<String>> _citiesByProvince = {
    'Punjab': ['Lahore', 'Faisalabad', 'Rawalpindi', 'Multan'],
    'Sindh': ['Karachi', 'Hyderabad', 'Sukkur'],
    'KPK': ['Peshawar', 'Abbottabad', 'Mardan'],
    'Balochistan': ['Quetta', 'Gwadar', 'Turbat'],
  };

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _streetAddressController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

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
          'Shipping Address',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputLabel('Full Name', true),
              const SizedBox(height: 8),
              TextFormField(
                controller: _fullNameController,
                decoration: _buildInputDecoration('Enter full name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildInputLabel('Phone Number', true),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/pk_flag.png',
                          width: 24,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '+92',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: _buildInputDecoration('Enter phone number'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value.length < 10) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildInputLabel('Province', true),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedProvince,
                decoration: _buildInputDecoration('Select Province'),
                items: _citiesByProvince.keys.map((String province) {
                  return DropdownMenuItem<String>(
                    value: province,
                    child: Text(province),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedProvince = newValue;
                    _selectedCity = null;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a province';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildInputLabel('City', true),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: _buildInputDecoration('Select City'),
                items: _selectedProvince == null
                    ? []
                    : _citiesByProvince[_selectedProvince]!.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCity = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildInputLabel('Street Address', true),
              const SizedBox(height: 8),
              TextFormField(
                controller: _streetAddressController,
                decoration: _buildInputDecoration('Enter street address'),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your street address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildInputLabel('Postal Code', true),
              const SizedBox(height: 8),
              TextFormField(
                controller: _postalCodeController,
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration('Enter postal code'),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your postal code';
                  }
                  if (value.length < 5) {
                    return 'Please enter a valid postal code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF21D4B4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label, bool isRequired) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        children: isRequired
            ? const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ]
            : null,
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.grey[400],
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.grey[300]!,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.grey[300]!,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFF21D4B4),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    );
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement address saving logic
      Navigator.pop(context);
    }
  }
}
