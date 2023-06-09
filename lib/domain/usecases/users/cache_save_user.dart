
import 'package:dartz/dartz.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';
import 'package:flutter_reqres/domain/repositories/users_repository.dart';

import '../../../common/failure.dart';

class CacheSaveUser {

  final UsersRepository repository;

  CacheSaveUser(this.repository);

  Future<Either<Failure, String>> execute({required UsersModel usersModel}) {
    return repository.cacheSaveUsers(usersModel: usersModel);
  }

}