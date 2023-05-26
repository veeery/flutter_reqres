import 'package:flutter_reqres/common/exception.dart';
import 'package:flutter_reqres/data/datasources/db/database_helper.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';

abstract class UsersLocalDataSource {
  Future<List<UsersModel>> getCacheAllUsers();
  Future<String> insertCacheUser({required UsersModel usersModel});
  Future<UsersModel?> getCacheUserById({required int id});
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  final DatabaseInstance databaseInstance;

  UsersLocalDataSourceImpl({required this.databaseInstance});

  @override
  Future<List<UsersModel>> getCacheAllUsers() async {
    List<UsersModel> result = await databaseInstance.getAllUsers();
    return result;
  }

  @override
  Future<String> insertCacheUser({required UsersModel usersModel}) async {
    try {
      final data = await databaseInstance.insertUser(usersModel: usersModel);
      return "Added";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<UsersModel?> getCacheUserById({required int id}) async {
    final result = await databaseInstance.getCacheUserById(id);
    if (result != null) {
      return UsersModel.fromJson(result);
    } else {
      return null;
    }
  }
}
