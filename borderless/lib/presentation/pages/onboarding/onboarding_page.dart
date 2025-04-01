import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/logo.dart';
import 'onboarding_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingScreen> _screens = [
    const OnboardingScreen(
      title: 'Welcome to Borderless',
      description:
          'Your one-stop solution for seamless international transactions.',
      image: 'assets/images/onboarding1.png',
    ),
    const OnboardingScreen(
      title: 'Send Money Globally',
      description:
          'Transfer money to anyone, anywhere in the world with just a few taps.',
      image: 'assets/images/onboarding2.png',
    ),
    const OnboardingScreen(
      title: 'Track Your Transactions',
      description:
          'Keep track of all your transactions in real-time with detailed analytics.',
      image: 'assets/images/onboarding3.png',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _screens.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _screens.length,
                itemBuilder: (context, index) {
                  return _screens[index];
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _screens.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _currentPage == index
                                  ? AppColors.primary
                                  : AppColors.textSecondary.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text:
                        _currentPage == _screens.length - 1
                            ? 'Get Started'
                            : 'Next',
                    onPressed: _nextPage,
                  ),
                  const SizedBox(height: 16),
                  if (_currentPage < _screens.length - 1)
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
