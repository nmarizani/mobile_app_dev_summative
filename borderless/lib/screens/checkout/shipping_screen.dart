import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../widgets/checkout_stepper.dart';
import '../../blocs/shipping/shipping_bloc.dart';
import '../../blocs/shipping/shipping_event.dart';
import '../../blocs/shipping/shipping_state.dart';
import '../../services/firestore_service.dart';
import '../../providers/user_provider.dart';

class CheckoutShippingScreen extends StatefulWidget {
  const CheckoutShippingScreen({super.key});

  @override
  State<CheckoutShippingScreen> createState() => _CheckoutShippingScreenState();
}

class _CheckoutShippingScreenState extends State<CheckoutShippingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _postalCodeController = TextEditingController();
  String? _selectedProvince;
  String? _selectedCity;
  String _selectedCountry = 'Kenya';
  bool _isLoadingUserData = true;

  final FirestoreService _firestoreService = FirestoreService();

  // Map of African countries with their country codes and flag emojis
  final Map<String, Map<String, String>> _countries = {
    'Kenya': {'code': '+254', 'flag': '🇰🇪'},
    'Nigeria': {'code': '+234', 'flag': '🇳🇬'},
    'South Africa': {'code': '+27', 'flag': '🇿🇦'},
    'Egypt': {'code': '+20', 'flag': '🇪🇬'},
    'Morocco': {'code': '+212', 'flag': '🇲🇪'},
    'Ghana': {'code': '+233', 'flag': '🇬🇭'},
    'Tanzania': {'code': '+255', 'flag': '🇹🇿'},
    'Ethiopia': {'code': '+251', 'flag': '🇪🇹'},
    'Uganda': {'code': '+256', 'flag': '🇺🇬'},
    'Algeria': {'code': '+213', 'flag': '🇩🇿'},
  };

  // Map of provinces/regions for each country
  final Map<String, List<String>> _provinces = {
    'Kenya': [
      'Nairobi',
      'Coast',
      'Central',
      'Eastern',
      'North Eastern',
      'Nyanza',
      'Rift Valley',
      'Western'
    ],
    'Nigeria': [
      'Lagos',
      'Abuja FCT',
      'Rivers',
      'Kano',
      'Oyo',
      'Delta',
      'Kaduna',
      'Ogun'
    ],
    'South Africa': [
      'Gauteng',
      'Western Cape',
      'KwaZulu-Natal',
      'Eastern Cape',
      'Free State',
      'Mpumalanga',
      'North West',
      'Limpopo',
      'Northern Cape'
    ],
    'Egypt': [
      'Cairo',
      'Alexandria',
      'Giza',
      'Qalyubia',
      'Gharbia',
      'Dakahlia',
      'Sharqia',
      'Beheira'
    ],
    'Morocco': [
      'Casablanca-Settat',
      'Rabat-Salé-Kénitra',
      'Tangier-Tetouan-Al Hoceima',
      'Fès-Meknès',
      'Marrakesh-Safi',
      'Oriental',
      'Béni Mellal-Khénifra'
    ],
  };

  // Map of major cities for each province
  final Map<String, List<String>> _cities = {
    'Nairobi': ['Nairobi CBD', 'Westlands', 'Karen', 'Eastleigh', 'Kasarani'],
    'Coast': ['Mombasa', 'Malindi', 'Kilifi', 'Lamu', 'Diani'],
    'Central': ['Nyeri', 'Kiambu', 'Thika', 'Muranga', 'Kerugoya'],
    'Lagos': ['Ikeja', 'Victoria Island', 'Lekki', 'Surulere', 'Yaba'],
    'Abuja FCT': ['Central Area', 'Garki', 'Wuse', 'Maitama', 'Asokoro'],
    'Gauteng': ['Johannesburg', 'Pretoria', 'Soweto', 'Centurion', 'Sandton'],
    'Western Cape': [
      'Cape Town',
      'Stellenbosch',
      'Paarl',
      'George',
      'Worcester'
    ],
    'Cairo': ['Maadi', 'Heliopolis', 'Zamalek', 'Nasr City', 'Downtown'],
    'Alexandria': ['Montaza', 'Sidi Gaber', 'Mansheya', 'Miami', 'Agami'],
    'Casablanca-Settat': [
      'Casablanca',
      'Mohammedia',
      'Settat',
      'Berrechid',
      'Benslimane'
    ],
  };

  @override
  void initState() {
    super.initState();
    context.read<ShippingBloc>().add(LoadSavedAddress());
    _loadUserData(); // Fetch user data from Firestore
  }

  Future<void> _loadUserData() async {
    final user = context.read<UserProvider>().user;
    if (user != null && _nameController.text.isEmpty) {
      try {
        final userData = await _firestoreService.getUser(user.uid);
        if (userData != null && userData['fullName'] != null) {
          setState(() {
            _nameController.text = userData['fullName'];
            _isLoadingUserData = false;
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
      } finally {
        if (mounted) {
          setState(() {
            _isLoadingUserData = false;
          });
        }
      }
    } else {
      setState(() {
        _isLoadingUserData = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final address = context.read<ShippingBloc>().state.address;
    // Only overwrite name if no Firestore data was loaded yet
    if (_nameController.text.isEmpty || !_isLoadingUserData) {
      _nameController.text = address.fullName ?? _nameController.text;
    }
    _phoneController.text = address.phoneNumber ?? '';
    _streetController.text = address.streetAddress ?? '';
    _postalCodeController.text = address.postalCode ?? '';
    _selectedProvince = address.province;
    _selectedCity = address.city;
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final address = ShippingAddress(
        fullName: _nameController.text,
        phoneNumber: _phoneController.text,
        province: _selectedProvince,
        city: _selectedCity,
        streetAddress: _streetController.text,
        postalCode: _postalCodeController.text,
      );

      context.read<ShippingBloc>().add(UpdateShippingAddress(address));
      Navigator.pushNamed(context, '/checkout-payment');
    }
  }

  @override
  Widget build(BuildContext context) {
    final countryData = _countries[_selectedCountry]!;
    final provinces = _provinces[_selectedCountry] ?? [];
    final cities =
    _selectedProvince != null ? _cities[_selectedProvince] ?? [] : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<ShippingBloc, ShippingState>(
        builder: (context, state) {
          if (state.isLoading || _isLoadingUserData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ShippingBloc>().add(LoadSavedAddress());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              const CheckoutStepper(currentStep: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name *',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedCountry,
                          decoration: const InputDecoration(
                            labelText: 'Country *',
                            border: OutlineInputBorder(),
                          ),
                          items: _countries.keys.map((String country) {
                            final data = _countries[country]!;
                            return DropdownMenuItem<String>(
                              value: country,
                              child: Row(
                                children: [
                                  Text(data['flag']!),
                                  const SizedBox(width: 8),
                                  Text(country),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedCountry = newValue;
                                _selectedProvince = null;
                                _selectedCity = null;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number *',
                            border: const OutlineInputBorder(),
                            prefixIcon: Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(countryData['flag']!),
                                  const SizedBox(width: 8),
                                  Text(countryData['code']!),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 1,
                                    height: 24,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedProvince,
                          decoration: const InputDecoration(
                            labelText: 'Province/Region *',
                            border: OutlineInputBorder(),
                          ),
                          items: provinces.map<DropdownMenuItem<String>>(
                                  (dynamic province) {
                                return DropdownMenuItem<String>(
                                  value: province as String,
                                  child: Text(province as String),
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
                              return 'Please select a province/region';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedCity,
                          decoration: const InputDecoration(
                            labelText: 'City *',
                            border: OutlineInputBorder(),
                          ),
                          items: cities
                              .map<DropdownMenuItem<String>>((dynamic city) {
                            return DropdownMenuItem<String>(
                              value: city as String,
                              child: Text(city as String),
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
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _streetController,
                          decoration: const InputDecoration(
                            labelText: 'Street Address *',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _postalCodeController,
                          decoration: const InputDecoration(
                            labelText: 'Postal Code *',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your postal code';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _saveAddress,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
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
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }
}