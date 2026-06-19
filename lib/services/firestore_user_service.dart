import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

/// Service for managing user data in Firestore
class FirestoreUserService {
  static final FirestoreUserService _instance = 
      FirestoreUserService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _usersCollection = 'users';

  FirestoreUserService._internal();

  factory FirestoreUserService() {
    return _instance;
  }

  /// Returns the singleton instance of FirestoreUserService
  static FirestoreUserService getInstance() {
    return _instance;
  }

  /// Creates a new user document in Firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  /// Retrieves a user by ID from Firestore
  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      print('Error retrieving user: $e');
      rethrow;
    }
  }

  /// Retrieves a user by email from Firestore
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        return UserModel.fromJson(doc.data(), doc.id);
      }
      return null;
    } catch (e) {
      print('Error retrieving user by email: $e');
      rethrow;
    }
  }

  /// Updates user information in Firestore
  Future<void> updateUser(UserModel user) async {
    try {
      final updatedUser = user.copyWith(
        updatedAt: DateTime.now(),
      );
      
      await _firestore
          .collection(_usersCollection)
          .doc(user.id)
          .update(updatedUser.toJson());
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  /// Deletes a user document from Firestore
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .delete();
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }

  /// Checks if email already exists in Firestore
  Future<bool> emailExists(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email existence: $e');
      rethrow;
    }
  }

  /// Gets all users with a specific role
  Future<List<UserModel>> getUsersByRole(UserRole role) async {
    try {
      final roleString = role.toString().split('.').last;
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .where('role', isEqualTo: roleString)
          .where('isActive', isEqualTo: true)
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error retrieving users by role: $e');
      rethrow;
    }
  }

  /// Streams user data changes in real-time
  Stream<UserModel?> getUserStream(String userId) {
    return _firestore
        .collection(_usersCollection)
        .doc(userId)
        .snapshots()
        .map((doc) {
          if (doc.exists && doc.data() != null) {
            return UserModel.fromJson(doc.data()!, doc.id);
          }
          return null;
        })
        .handleError((e) {
          print('Error in user stream: $e');
        });
  }

  /// Updates user's profile information
  Future<void> updateUserProfile({
    required String userId,
    String? name,
    String? phone,
    String? profileImageUrl,
  }) async {
    try {
      final updateData = <String, dynamic>{};
      if (name != null) updateData['name'] = name;
      if (phone != null) updateData['phone'] = phone;
      if (profileImageUrl != null) updateData['profileImageUrl'] = profileImageUrl;
      updateData['updatedAt'] = DateTime.now().toIso8601String();

      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .update(updateData);
    } catch (e) {
      print('Error updating user profile: $e');
      rethrow;
    }
  }
}
