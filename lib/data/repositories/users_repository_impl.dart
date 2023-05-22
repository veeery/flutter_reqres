import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_reqres/common/failure.dart';
import 'package:flutter_reqres/data/datasources/users/users_remote_data_source.dart';
import 'package:flutter_reqres/domain/entities/users/users.dart';
import 'package:flutter_reqres/domain/repositories/users_repository.dart';

import '../../common/exception.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;

  UsersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Users>>> getUsers({required int page, int perPage = 5}) async {
    try {
      final result = await remoteDataSource.getUsers(page: page, perPage: perPage);
      return Right(result.map((e) => e.toEntity()).toList());
    } on SocketException {
      return Left(ConnectionFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Users>> getUsersDetail({required String id}) async {
    try {
      final result = await remoteDataSource.getUserDetail(id: id);
      return Right(result.toEntity());
    } on SocketException {
      return Left(ConnectionFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
