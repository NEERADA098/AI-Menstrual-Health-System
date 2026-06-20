import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

/// AuthState - Every possible "thing the UI can show" for auth.
///
/// The UI's job becomes very simple: look at the CURRENT state,
/// and render the matching screen/widget. No business logic
/// lives in the UI - it's a pure "if state is X, show Y" mapping.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state before anything has happened
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Shown while checking session, sending OTP, or signing in
/// (any operation that takes time and needs a loading spinner)
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// OTP was successfully sent - show the OTP entry screen
class AuthOtpSent extends AuthState {
  final String verificationId;
  final String phoneNumber;

  const AuthOtpSent({
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [verificationId, phoneNumber];
}

/// User is successfully authenticated
class AuthAuthenticated extends AuthState {
  final UserEntity user;
  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// No user is logged in (shown at splash screen check, or after sign out)
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Something went wrong - message is already user-friendly
/// (translated from Firebase's technical errors in the repository layer)
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}