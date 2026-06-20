import 'package:equatable/equatable.dart';

/// UserRole - Defines what type of user this is.
///
/// PATENT-RELEVANT DESIGN DECISION:
/// Your system serves THREE distinct user types with different
/// permissions and UI flows. This enum is the foundation of your
/// role-based access control (RBAC) system, which will gate
/// features like the ASHA Worker Dashboard (Phase 8) and admin
/// analytics differently from a regular user's period tracker.
enum UserRole {
  /// Regular app user - tracks their own cycle, uses chatbot
  user,

  /// ASHA worker - manages pad distribution, collects field data
  ashaWorker,

  /// NGO/Admin - views aggregate analytics, manages distribution
  admin,
}

/// UserEntity - The pure business representation of a user.
///
/// WHY "ENTITY" AND NOT JUST "USER"?
/// In Clean Architecture, an Entity is a pure Dart object with
/// ZERO knowledge of Firebase, JSON, or databases. It only knows
/// about business rules. This means your AI model, your UI, and
/// your business logic never directly touch "FirebaseUser" - they
/// only ever touch this clean, technology-agnostic UserEntity.
///
/// If you switch from Firebase to a custom backend in the future,
/// this file NEVER changes. Only the data layer that creates
/// UserEntity objects would change.
class UserEntity extends Equatable {
  final String uid;
  final String? email;
  final String? phoneNumber;
  final String? displayName;
  final UserRole role;
  final DateTime createdAt;
  final bool isProfileComplete;

  const UserEntity({
    required this.uid,
    this.email,
    this.phoneNumber,
    this.displayName,
    required this.role,
    required this.createdAt,
    this.isProfileComplete = false,
  });

  /// copyWith - Creates a new UserEntity with some fields changed.
  /// 
  /// WHY THIS PATTERN: Entities should be immutable (unchangeable
  /// once created) for predictability and easier debugging. When
  /// we need an "updated" version (e.g., after profile completion),
  /// we create a NEW object instead of mutating the old one.
  UserEntity copyWith({
    String? uid,
    String? email,
    String? phoneNumber,
    String? displayName,
    UserRole? role,
    DateTime? createdAt,
    bool? isProfileComplete,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        phoneNumber,
        displayName,
        role,
        createdAt,
        isProfileComplete,
      ];
}