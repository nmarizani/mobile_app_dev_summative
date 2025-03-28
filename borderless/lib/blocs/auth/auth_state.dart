import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  final String? error;

  const AuthState({this.error});

  @override
  List<Object?> get props => [error];
}

class AuthInitial extends AuthState {
  const AuthInitial() : super();
}

class AuthLoading extends AuthState {
  const AuthLoading() : super();
}

class Authenticated extends AuthState {
  final String userId;
  final String name;
  final String email;

  const Authenticated({
    required this.userId,
    required this.name,
    required this.email,
  }) : super();

  @override
  List<Object?> get props => [...super.props, userId, name, email];
}

class Unauthenticated extends AuthState {
  const Unauthenticated() : super();
}

class AuthError extends AuthState {
  const AuthError(String error) : super(error: error);
}
