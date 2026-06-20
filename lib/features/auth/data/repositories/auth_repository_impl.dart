import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

/// AuthRepositoryImpl - Bridges the abstract AuthRepository contract
/// with the concrete FirebaseAuthDataSource implementation.
///
/// WHY THIS LAYER EXISTS SEPARATELY FROM THE DATASOURCE:
/// The datasource throws RAW exceptions (FirebaseAuthException, etc).
/// This repository's job is to CATCH those raw exceptions and
/// translate them into our app's clean Failure types. The rest of
/// the app NEVER sees a FirebaseAuthException - only our own
/// Failure classes (AuthFailure, NetworkFailure, etc).
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, String>> sendOtp(String phoneNumber) async {
    try {
      final verificationId = await _dataSource.sendOtp(phoneNumber);
      return Right(verificationId);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: _mapFirebaseError(e)));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to send OTP: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp({
    required String verificationId,
    required String otpCode,
  }) async {
    try {
      final user = await _dataSource.verifyOtp(
        verificationId: verificationId,
        otpCode: otpCode,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: _mapFirebaseError(e)));
    } catch (e) {
      return Left(ServerFailure(message: 'OTP verification failed: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required UserRole role,
  }) async {
    try {
      final user = await _dataSource.signUpWithEmail(
        email: email,
        password: password,
        role: role,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: _mapFirebaseError(e)));
    } catch (e) {
      return Left(ServerFailure(message: 'Sign up failed: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _dataSource.signInWithEmail(
        email: email,
        password: password,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: _mapFirebaseError(e)));
    } catch (e) {
      return Left(ServerFailure(message: 'Sign in failed: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _dataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Sign out failed: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await _dataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch current user: $e'));
    }
  }

  /// Translates Firebase's technical error codes into messages
  /// that make sense to a rural user who may not be tech-savvy.
  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'Please enter a valid phone number.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'invalid-verification-code':
        return 'Incorrect code. Please check and try again.';
      case 'session-expired':
        return 'Code expired. Please request a new one.';
      case 'email-already-in-use':
        return 'This email is already registered. Try signing in.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password is too weak. Use at least 8 characters.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}