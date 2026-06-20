import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// DatabaseHelper - The SINGLE source of truth for your SQLite database.
///
/// WHY A SINGLETON PATTERN HERE:
/// You only ever want ONE connection to the database open at a time.
/// Opening multiple connections to the same SQLite file can cause
/// data corruption or locking errors. This class guarantees that
/// no matter how many places in your app ask for the database,
/// they all get the SAME connection.
class DatabaseHelper {
  // Private constructor - prevents anyone from doing
  // DatabaseHelper() directly from outside this file
  DatabaseHelper._internal();

  // The single shared instance of this class
  static final DatabaseHelper instance = DatabaseHelper._internal();

  // The actual database connection - starts as null until first opened
  static Database? _database;

  /// Database version - INCREMENT this number whenever you change
  /// the table structure in future phases. SQLite uses this to know
  /// when to run migration code (onUpgrade).
  static const int _databaseVersion = 1;
  static const String _databaseName = 'cycleai.db';

  /// Gets the database connection, creating it if it doesn't exist yet.
  /// This is what every repository will call.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get the correct, platform-specific folder for storing app data
    // On Android: /data/data/<package>/databases/
    // On iOS: Application Support directory
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Called ONCE, the very first time the app runs on a device.
  /// This is where we define every table's structure.
  Future<void> _onCreate(Database db, int version) async {
    // ── CYCLE LOGS TABLE ──────────────────────────────────────────
    // Stores each period the user logs: when it started, ended
    await db.execute('''
      CREATE TABLE cycle_logs (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT,
        cycle_length INTEGER,
        period_length INTEGER,
        flow_intensity TEXT,
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        is_synced INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // ── SYMPTOM LOGS TABLE ────────────────────────────────────────
    // Stores symptoms tied to a specific date (Phase 5 will use this)
    await db.execute('''
      CREATE TABLE symptom_logs (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        log_date TEXT NOT NULL,
        symptom_type TEXT NOT NULL,
        severity INTEGER,
        notes TEXT,
        created_at TEXT NOT NULL,
        is_synced INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // ── SYNC QUEUE TABLE ──────────────────────────────────────────
    // Tracks which records still need to be uploaded to the server
    // once internet connectivity returns. Critical for Phase 8.
    await db.execute('''
      CREATE TABLE sync_queue (
        id TEXT PRIMARY KEY,
        table_name TEXT NOT NULL,
        record_id TEXT NOT NULL,
        operation TEXT NOT NULL,
        payload TEXT NOT NULL,
        created_at TEXT NOT NULL,
        retry_count INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Indexes speed up common queries - here, looking up a user's
    // logs sorted by date is the most frequent operation
    await db.execute(
      'CREATE INDEX idx_cycle_user_date ON cycle_logs(user_id, start_date)',
    );
    await db.execute(
      'CREATE INDEX idx_symptom_user_date ON symptom_logs(user_id, log_date)',
    );
  }

  /// Called when _databaseVersion increases - handles migrating
  /// existing users' data structure to match new table designs.
  /// Empty for now since we're still on version 1.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Future phases will add migration logic here, e.g.:
    // if (oldVersion < 2) {
    //   await db.execute('ALTER TABLE cycle_logs ADD COLUMN new_field TEXT');
    // }
  }

  /// Closes the database connection - call this when the app
  /// is being completely shut down (rarely needed manually in Flutter).
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}