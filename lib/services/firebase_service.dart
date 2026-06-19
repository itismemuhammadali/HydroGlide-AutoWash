import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  /// Returns the singleton instance of FirebaseService.
  static FirebaseService getInstance() {
    return _instance;
  }

  /// Initializes Firebase with error handling.
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print('Firebase initialization failed: $e');
      rethrow;
    }
  }

  /// Registers a new user with the given email and password.
  Future<UserCredential> registerWithEmail(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Registration failed: $e');
      rethrow;
    }
  }

  /// Logs in a user with the given email and password.
  Future<UserCredential> loginWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Login failed: $e');
      rethrow;
    }
  }

  /// Logs out the current user.
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Logout failed: $e');
      rethrow;
    }
  }

  /// Returns the currently signed-in user, or null if no user is signed in.
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
