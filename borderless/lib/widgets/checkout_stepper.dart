import 'package:flutter/material.dart';

class CheckoutStepper extends StatelessWidget {
  final int currentStep;

  const CheckoutStepper({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStep(
            icon: Icons.local_shipping_outlined,
            label: 'Shipping',
            isActive: currentStep == 1,
            isCompleted: currentStep > 1,
          ),
          _buildDivider(isCompleted: currentStep > 1),
          _buildStep(
            icon: Icons.payment_outlined,
            label: 'Payment',
            isActive: currentStep == 2,
            isCompleted: currentStep > 2,
          ),
          _buildDivider(isCompleted: currentStep > 2),
          _buildStep(
            icon: Icons.check_circle_outline,
            label: 'Review',
            isActive: currentStep == 3,
            isCompleted: false,
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required IconData icon,
    required String label,
    required bool isActive,
    required bool isCompleted,
  }) {
    final color = isCompleted
        ? const Color(0xFF21D4B4)
        : isActive
            ? Colors.black
            : Colors.grey;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive || isCompleted ? color : Colors.transparent,
            border: Border.all(
              color: color,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : icon,
            color: isActive || isCompleted ? Colors.white : color,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider({required bool isCompleted}) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        color: isCompleted ? const Color(0xFF21D4B4) : Colors.grey[300],
      ),
    );
  }
}
