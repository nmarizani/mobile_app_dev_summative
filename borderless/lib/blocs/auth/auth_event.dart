import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class Login extends AuthEvent {
  final String email;
  final String password;

  const Login({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class Logout extends AuthEvent {
  const Logout();
}

class SignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const SignUp({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object> get props => [email, password, name];
}

class GoogleSignIn extends AuthEvent {
  const GoogleSignIn();
}

class CheckAuth extends AuthEvent {
  const CheckAuth();
}