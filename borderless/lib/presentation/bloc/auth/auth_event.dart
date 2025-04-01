import '../../../core/bloc/base_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String userType;
  final String businessName;
  final String country;

  const SignUpEvent({
    required this.email,
    required this.password,
    required this.userType,
    required this.businessName,
    required this.country,
  });
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});
}

class GoogleSignInEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent({required this.email});
}
