import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/send_otp.dart';
import '../../domain/usecases/verify_otp.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/get_current_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// AuthBloc - The brain that connects UI events to business logic
/// and produces states the UI can render.
///
/// NOTICE: This class contains almost NO actual logic itself - it
/// just calls the appropriate use case and translates the
/// Either<Failure, Success> result into an AuthState. This is
/// intentional: keeping BLoCs "thin" makes them easy to read and
/// the real logic stays testable in the use case layer.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtp sendOtp;
  final VerifyOtp verifyOtp;
  final SignInWithEmail signInWithEmail;
  final SignUpWithEmail signUpWithEmail;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;

  AuthBloc({
    required this.sendOtp,
    required this.verifyOtp,
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signOut,
    required this.getCurrentUser,
  }) : super(const AuthInitial()) {
    // Register a handler function for each event type.
    // When UI calls authBloc.add(SomeEvent()), the matching
    // handler below automatically runs.
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthPhoneOtpRequested>(_onPhoneOtpRequested);
    on<AuthOtpVerificationRequested>(_onOtpVerificationRequested);
    on<AuthEmailSignInRequested>(_onEmailSignInRequested);
    on<AuthEmailSignUpRequested>(_onEmailSignUpRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await getCurrentUser(const NoParams());

    // result.fold() is dartz's way of handling Either: the first
    // function runs if it's a Failure (Left), the second runs if
    // it's a Success (Right). This forces us to handle BOTH cases.
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  Future<void> _onPhoneOtpRequested(
    AuthPhoneOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await sendOtp(event.phoneNumber);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (verificationId) => emit(AuthOtpSent(
        verificationId: verificationId,
        phoneNumber: event.phoneNumber,
      )),
    );
  }

  Future<void> _onOtpVerificationRequested(
    AuthOtpVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await verifyOtp(VerifyOtpParams(
      verificationId: event.verificationId,
      otpCode: event.otpCode,
    ));

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onEmailSignInRequested(
    AuthEmailSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await signInWithEmail(SignInWithEmailParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onEmailSignUpRequested(
    AuthEmailSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await signUpWithEmail(SignUpWithEmailParams(
      email: event.email,
      password: event.password,
      role: event.role,
    ));

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await signOut(const NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }
}