import 'package:dio/dio.dart';
import 'package:flutter_reqres/app_dio.dart';
import 'package:flutter_reqres/common/constants.dart';
import 'package:flutter_reqres/common/exception.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';

abstract class UsersRemoteDataSource {
  Future<List<UsersModel>> getUsers({required int page, int perPage = 5});

  Future<UsersModel> getUserDetail({required String id});
}

class UsersRemoteDataSourceImpl extends UsersRemoteDataSource {
  final DioClient dioClient;

  UsersRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<UsersModel>> getUsers({required int page, int perPage = 5}) async {
    List<UsersModel> usersModel = [];
    Response response = await dioClient.get("$baseUrl/api/users?page=$page&per_page=$perPage");

    if (response.statusCode == 200) {
      List<dynamic> result = response.data["data"];

      for (var data in result) {
        usersModel.add(UsersModel.fromJson(data));
      }

      return usersModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UsersModel> getUserDetail({required String id}) async {
    Response response = await dioClient.get("$baseUrl/api/users/$id");

    if (response.statusCode == 200) {
      return UsersModel.fromJson(response.data["data"]);
    } else {
      throw ServerException();
    }
  }
}
