
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  Future<Database> get database async{
    if (_database != null){
      return _database!;
    }

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "/history.db";
    print("Database path: $path"); 
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async{
    print("Создвно"); // ← Это можно увидеть в логах
    await db.execute("""CREATE TABLE History(
                              id INTEGER PRIMARY KEY AUTOINCREMENT,
                              mass REAL,
                              radius REAL,
                              result REAL,
                              created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now')));""");
  }

  Future<void> addRecord(Map<String,dynamic> record) async{
    Database db = await this.database;
    
    await db.insert("History",record);
  }

  Future<List<Map<String,dynamic>>> getHistory() async {
  Database db = await this.database;
  
  final List<Map<String,dynamic>> data = await db.query(
    "History",
    orderBy: "created_at DESC"  // Сортировка по убыванию (новые записи сначала)
  );
  
 
  return data;
}

  Future<List<Map<String,dynamic>>> getRecord(int id) async{
    Database db = await this.database;
    final List<Map<String,dynamic>> data;
    data = await db.query("History",where: "id = ?", whereArgs: [id]);
    return data;
  }

  Future<int> deleteRecord(int id) async{
    Database db = await this.database;
    return await db.delete("History",where: "id = ?", whereArgs: [id]);
  } 

  Future<int> updateRecord(Map<String,dynamic> record, int id) async{
    Database db = await this.database;
    return await db.update("History",record,where: "id = ?", whereArgs: [id]);
  } 
}