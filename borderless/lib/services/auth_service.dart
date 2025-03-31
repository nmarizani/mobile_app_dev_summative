import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Generate a 6-digit OTP
  String _generateOTP() {
    Random random = Random();
    return (100000 + random.nextInt(900000)).toString(); // 6-digit OTP
  }

  // Email/Password Sign-Up with OTP
  Future<Map<String, dynamic>?> signUpWithEmail(String email, String password, String fullName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user != null) {
        // Save user data to Firestore
        await createUser(user.uid, email, fullName);
        String otp = _generateOTP();
        await user.sendEmailVerification(); // Sends Firebase verification link
        print("Generated OTP for $email: $otp"); // Simulate OTP sending (replace with email service)
        return {
          'user': user,
          'otp': otp,
        };
      }
      return null;
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

  // Google Sign-In (Updated to return Map for consistency)
  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return {'error': 'Google Sign-In cancelled by user.'}; // User cancelled
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      if (user != null) {
        // Check if user exists in Firestore, create if not
        DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
        if (!doc.exists) {
          await createUser(user.uid, user.email ?? '', user.displayName ?? '');
        }
        return {'user': user};
      }
      return null;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage = 'Account exists with a different sign-in method.';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid Google credentials.';
          break;
        default:
          errorMessage = 'Google Sign-In failed. Please try again.';
      }
      print(e.toString());
      return {'error': errorMessage};
    } catch (e) {
      print(e.toString());
      return {'error': 'An unexpected error occurred during Google Sign-In.'};
    }
  }

  // Create user in Firestore
  Future<void> createUser(String uid, String email, String fullName) async {
    await _firestore.collection('users').doc(uid).set({
      'email': email,
      'fullName': fullName,
      'role': 'customer',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Sign Out (Updated to sign out from Google as well)
  Future<void> signOut() async {
    await _googleSignIn.signOut(); // Sign out from Google
    await _auth.signOut(); // Sign out from Firebase
  }

  // Check if email is verified
  bool isEmailVerified() {
    return _auth.currentUser?.emailVerified ?? false;
  }

  // Verify OTP
  Future<bool> verifyOTP(String inputOTP, String sentOTP) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate server delay
    return inputOTP == sentOTP;
  }
}