import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<void> initialize() async {
    // Add any additional initialization logic here if needed
  }

  // Get user data from Firestore
  static Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      final docSnapshot =
          await _firestore.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data() ?? {};
      }
      return {};
    } catch (e) {
      print('Error getting user data: $e');
      return {};
    }
  }

  // Sign up with email and password
  static Future<void> signUp({
    required String email,
    required String password,
    required String userType,
    required String businessName,
    required String country,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'userType': userType,
        'businessName': businessName,
        'country': country,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign in with email and password
  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign in with Google
  static Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Reset password
  static Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Get current user
  static User? get currentUser => _auth.currentUser;

  // Get user stream
  static Stream<User?> get userStream => _auth.authStateChanges();

  static String _handleAuthException(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Wrong password provided.';
        case 'email-already-in-use':
          return 'An account already exists with this email.';
        case 'invalid-email':
          return 'The email address is invalid.';
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'operation-not-allowed':
          return 'This operation is not allowed.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        default:
          return 'An error occurred. Please try again.';
      }
    }
    return 'An unexpected error occurred. Please try again.';
  }
}
