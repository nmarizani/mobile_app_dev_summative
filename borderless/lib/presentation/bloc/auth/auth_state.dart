import 'package:equatable/equatable.dart';

abstract class AuthState {
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  const AuthState({
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  AuthState copyWith({bool? isLoading, String? error, bool? isAuthenticated}) {
    return AuthInitial(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

class AuthInitial extends AuthState {
  const AuthInitial({
    super.isLoading = false,
    super.error,
    super.isAuthenticated = false,
  });
}

class AuthLoading extends AuthState {
  const AuthLoading() : super(isLoading: true);
}

class AuthSuccess extends AuthState {
  const AuthSuccess() : super(isAuthenticated: true);
}

class AuthError extends AuthState {
  const AuthError(String error) : super(error: error);
}
