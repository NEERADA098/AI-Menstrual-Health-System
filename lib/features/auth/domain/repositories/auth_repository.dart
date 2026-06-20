import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

/// AuthRepository - The CONTRACT for all authentication operations.
///
/// CRITICAL CONCEPT: This is an ABSTRACT class (interface). It does
/// NOT contain any Firebase code. It simply declares WHAT operations
/// must exist, not HOW they work. The actual Firebase implementation
/// lives in data/repositories/auth_repository_impl.dart.
///
/// WHY THIS SEPARATION MATTERS FOR YOUR PATENT:
/// Your domain layer (business rules) depends on THIS abstract
/// contract, never on Firebase directly. This is the "Dependency
/// Inversion Principle" - one of the 5 SOLID principles used in
/// professional software architecture. It's a strong point to
/// highlight in your patent's technical novelty section regarding
/// system extensibility and modularity.
abstract class AuthRepository {
  /// Sends an OTP code to the given phone number.
  /// Returns the verificationId needed to confirm the OTP later.
  Future<Either<Failure, String>> sendOtp(String phoneNumber);

  /// Verifies the OTP code the user entered.
  /// Returns the authenticated UserEntity on success.
  Future<Either<Failure, UserEntity>> verifyOtp({
    required String verificationId,
    required String otpCode,
  });

  /// Signs up a new user using email and password.
  /// Used primarily by ASHA workers and admins.
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required UserRole role,
  });

  /// Signs in an existing user using email and password.
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Signs out the currently logged-in user.
  Future<Either<Failure, void>> signOut();

  /// Checks if a user is currently logged in, and if so, returns
  /// their UserEntity. Returns null inside Right() if no one is
  /// logged in (this is NOT a failure - it's a valid "no user" state).
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}