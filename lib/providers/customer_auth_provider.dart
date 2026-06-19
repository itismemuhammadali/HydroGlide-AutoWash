import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';
import '../services/firestore_user_service.dart';

/// State class for authentication
class AuthState {
  final User? firebaseUser;
  final UserModel? appUser;
  final bool isLoading;
  final String? errorMessage;

  AuthState({
    this.firebaseUser,
    this.appUser,
    this.isLoading = false,
    this.errorMessage,
  });

  /// Check if user is authenticated
  bool get isAuthenticated => firebaseUser != null && appUser != null;

  /// Check if user is customer
  bool get isCustomer => appUser?.role == UserRole.customer;

  /// Copy with method for state updates
  AuthState copyWith({
    User? firebaseUser,
    UserModel? appUser,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      firebaseUser: firebaseUser ?? this.firebaseUser,
      appUser: appUser ?? this.appUser,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// Customer authentication notifier
class CustomerAuthNotifier extends StateNotifier<AuthState> {
  final FirebaseService _firebaseService;
  final FirestoreUserService _firestoreUserService;

  CustomerAuthNotifier(
    this._firebaseService,
    this._firestoreUserService,
  ) : super(AuthState()) {
    _initializeAuth();
  }

  /// Initialize auth state on app startup
  Future<void> _initializeAuth() async {
    try {
      final currentUser = _firebaseService.getCurrentUser();
      if (currentUser != null) {
        final appUser = await _firestoreUserService.getUserById(currentUser.uid);
        if (appUser != null && appUser.isCustomer) {
          state = state.copyWith(
            firebaseUser: currentUser,
            appUser: appUser,
          );
        } else {
          await _firebaseService.logout();
          state = state.copyWith(
            firebaseUser: null,
            appUser: null,
            errorMessage: 'User role mismatch. Please sign up as a customer.',
          );
        }
      }
    } catch (e) {
      print('Error initializing auth: $e');
      state = state.copyWith(
        errorMessage: 'Failed to initialize authentication',
      );
    }
  }

  /// Sign up a new customer
  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Check if email already exists
      final emailExists = await _firestoreUserService.emailExists(email);
      if (emailExists) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Email already registered',
        );
        return false;
      }

      // Register with Firebase Auth
      final userCredential = await _firebaseService.registerWithEmail(
        email,
        password,
      );

      if (userCredential.user == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Registration failed',
        );
        return false;
      }

      // Create user document in Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        phone: phone,
        role: UserRole.customer,
        createdAt: DateTime.now(),
      );

      await _firestoreUserService.createUser(newUser);

      state = state.copyWith(
        isLoading: false,
        firebaseUser: userCredential.user,
        appUser: newUser,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Sign up failed';
      if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Email is already in use';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address';
      }

      state = state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred: $e',
      );
      return false;
    }
  }

  /// Sign in a customer
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Sign in with Firebase Auth
      final userCredential = await _firebaseService.loginWithEmail(
        email,
        password,
      );

      if (userCredential.user == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Sign in failed',
        );
        return false;
      }

      // Fetch user from Firestore
      final appUser = await _firestoreUserService.getUserById(
        userCredential.user!.uid,
      );

      if (appUser == null) {
        await _firebaseService.logout();
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'User profile not found',
        );
        return false;
      }

      // Verify user is a customer
      if (!appUser.isActive) {
        await _firebaseService.logout();
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Your account has been deactivated',
        );
        return false;
      }

      if (appUser.role != UserRole.customer) {
        await _firebaseService.logout();
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid role for customer sign in',
        );
        return false;
      }

      state = state.copyWith(
        isLoading: false,
        firebaseUser: userCredential.user,
        appUser: appUser,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Sign in failed';
      if (e.code == 'user-not-found') {
        errorMessage = 'Email not found';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'User account has been disabled';
      }

      state = state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred: $e',
      );
      return false;
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      await _firebaseService.logout();
      state = AuthState();
    } catch (e) {
      print('Error signing out: $e');
      state = state.copyWith(
        errorMessage: 'Failed to sign out',
      );
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Firebase Service Provider
final firebaseServiceProvider = Provider((ref) {
  return FirebaseService.getInstance();
});

/// Firestore User Service Provider
final firestoreUserServiceProvider = Provider((ref) {
  return FirestoreUserService.getInstance();
});

/// Customer Auth State Notifier Provider
final customerAuthProvider = StateNotifierProvider<CustomerAuthNotifier, AuthState>(
  (ref) {
    final firebaseService = ref.watch(firebaseServiceProvider);
    final firestoreUserService = ref.watch(firestoreUserServiceProvider);
    return CustomerAuthNotifier(firebaseService, firestoreUserService);
  },
);

/// Provider to check if user is authenticated
final isAuthenticatedProvider = Provider((ref) {
  return ref.watch(customerAuthProvider).isAuthenticated;
});

/// Provider to get current app user
final currentUserProvider = Provider((ref) {
  return ref.watch(customerAuthProvider).appUser;
});

/// Provider to get authentication error
final authErrorProvider = Provider((ref) {
  return ref.watch(customerAuthProvider).errorMessage;
});

/// Provider to check if authentication is loading
final isAuthLoadingProvider = Provider((ref) {
  return ref.watch(customerAuthProvider).isLoading;
});
