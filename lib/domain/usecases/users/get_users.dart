import 'package:dartz/dartz.dart';
import 'package:flutter_reqres/domain/entities/users/users.dart';
import 'package:flutter_reqres/domain/repositories/users_repository.dart';

import '../../../common/failure.dart';
import '../../../data/model/users/users_model.dart';

class GetUsers {
  final UsersRepository repository;

  GetUsers(this.repository);

  Future<Either<Failure, List<UsersModel>>> execute({required int page, int perPage = 5}) {
    return repository.getUsers(page: page, perPage: perPage);
  }
}
