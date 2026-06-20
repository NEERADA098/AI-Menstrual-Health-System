import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmailParams {
  final String email;
  final String password;

  const SignInWithEmailParams({
    required this.email,
    required this.password,
  });
}

class SignInWithEmail implements UseCase<UserEntity, SignInWithEmailParams> {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInWithEmailParams params) {
    return repository.signInWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}