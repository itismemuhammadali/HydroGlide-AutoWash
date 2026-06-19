import 'package:firebase_core/firebase_core.dart';
import 'firebase_service.dart';

/// Handles Firebase initialization and setup
class AuthHandler {
  static final AuthHandler _instance = AuthHandler._internal();

  bool _isInitialized = false;

  AuthHandler._internal();

  factory AuthHandler() {
    return _instance;
  }

  /// Initialize Firebase for the application
  Future<void> initializeFirebase() async {
    if (_isInitialized) return;

    try {
      await Firebase.initializeApp();
      await FirebaseService.initialize();
      _isInitialized = true;
    } catch (e) {
      print('Failed to initialize Firebase: $e');
      rethrow;
    }
  }

  /// Check if Firebase is initialized
  bool get isInitialized => _isInitialized;
}
