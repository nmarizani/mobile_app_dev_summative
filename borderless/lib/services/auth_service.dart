import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:math'; // For OTP generation

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Generate a 6-digit OTP
  String _generateOTP() {
    Random random = Random();
    return (100000 + random.nextInt(900000)).toString(); // 6-digit OTP
  }

  // Email/Password Sign-Up with OTP (simulated for now)
  Future<Map<String, dynamic>?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String otp = _generateOTP();
      await result.user?.sendEmailVerification(); // Firebase email verification link
      // Simulate sending OTP (replace with actual email service later if needed)
      print("Generated OTP: $otp"); // For debugging; in reality, send via email
      return {
        'user': result.user,
        'otp': otp, // Return OTP for verification screen
      };
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format.';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak.';
          break;
        default:
          errorMessage = 'Sign-up failed. Please try again.';
      }
      print(e.toString());
      return {'error': errorMessage};
    }
  }

  // Email/Password Sign-In
  Future<Map<String, dynamic>?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null && !result.user!.emailVerified) {
        return {'error': 'Please verify your email first.'};
      }
      return {'user': result.user};
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'User account does not exist. Sign up instead.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format.';
          break;
        default:
          errorMessage = 'Login failed. Please try again.';
      }
      print(e.toString());
      return {'error': errorMessage};
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Check if email is verified
  bool isEmailVerified() {
    return _auth.currentUser?.emailVerified ?? false;
  }

  // Verify OTP (simulated for now)
  Future<bool> verifyOTP(String inputOTP, String sentOTP) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate server delay
    return inputOTP == sentOTP;
  }
}