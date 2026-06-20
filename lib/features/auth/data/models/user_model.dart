import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

/// UserModel - The DATA representation of a user.
///
/// WHY A SEPARATE MODEL FROM UserEntity?
/// UserEntity (domain layer) is pure and knows nothing about Firebase.
/// UserModel (data layer) knows EXACTLY how to convert to/from
/// Firestore documents (JSON-like maps) and Firebase Auth objects.
///
/// This file is the ONLY place in your entire codebase that should
/// contain Firestore-specific field-name strings like 'uid', 'email'.
class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    super.email,
    super.phoneNumber,
    super.displayName,
    required super.role,
    required super.createdAt,
    super.isProfileComplete = false,
  });

  /// fromFirestore - Converts a Firestore document into a UserModel.
  /// 
  /// Called when we READ user data back from the database.
  factory UserModel.fromFirestore(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      email: data['email'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      displayName: data['displayName'] as String?,
      role: _roleFromString(data['role'] as String? ?? 'user'),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ??
          DateTime.now(),
      isProfileComplete: data['isProfileComplete'] as bool? ?? false,
    );
  }

  /// toFirestore - Converts this UserModel into a Map ready to save.
  ///
  /// Called when we WRITE user data to the database.
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'role': _roleToString(role),
      'createdAt': Timestamp.fromDate(createdAt),
      'isProfileComplete': isProfileComplete,
    };
  }

  /// Converts the UserRole enum to a string for storage.
  /// Firestore can't store Dart enums directly - only primitives.
  static String _roleToString(UserRole role) {
    switch (role) {
      case UserRole.user:
        return 'user';
      case UserRole.ashaWorker:
        return 'asha_worker';
      case UserRole.admin:
        return 'admin';
    }
  }

  /// Converts a stored string back into the UserRole enum.
  static UserRole _roleFromString(String value) {
    switch (value) {
      case 'asha_worker':
        return UserRole.ashaWorker;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.user;
    }
  }
}