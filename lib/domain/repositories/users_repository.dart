import 'package:dartz/dartz.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';

import '../../common/failure.dart';

abstract class UsersRepository {
  // Remote
  Future<Either<Failure, List<UsersModel>>> getUsers({required int page, int perPage = 5});

  Future<Either<Failure, UsersModel>> getUsersDetail({required String id});

  // Local

  Future<Either<Failure, List<UsersModel>>> cacheAllUser();

  Future<Either<Failure, String>> cacheSaveUsers({required UsersModel usersModel});

  Future<bool> isCache({required int id});
}
