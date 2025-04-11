import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Работа с БД
class DBProvider {
  DBProvider._privateConstructor();

  static final DBProvider instance = DBProvider._privateConstructor();

  static Database? _database;

  static const String _databaseName = 'credit_calculations.db';
  static const String tableCalculations = 'calculations';

  static const String columnId = 'id';
  static const String columnCapital = 'capital';
  static const String columnPeriod = 'period';
  static const String columnRate = 'rate';
  static const String columnResult = 'result';
  static const String columnTimestamp = 'timestamp';

  /// Геттер для бд
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  /// Инициализация БД
  Future<Database> _initDB() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, _databaseName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// Создание структуры БД
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableCalculations (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnCapital REAL NOT NULL,
        $columnPeriod REAL NOT NULL,
        $columnRate REAL NOT NULL,
        $columnResult REAL NOT NULL,
        $columnTimestamp TEXT NOT NULL
      )
    ''');
  }

  /// Добавление расчета
  Future<int> insertCalculation(Map<String, dynamic> calculation) async {
    final db = await instance.database;
    return await db.insert(tableCalculations, calculation);
  }

  /// Получение всех расчетов
  Future<List<Map<String, dynamic>>> getAllCalculations() async {
    final db = await instance.database;
    return await db.query(
      tableCalculations,
      orderBy: '$columnTimestamp DESC',
    );
  }

  /// Получение расчета по ID
  Future<Map<String, dynamic>?> getCalculation(int id) async {
    final db = await instance.database;
    final results = await db.query(
      tableCalculations,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

  /// Удаление расчета
  Future<int> deleteCalculation(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableCalculations,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  /// Обновление расчета
  Future<int> updateCalculation(Map<String, dynamic> calculation) async {
    final db = await instance.database;
    return await db.update(
      tableCalculations,
      calculation,
      where: '$columnId = ?',
      whereArgs: [calculation[columnId]],
    );
  }
}
