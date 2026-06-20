import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

/// AuthEvent - Every possible "thing that can happen" related to auth.
///
/// HOW BLoC WORKS (if you're new to this pattern):
/// Think of BLoC like a vending machine. EVENTS are the buttons you
/// press (e.g., "B4 - Coca Cola"). The BLoC internally decides what
/// to do, and STATES are what comes out of the machine slot
/// (e.g., "Dispensing...", "Here's your drink", "Out of stock").
/// The UI only ever presses buttons (adds events) and watches the
/// slot (listens to states) - it never reaches inside the machine.
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Fired once when the app starts, to check if a session already exists
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// Fired when user submits their phone number to receive an OTP
class AuthPhoneOtpRequested extends AuthEvent {
  final String phoneNumber;
  const AuthPhoneOtpRequested(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

/// Fired when user submits the 6-digit OTP code
class AuthOtpVerificationRequested extends AuthEvent {
  final String verificationId;
  final String otpCode;

  const AuthOtpVerificationRequested({
    required this.verificationId,
    required this.otpCode,
  });

  @override
  List<Object?> get props => [verificationId, otpCode];
}

/// Fired when an ASHA worker/admin submits email signup form
class AuthEmailSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final UserRole role;

  const AuthEmailSignUpRequested({
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [email, password, role];
}

/// Fired when a user submits email login form
class AuthEmailSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthEmailSignInRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// Fired when user taps "Sign Out"
class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}
