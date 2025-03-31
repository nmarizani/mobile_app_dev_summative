import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'password_success_screen.dart';
import '../../services/auth_service.dart'; // Import AuthService

class EmailVerificationScreen extends StatefulWidget {
  final bool isForgotPassword;
  const EmailVerificationScreen({
    super.key,
    this.isForgotPassword = false,
  });

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> _controllers =
  List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  late AnimationController _toastController;
  late Animation<double> _toastAnimation;
  bool _showToast = true;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _toastController = AnimationController(
        xaa      duration: const Duration(milliseconds: 300),
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
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  void _handleVerification() async {
    final code = _controllers.map((controller) => controller.text).join();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final sentOTP = args?['otp'] as String?;

    if (code.length != 6) {
      setState(() {
        _error = 'Please enter all 6 digits';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final authService = AuthService();
    bool isValid = await authService.verifyOTP(code, sentOTP!);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (isValid) {
        await FirebaseAuth.instance.currentUser?.reload(); // Refresh user state
        if (authService.isEmailVerified() || widget.isForgotPassword) {
          if (widget.isForgotPassword) {
            Navigator.pushReplacementNamed(context, '/reset-password');
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
                  (route) => false,
            );
          }
        } else {
          setState(() {
            _error = 'Email verification link not clicked yet.';
          });
        }
      } else {
        setState(() {
          _error = 'Invalid verification code. Please try again.';
        });
      }
    }
  }

  void _handleResendCode() async {
    setState(() {
      _isLoading = true;
    });

    final authService = AuthService();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final email = args?['email'] as String?;

    try {
      String newOTP = authService._generateOTP(); // Access private method (for demo)
      print("Resent OTP for $email: $newOTP"); // Simulate resending OTP
      await FirebaseAuth.instance.currentUser?.sendEmailVerification(); // Resend Firebase link

      if (mounted) {
        setState(() {
          _isLoading = false;
          _showToast = true;
          // Update arguments with new OTP (simplified for demo)
          ModalRoute.of(context)?.settings.arguments = {
            'email': email,
            'isForgotPassword': widget.isForgotPassword,
            'otp': newOTP,
          };
        });
        _toastController.forward();
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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final email = args?['email'] as String? ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                          (route) => false,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'B',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF21D4B4),
                          ),
                        ),
                        const Text(
                          'ORDERLESS',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
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
                      Text(
                        widget.isForgotPassword ? 'Reset Password' : 'Verify Email',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    widget.isForgotPassword
                        ? 'We have sent a verification code to your email address. Please enter the code to reset your password.'
                        : 'We have sent a verification code to your email address. Please enter the code to verify your account.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
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
                      6,
                          (index) => SizedBox(
                        width: 50,
                        height: 56,
                        child: TextFormField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          enabled: !_isLoading,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: _error != null ? Colors.red : Colors.grey[200]!,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFF21D4B4)),
                            ),
                          ),
                          onChanged: (value) {
                            _onCodeChanged(value, index);
                            if (_error != null) {
                              setState(() {
                                _error = null;
                              });
                            }
                          },
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
                                ? Color(0xFF21D4B4).withOpacity(0.5)
                                : Color(0xFF21D4B4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleVerification,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : Text(
                        widget.isForgotPassword ? 'Reset Password' : 'Verify Email',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                      color: Color(0xFF21D4B4).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Color(0xFF21D4B4),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Verification code sent to $email',
                            style: TextStyle(
                              color: Color(0xFF21D4B4),
                              fontSize: 14,
                            ),
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