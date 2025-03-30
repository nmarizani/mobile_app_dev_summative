import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_state.dart';
import '../widgets/checkout_stepper.dart';
import '../utils/checkout_page_route.dart';
import 'order_success_screen.dart';
import 'shipping_address_screen.dart';

class CheckoutReviewScreen extends StatelessWidget {
  const CheckoutReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          const CheckoutStepper(currentStep: 2),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    title: 'Items (2)',
                    onTap: () {
                      // Navigate to edit items
                    },
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return Column(
                          children: state.items.map((item) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: AssetImage(item.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Quantity: ${item.quantity}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '\$${item.totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    title: 'Shipping Address',
                    onTap: () {
                      Navigator.push(
                        context,
                        CheckoutPageRoute(
                          page: const ShippingAddressScreen(),
                          reverse: true,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ahmad Khan',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '+92 000-0000000',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'XYZ Address, Karachi, Sindh, 75400',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    title: 'Order Info',
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            _buildOrderInfoRow(
                              label: 'Subtotal',
                              value: '\$${state.subtotal.toStringAsFixed(2)}',
                            ),
                            const SizedBox(height: 8),
                            _buildOrderInfoRow(
                              label: 'Shipping Cost',
                              value: state.shippingCost > 0
                                  ? '\$${state.shippingCost.toStringAsFixed(2)}'
                                  : 'Free',
                              valueColor: const Color(0xFF21D4B4),
                            ),
                            const Divider(height: 24),
                            _buildOrderInfoRow(
                              label: 'Total',
                              value: '\$${state.total.toStringAsFixed(2)}',
                              isTotal: true,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
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
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    CheckoutPageRoute(
                      page: const OrderSuccessScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (onTap != null)
                GestureDetector(
                  onTap: onTap,
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 20,
                    color: Color(0xFF21D4B4),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildOrderInfoRow({
    required String label,
    required String value,
    Color? valueColor,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: valueColor ??
                (isTotal ? const Color(0xFF21D4B4) : Colors.black),
          ),
        ),
      ],
    );
  }
}
