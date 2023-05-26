import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_reqres/common/failure.dart';
import 'package:flutter_reqres/data/datasources/users/users_remote_data_source.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';
import 'package:flutter_reqres/domain/repositories/users_repository.dart';

import '../../common/exception.dart';
import '../datasources/users/users_local_data_source.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;
  final UsersLocalDataSource localDataSource;

  UsersRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<UsersModel>>> getUsers({required int page, int perPage = 5}) async {
    try {
      final result = await remoteDataSource.getUsers(page: page, perPage: perPage);
      return Right(result.map((e) => e).toList());
    } on SocketException {
      return Left(ConnectionFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UsersModel>> getUsersDetail({required String id}) async {
    try {
      final result = await remoteDataSource.getUserDetail(id: id);
      return Right(result);
    } on SocketException {
      return Left(ConnectionFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // Local
  @override
  Future<Either<Failure, List<UsersModel>>> cacheAllUser() async {
    final result = await localDataSource.getCacheAllUsers();
    return Right(result);
  }

  @override
  Future<Either<Failure, String>> cacheSaveUsers({required UsersModel usersModel}) async {
    try {
      final result = await localDataSource.insertCacheUser(usersModel: usersModel);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isCache({required int id}) async {
    final result = await localDataSource.getCacheUserById(id: id);
    return result != null;
  }
}
