import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpWithEmailParams {
  final String email;
  final String password;
  final UserRole role;

  const SignUpWithEmailParams({
    required this.email,
    required this.password,
    required this.role,
  });
}

class SignUpWithEmail implements UseCase<UserEntity, SignUpWithEmailParams> {
  final AuthRepository repository;

  SignUpWithEmail(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpWithEmailParams params) {
    return repository.signUpWithEmail(
      email: params.email,
      password: params.password,
      role: params.role,
    );
  }
}