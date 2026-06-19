/// Model representing a user with role-based access control
class UserModel {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? profileImageUrl;
  final UserRole role;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.profileImageUrl,
    required this.role,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  /// Convert UserModel to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'role': role.toString().split('.').last, // Store enum as string
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isActive': isActive,
    };
  }

  /// Create UserModel from Firestore document data
  factory UserModel.fromJson(Map<String, dynamic> json, String docId) {
    return UserModel(
      id: docId,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'],
      profileImageUrl: json['profileImageUrl'],
      role: _parseUserRole(json['role'] ?? 'customer'),
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
      isActive: json['isActive'] ?? true,
    );
  }

  /// Create a copy of UserModel with optional new values
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? profileImageUrl,
    UserRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Check if user is customer
  bool get isCustomer => role == UserRole.customer;

  @override
  String toString() => 'UserModel(id: $id, email: $email, role: $role, name: $name)';
}

/// Enum for user roles with permissions
enum UserRole {
  customer,
  employee,
  admin,
}

/// Parse user role from string
UserRole _parseUserRole(String roleString) {
  switch (roleString.toLowerCase()) {
    case 'customer':
      return UserRole.customer;
    case 'employee':
      return UserRole.employee;
    case 'admin':
      return UserRole.admin;
    default:
      return UserRole.customer; // Default to customer
  }
}

/// Extension to convert UserRole enum to user-friendly string
extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.customer:
        return 'Customer';
      case UserRole.employee:
        return 'Employee';
      case UserRole.admin:
        return 'Admin';
    }
  }
}
