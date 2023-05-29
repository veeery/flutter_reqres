import 'package:flutter_reqres/common/exception.dart';
import 'package:flutter_reqres/data/datasources/db/database_helper.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';

abstract class UsersLocalDataSource {
  Future<List<UsersModel>> getCacheAllUsers();
  Future<String> insertCacheUser({required UsersModel usersModel});
  Future<UsersModel?> getCacheUserById({required int id});
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  final DatabaseHelper databaseHelper;

  UsersLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<UsersModel>> getCacheAllUsers() async {
    final result = await databaseHelper.getAllUsers();
    return result.map((data) => UsersModel.fromDatabase(data)).toList();
  }

  @override
  Future<String> insertCacheUser({required UsersModel usersModel}) async {
    try {
      final data = await databaseHelper.insertUser(usersModel: usersModel);
      return "Added";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<UsersModel?> getCacheUserById({required int id}) async {
    final result = await databaseHelper.getCacheUserById(id: id);
    if (result != null) {
      return UsersModel.fromJson(result);
    } else {
      return null;
    }
  }
}
