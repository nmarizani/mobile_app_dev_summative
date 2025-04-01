import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/logo.dart';

class NewPasswordPage extends StatefulWidget {
  final String email;
  final bool isPasswordReset;

  const NewPasswordPage({
    super.key,
    required this.email,
    this.isPasswordReset = false,
  });

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSetPasswordPressed() {
    if (_formKey.currentState!.validate()) {
      if (widget.isPasswordReset) {
        context.read<AuthBloc>().add(ResetPasswordEvent(email: widget.email));
      } else {
        context.read<AuthBloc>().add(
          SignUpEvent(
            email: widget.email,
            password: _passwordController.text,
            userType: 'user',
            businessName: '',
            country: '',
          ),
        );
      }
      Navigator.pushReplacementNamed(context, '/password-success');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isPasswordReset ? 'Set New Password' : 'Create Password',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Logo(size: 32),
                const SizedBox(height: 32),
                Text(
                  widget.isPasswordReset
                      ? 'Set New Password'
                      : 'Create Password',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.isPasswordReset
                      ? 'Please enter your new password'
                      : 'Please create a strong password',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text:
                      widget.isPasswordReset
                          ? 'Set Password'
                          : 'Create Password',
                  onPressed: _onSetPasswordPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
