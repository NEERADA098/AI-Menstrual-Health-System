import '../../domain/entities/cycle_entity.dart';

/// CycleModel - Converts between CycleEntity (pure) and SQLite rows
/// (Map<String, dynamic>).
///
/// This is the ONLY file that should know SQLite stores data as
/// Map<String, dynamic> with snake_case column names.
class CycleModel extends CycleEntity {
  const CycleModel({
    required super.id,
    required super.userId,
    required super.startDate,
    super.endDate,
    super.cycleLength,
    super.periodLength,
    super.flowIntensity,
    super.notes,
    required super.createdAt,
    required super.updatedAt,
    super.isSynced = false,
  });

  /// Converts a SQLite row (Map) into a CycleModel object.
  /// Called every time we READ from the database.
  factory CycleModel.fromMap(Map<String, dynamic> map) {
    return CycleModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      startDate: DateTime.parse(map['start_date'] as String),
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date'] as String)
          : null,
      cycleLength: map['cycle_length'] as int?,
      periodLength: map['period_length'] as int?,
      flowIntensity: map['flow_intensity'] != null
          ? _flowFromString(map['flow_intensity'] as String)
          : null,
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      isSynced: (map['is_synced'] as int) == 1,
    );
  }

  /// Converts this CycleModel into a Map ready for SQLite to store.
  /// Called every time we WRITE to the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'cycle_length': cycleLength,
      'period_length': periodLength,
      'flow_intensity':
          flowIntensity != null ? _flowToString(flowIntensity!) : null,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      // SQLite has no native boolean type - 0 and 1 are the convention
      'is_synced': isSynced ? 1 : 0,
    };
  }

  static String _flowToString(FlowIntensity flow) {
    switch (flow) {
      case FlowIntensity.light:
        return 'light';
      case FlowIntensity.medium:
        return 'medium';
      case FlowIntensity.heavy:
        return 'heavy';
    }
  }

  static FlowIntensity _flowFromString(String value) {
    switch (value) {
      case 'light':
        return FlowIntensity.light;
      case 'heavy':
        return FlowIntensity.heavy;
      default:
        return FlowIntensity.medium;
    }
  }
}
