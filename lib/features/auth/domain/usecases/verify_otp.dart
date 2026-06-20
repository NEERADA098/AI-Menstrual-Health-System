import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Params object for VerifyOtp - bundles the two pieces of data
/// this use case needs into one object, since UseCase only accepts
/// a single Params type.
class VerifyOtpParams {
  final String verificationId;
  final String otpCode;

  const VerifyOtpParams({
    required this.verificationId,
    required this.otpCode,
  });
}

class VerifyOtp implements UseCase<UserEntity, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(VerifyOtpParams params) {
    return repository.verifyOtp(
      verificationId: params.verificationId,
      otpCode: params.otpCode,
    );
  }
}