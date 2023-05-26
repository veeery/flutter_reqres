import 'dart:io';

import 'package:flutter_reqres/data/model/users/users_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/users/users.dart';

class DatabaseInstance {
  final String databaseName = 'database.db';
  final int databaseVersion = 1;

  // User Table
  final String table = 'user';
  final String id = 'id';
  final String firstName = 'firstName';
  final String lastName = 'lastName';
  final String avatar = 'avatar';

  Database? database;

  Future<Database> startDatabase() async {
    if (database != null) return database!;
    database = await initDatabase();
    return database!;
  }

  Future initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, databaseName);
    return openDatabase(path);
  }

  Future onCreate(Database db, int version) async {
    final batch = db.batch();
    await db
        .execute('CREATE TABLE $table ($id INTEGER PRIMARY KEY, $firstName TEXT, $lastName TEXT, $avatar TEXT NULL');
    await batch.commit();
  }

  // User Function Local Save
  Future<List<UsersModel>> getAllUsers() async {
    final data = await database!.query(table);
    List<UsersModel> result = data.map((e) => UsersModel.fromJson(e)).toList();

    return result;
  }

  Future<int> insertUser({required UsersModel usersModel}) async {
    return await database!.insert(table, usersModel.toJson());
  }

  Future<Map<String, dynamic>?> getCacheUserById(int id) async {
    final result = await database!.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }
}
