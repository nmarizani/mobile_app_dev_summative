import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<SignUp>(_onSignUp);
    on<CheckAuth>(_onCheckAuth);
  }

  void _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      // TODO: Implement actual login logic
      await Future.delayed(const Duration(seconds: 1));
      emit(Authenticated(
        userId: '1',
        name: 'John Doe',
        email: event.email,
      ));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onLogout(Logout event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      // TODO: Implement actual logout logic
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      // TODO: Implement actual signup logic
      await Future.delayed(const Duration(seconds: 1));
      emit(Authenticated(
        userId: '1',
        name: event.name,
        email: event.email,
      ));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onCheckAuth(CheckAuth event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      // TODO: Check if user is logged in
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
