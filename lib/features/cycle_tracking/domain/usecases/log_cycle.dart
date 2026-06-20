import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/cycle_entity.dart';
import '../repositories/cycle_repository.dart';

class LogCycleParams {
  final String userId;
  final DateTime startDate;
  final DateTime? endDate;
  final int? cycleLength;
  final int? periodLength;
  final FlowIntensity? flowIntensity;
  final String? notes;

  const LogCycleParams({
    required this.userId,
    required this.startDate,
    this.endDate,
    this.cycleLength,
    this.periodLength,
    this.flowIntensity,
    this.notes,
  });
}

class LogCycle implements UseCase<CycleEntity, LogCycleParams> {
  final CycleRepository repository;

  LogCycle(this.repository);

  @override
  Future<Either<Failure, CycleEntity>> call(LogCycleParams params) {
    return repository.logCycle(
      userId: params.userId,
      startDate: params.startDate,
      endDate: params.endDate,
      cycleLength: params.cycleLength,
      periodLength: params.periodLength,
      flowIntensity: params.flowIntensity,
      notes: params.notes,
    );
  }
}