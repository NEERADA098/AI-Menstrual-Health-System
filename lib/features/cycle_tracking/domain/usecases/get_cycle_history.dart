import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/cycle_entity.dart';
import '../repositories/cycle_repository.dart';

class GetCycleHistory implements UseCase<List<CycleEntity>, String> {
  final CycleRepository repository;

  GetCycleHistory(this.repository);

  @override
  Future<Either<Failure, List<CycleEntity>>> call(String userId) {
    return repository.getCycleHistory(userId);
  }
}