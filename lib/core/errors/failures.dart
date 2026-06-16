import 'package:equatable/equatable.dart';

/// Failures - Represents all possible errors in the application.
/// 
/// WHY THIS MATTERS FOR YOUR PATENT:
/// Your system operates in offline environments, communicates with
/// IoT devices via MQTT, calls AI APIs, and handles sensitive health data.
/// Each type of failure needs to be handled DIFFERENTLY.
/// 
/// Using a class hierarchy for errors (instead of just strings)
/// is a key pattern in production-grade systems.
/// 
/// Equatable makes two Failure objects equal if their properties match.
/// This is critical for testing and BLoC state comparison.
abstract class Failure extends Equatable {
  /// Human-readable error message
  final String message;
  
  /// Error code for logging and analytics
  final int? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

// ── NETWORK FAILURES ────────────────────────────────────────────────

/// When the device has no internet connectivity
/// System should activate offline mode automatically
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection. Working in offline mode.',
    super.code,
  });
}

/// When the API server returns an error response
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
  });
}

/// When the API request times out
/// Common in rural areas with slow connections
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'Request timed out. Please check your connection.',
    super.code,
  });
}

// ── DATA FAILURES ───────────────────────────────────────────────────

/// When local SQLite database operations fail
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
  });
}

/// When data doesn't match expected format
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });
}

// ── AUTHENTICATION FAILURES ─────────────────────────────────────────

/// Wrong email or password
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });
}

/// User session has expired
class SessionExpiredFailure extends Failure {
  const SessionExpiredFailure({
    super.message = 'Your session has expired. Please sign in again.',
    super.code,
  });
}

// ── AI MODEL FAILURES ───────────────────────────────────────────────

/// When the prediction model fails
/// System should fall back to statistical average
class AIModelFailure extends Failure {
  const AIModelFailure({
    super.message = 'AI prediction unavailable. Using statistical estimates.',
    super.code,
  });
}

/// When the RAG chatbot cannot find a relevant answer
class ChatbotFailure extends Failure {
  const ChatbotFailure({
    super.message = 'Could not find information on this topic. Please consult a doctor.',
    super.code,
  });
}

// ── IoT FAILURES ────────────────────────────────────────────────────

/// When MQTT connection to incinerator is lost
class MQTTConnectionFailure extends Failure {
  const MQTTConnectionFailure({
    super.message = 'Lost connection to incinerator. Retrying...',
    super.code,
  });
}

/// When incinerator temperature exceeds safe limits
/// CRITICAL: This should trigger an immediate safety alert
class IncineratorSafetyFailure extends Failure {
  const IncineratorSafetyFailure({
    super.message = 'SAFETY ALERT: Incinerator temperature critical. Auto-shutdown activated.',
    super.code = 911,   // Special code for safety alerts
  });
}

// ── PERMISSION FAILURES ─────────────────────────────────────────────

/// When user denies microphone access (needed for voice features)
class MicrophonePermissionFailure extends Failure {
  const MicrophonePermissionFailure({
    super.message = 'Microphone permission required for voice features.',
    super.code,
  });
}

/// When user denies location access (needed for geospatial mapping)
class LocationPermissionFailure extends Failure {
  const LocationPermissionFailure({
    super.message = 'Location permission required to find nearby resources.',
    super.code,
  });
}