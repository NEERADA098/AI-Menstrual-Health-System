import 'package:equatable/equatable.dart';

/// FlowIntensity - How heavy the user's period flow is.
enum FlowIntensity { light, medium, heavy }

/// CycleEntity - Pure business representation of one logged period.
///
/// Just like UserEntity in Phase 2, this knows NOTHING about SQLite
/// or any specific database. It's the technology-agnostic "truth"
/// that the rest of your app works with.
class CycleEntity extends Equatable {
  final String id;
  final String userId;
  final DateTime startDate;
  final DateTime? endDate;
  final int? cycleLength;
  final int? periodLength;
  final FlowIntensity? flowIntensity;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;

  const CycleEntity({
    required this.id,
    required this.userId,
    required this.startDate,
    this.endDate,
    this.cycleLength,
    this.periodLength,
    this.flowIntensity,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false,
  });

  CycleEntity copyWith({
    String? id,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    int? cycleLength,
    int? periodLength,
    FlowIntensity? flowIntensity,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) {
    return CycleEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      cycleLength: cycleLength ?? this.cycleLength,
      periodLength: periodLength ?? this.periodLength,
      flowIntensity: flowIntensity ?? this.flowIntensity,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        startDate,
        endDate,
        cycleLength,
        periodLength,
        flowIntensity,
        notes,
        createdAt,
        updatedAt,
        isSynced,
      ];
}
