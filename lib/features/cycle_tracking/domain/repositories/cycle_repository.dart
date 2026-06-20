import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/cycle_entity.dart';

abstract class CycleRepository {
  Future<Either<Failure, CycleEntity>> logCycle({
    required String userId,
    required DateTime startDate,
    DateTime? endDate,
    int? cycleLength,
    int? periodLength,
    FlowIntensity? flowIntensity,
    String? notes,
  });

  Future<Either<Failure, List<CycleEntity>>> getCycleHistory(String userId);

  Future<Either<Failure, CycleEntity?>> getCurrentCycle(String userId);

  Future<Either<Failure, void>> updateCycle(CycleEntity cycle);

  Future<Either<Failure, void>> deleteCycle(String id);
}
