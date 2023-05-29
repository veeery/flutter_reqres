import 'package:flutter_reqres/data/datasources/db/database_table/user_table.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/database.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    final batch = db.batch();
    db.execute('''
      CREATE TABLE ${UserTable.table} (
        ${UserTable.id} INTEGER PRIMARY KEY,
        ${UserTable.email} TEXT,
        ${UserTable.firstName} TEXT,
        ${UserTable.lastName} TEXT,
        ${UserTable.avatar} TEXT
        );
      ''');
    await batch.commit();
  }

  // User
  Future<int> insertUser({required UsersModel usersModel}) async {
    final db = await database;
    return await db!.insert(UserTable.table, usersModel.toJson());
  }

  Future<Map<String, dynamic>?> getCacheUserById({required int id}) async {
    final db = await database;
    final results = await db!.query(
      UserTable.table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(UserTable.table);
    return results;
  }
}
