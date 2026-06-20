import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/cycle_entity.dart';
import '../../domain/repositories/cycle_repository.dart';
import '../datasources/cycle_local_datasource.dart';
import '../models/cycle_model.dart';

class CycleRepositoryImpl implements CycleRepository {
  final CycleLocalDataSource _localDataSource;

  CycleRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, CycleEntity>> logCycle({
    required String userId,
    required DateTime startDate,
    DateTime? endDate,
    int? cycleLength,
    int? periodLength,
    FlowIntensity? flowIntensity,
    String? notes,
  }) async {
    try {
      final flowString = flowIntensity?.toString().split('.').last;

      final cycle = await _localDataSource.insertCycle(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
        cycleLength: cycleLength,
        periodLength: periodLength,
        flowIntensity: flowString,
        notes: notes,
      );
      return Right(cycle);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to save cycle: $e'));
    }
  }

  @override
  Future<Either<Failure, List<CycleEntity>>> getCycleHistory(
    String userId,
  ) async {
    try {
      final cycles = await _localDataSource.getCyclesForUser(userId);
      return Right(cycles);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load cycle history: $e'));
    }
  }

  @override
  Future<Either<Failure, CycleEntity?>> getCurrentCycle(
    String userId,
  ) async {
    try {
      final cycle = await _localDataSource.getMostRecentCycle(userId);
      return Right(cycle);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load current cycle: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateCycle(CycleEntity cycle) async {
    try {
      final model = CycleModel(
        id: cycle.id,
        userId: cycle.userId,
        startDate: cycle.startDate,
        endDate: cycle.endDate,
        cycleLength: cycle.cycleLength,
        periodLength: cycle.periodLength,
        flowIntensity: cycle.flowIntensity,
        notes: cycle.notes,
        createdAt: cycle.createdAt,
        updatedAt: cycle.updatedAt,
        isSynced: cycle.isSynced,
      );
      await _localDataSource.updateCycle(model);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to update cycle: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCycle(String id) async {
    try {
      await _localDataSource.deleteCycle(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to delete cycle: $e'));
    }
  }
}
