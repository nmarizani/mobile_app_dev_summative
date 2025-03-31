import 'package:flutter/material.dart';

class OnboardingBackground extends StatelessWidget {
  final Widget child;
  final int currentPage;
  final int totalPages;

  const OnboardingBackground({
    super.key,
    required this.child,
    required this.currentPage,
    this.totalPages = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.cyan.shade50,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(64),
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              /// ✅ Wrap in Flexible to prevent layout overflow
              Flexible(child: child),

              /// Pagination Indicators
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    totalPages,
                    (index) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == currentPage
                            ? Colors.black
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),

              /// ✅ Prevent overflow by adding Spacer() before bottom padding
              const Spacer(),

              /// Adjust the bottom spacing to be more dynamic
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

