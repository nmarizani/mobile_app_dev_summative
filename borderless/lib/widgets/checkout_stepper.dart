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
        children: [
          _buildStep(1, 'Shipping', Icons.local_shipping_outlined),
          _buildDivider(1),
          _buildStep(2, 'Payment', Icons.payment_outlined),
          _buildDivider(2),
          _buildStep(3, 'Review', Icons.check_circle_outline),
        ],
      ),
    );
  }

  Widget _buildStep(int step, String label, IconData icon) {
    final isActive = step == currentStep;
    final isCompleted = step < currentStep;
    final color =
        isCompleted ? Colors.green : (isActive ? Colors.black : Colors.grey);

    return Expanded(
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: step == currentStep ? (0.9 + (0.1 * value)) : 1.0,
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? Colors.green.withOpacity(0.1)
                    : Colors.transparent,
                border: Border.all(
                  color: color,
                  width: 2,
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: Icon(
                  isCompleted ? Icons.check : icon,
                  key: ValueKey<bool>(isCompleted),
                  color: color,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 8),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(int beforeStep) {
    final isCompleted = beforeStep < currentStep;
    return Expanded(
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Container(
            height: 2,
            color: Color.lerp(
              Colors.grey[300],
              isCompleted ? Colors.green : Colors.grey[300],
              value,
            ),
          );
        },
      ),
    );
  }
}
