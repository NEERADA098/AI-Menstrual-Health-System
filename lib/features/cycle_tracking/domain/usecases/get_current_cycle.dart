import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/cycle_entity.dart';
import '../repositories/cycle_repository.dart';

class GetCurrentCycle implements UseCase<CycleEntity?, String> {
  final CycleRepository repository;

  GetCurrentCycle(this.repository);

  @override
  Future<Either<Failure, CycleEntity?>> call(String userId) {
    return repository.getCurrentCycle(userId);
  }
}