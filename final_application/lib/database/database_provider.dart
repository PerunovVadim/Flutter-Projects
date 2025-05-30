import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "/history_weather.db";
    print("Database path: $path");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute("""
      CREATE TABLE weather_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        city_name TEXT,
        temperature REAL,
        feels_like REAL,
        humidity INTEGER,
        pressure INTEGER,
        wind_speed REAL,
        weather_description TEXT,
        icon_code TEXT,
        country_code TEXT,
        created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now'))
      )
    """);
    
    await db.execute("""
      CREATE TABLE calc_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        temperature REAL,
        humidity REAL,
        result REAL,
        created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now'))
      )
    """);
  }

  // Методы для таблицы weather_history
  Future<int> addWeatherRecord(Map<String, dynamic> record) async {
    final db = await database;
    return await db.insert("weather_history", record);
  }

  Future<List<Map<String, dynamic>>> getWeatherHistory() async {
    final db = await database;
    return await db.query(
      "weather_history",
      orderBy: "created_at DESC",
    );
  }

  Future<List<Map<String, dynamic>>> getWeatherRecord(int id) async {
    final db = await database;
    return await db.query(
      "weather_history",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> deleteWeatherRecord(int id) async {
    final db = await database;
    return await db.delete(
      "weather_history",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateWeatherRecord(Map<String, dynamic> record, int id) async {
    final db = await database;
    return await db.update(
      "weather_history",
      record,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Методы для таблицы calc_history
  Future<int> addCalcRecord(Map<String, dynamic> record) async {
    final db = await database;
    return await db.insert("calc_history", record);
  }

  Future<List<Map<String, dynamic>>> getCalcHistory() async {
    final db = await database;
    return await db.query(
      "calc_history",
      orderBy: "created_at DESC",
    );
  }

  Future<List<Map<String, dynamic>>> getCalcRecord(int id) async {
    final db = await database;
    return await db.query(
      "calc_history",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> deleteCalcRecord(int id) async {
    final db = await database;
    return await db.delete(
      "calc_history",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateCalcRecord(Map<String, dynamic> record, int id) async {
    final db = await database;
    return await db.update(
      "calc_history",
      record,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Общие методы
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}