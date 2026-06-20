import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

/// SendOtp - The use case for sending an OTP to a phone number.
///
/// WHY A SEPARATE CLASS FOR EVERY SINGLE ACTION?
/// This might feel like overkill for something this simple, but
/// it pays off massively at scale: each use case can be tested
/// independently, reused across multiple screens, and the BLoC
/// layer becomes a thin coordinator instead of a 1000-line file
/// full of business logic.
class SendOtp implements UseCase<String, String> {
  final AuthRepository repository;

  SendOtp(this.repository);

  @override
  Future<Either<Failure, String>> call(String phoneNumber) {
    return repository.sendOtp(phoneNumber);
  }
}