import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final _paymentItems = [
    const PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
    // Handle payment success
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment Successful!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
          'Payment Methods',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Image.asset(
                      'assets/images/visa.png',
                      width: 40,
                      height: 40,
                    ),
                    title: const Text(
                      '**** **** **** 4242',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text('Expires 12/24'),
                    trailing: Radio(
                      value: true,
                      groupValue: true,
                      onChanged: (value) {},
                      activeColor: const Color(0xFF21D4B4),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/mastercard.png',
                      width: 40,
                      height: 40,
                    ),
                    title: const Text(
                      '**** **** **** 5555',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text('Expires 03/25'),
                    trailing: Radio(
                      value: false,
                      groupValue: true,
                      onChanged: (value) {},
                      activeColor: const Color(0xFF21D4B4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Other Payment Methods',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            GooglePayButton(
              paymentConfiguration: PaymentConfiguration.fromJsonString(
                _googlePayConfig,
              ),
              paymentItems: _paymentItems,
              type: GooglePayButtonType.pay,
              margin: const EdgeInsets.only(top: 8.0),
              onPaymentResult: onGooglePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            const SizedBox(height: 16),
            ApplePayButton(
              paymentConfiguration: PaymentConfiguration.fromJsonString(
                _applePayConfig,
              ),
              paymentItems: _paymentItems,
              style: ApplePayButtonStyle.black,
              type: ApplePayButtonType.buy,
              margin: const EdgeInsets.only(top: 8.0),
              onPaymentResult: (result) => debugPrint(result.toString()),
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).padding.bottom + 16,
        ),
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
        child: ElevatedButton(
          onPressed: () {
            // Handle add new card
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF21D4B4),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Add New Card',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

const _googlePayConfig = '''{
  "provider": "google_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [{
      "type": "CARD",
      "tokenizationSpecification": {
        "type": "PAYMENT_GATEWAY",
        "parameters": {
          "gateway": "example",
          "gatewayMerchantId": "gatewayMerchantId"
        }
      },
      "parameters": {
        "allowedCardNetworks": ["VISA", "MASTERCARD"],
        "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
        "billingAddressRequired": true,
        "billingAddressParameters": {
          "format": "FULL",
          "phoneNumberRequired": true
        }
      }
    }],
    "merchantInfo": {
      "merchantId": "01234567890123456789",
      "merchantName": "Example Merchant Name"
    },
    "transactionInfo": {
      "countryCode": "US",
      "currencyCode": "USD"
    }
  }
}''';

const _applePayConfig = '''{
  "provider": "apple_pay",
  "data": {
    "merchantIdentifier": "merchant.com.example",
    "displayName": "Example Merchant",
    "merchantCapabilities": ["3DS", "debit", "credit"],
    "supportedNetworks": ["visa", "masterCard"],
    "countryCode": "US",
    "currencyCode": "USD",
    "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"],
    "requiredShippingContactFields": []
  }
}''';
