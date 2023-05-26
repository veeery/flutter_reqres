import 'package:dartz/dartz.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';
import 'package:flutter_reqres/domain/repositories/users_repository.dart';

import '../../../common/failure.dart';

class CacheLoadAllUser {
  final UsersRepository repository;

  CacheLoadAllUser(this.repository);

  Future<Either<Failure, List<UsersModel>>> execute() {
    return repository.cacheAllUser();
  }

}