import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ForgotPasswordVerificationScreen extends StatefulWidget {
  const ForgotPasswordVerificationScreen({super.key});

  @override
  State<ForgotPasswordVerificationScreen> createState() =>
      _ForgotPasswordVerificationScreenState();
}

class _ForgotPasswordVerificationScreenState
    extends State<ForgotPasswordVerificationScreen>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  late AnimationController _toastController;
  late Animation<double> _toastAnimation;
  bool _showToast = true;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _toastController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _toastAnimation = CurvedAnimation(
      parent: _toastController,
      curve: Curves.easeInOut,
    );
    _toastController.forward();

    // Show toast for 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _toastController.reverse().then((_) {
          setState(() {
            _showToast = false;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _toastController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleDigitInput(String digit) {
    for (int i = 0; i < _controllers.length; i++) {
      if (_controllers[i].text.isEmpty) {
        setState(() {
          _controllers[i].text = digit;
          _error = null;
        });
        if (i == _controllers.length - 1) {
          _handleVerification();
        }
        break;
      }
    }
  }

  void _handleBackspace() {
    for (int i = _controllers.length - 1; i >= 0; i--) {
      if (_controllers[i].text.isNotEmpty) {
        setState(() {
          _controllers[i].text = '';
          _error = null;
        });
        break;
      }
    }
  }

  void _handleVerification() async {
    final code = _controllers.map((controller) => controller.text).join();

    if (code.length != 4) {
      setState(() {
        _error = 'Please enter all 4 digits';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacementNamed(context, '/reset-password');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = 'Invalid verification code. Please try again.';
        });
      }
    }
  }

  void _handleResendCode() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() {
          _isLoading = false;
          _showToast = true;
        });
        _toastController.forward();

        // Hide toast after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            _toastController.reverse().then((_) {
              setState(() {
                _showToast = false;
              });
            });
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = 'Failed to resend code. Please try again.';
        });
      }
    }
  }

  Widget _buildDigitButton(String digit) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: TextButton(
          onPressed: _isLoading ? null : () => _handleDigitInput(digit),
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            foregroundColor: Colors.black,
          ),
          child: Text(
            digit,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '02/02',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email Verification',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AutoSizeText(
                        'Enter the 4-digit verification code sent to your email address.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 32),
                      if (_error != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            _error!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          4,
                          (index) => Container(
                            width: 70,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _error != null
                                    ? Colors.red
                                    : _controllers[index].text.isNotEmpty
                                        ? const Color(0xFF21D4B4)
                                        : Colors.grey[200]!,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _controllers[index].text,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t receive code? ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          GestureDetector(
                            onTap: !_isLoading ? _handleResendCode : null,
                            child: Text(
                              'Resend Code',
                              style: TextStyle(
                                fontSize: 14,
                                color: _isLoading
                                    ? const Color(0xFF21D4B4).withOpacity(0.5)
                                    : const Color(0xFF21D4B4),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(24.0),
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _buildDigitButton('1'),
                          const SizedBox(width: 8),
                          _buildDigitButton('2'),
                          const SizedBox(width: 8),
                          _buildDigitButton('3'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildDigitButton('4'),
                          const SizedBox(width: 8),
                          _buildDigitButton('5'),
                          const SizedBox(width: 8),
                          _buildDigitButton('6'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildDigitButton('7'),
                          const SizedBox(width: 8),
                          _buildDigitButton('8'),
                          const SizedBox(width: 8),
                          _buildDigitButton('9'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          const SizedBox(width: 8),
                          _buildDigitButton('0'),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: TextButton(
                                onPressed: _isLoading ? null : _handleBackspace,
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey[50],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  foregroundColor: Colors.black,
                                ),
                                child: const Icon(Icons.backspace_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_showToast)
              Positioned(
                top: 16,
                left: 24,
                right: 24,
                child: FadeTransition(
                  opacity: _toastAnimation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Verification code sent successfully',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
