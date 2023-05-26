import 'package:dartz/dartz.dart';
import 'package:flutter_reqres/domain/entities/users/users.dart';
import 'package:flutter_reqres/domain/repositories/users_repository.dart';

import '../../../common/failure.dart';
import '../../../data/model/users/users_model.dart';

class GetUserDetail {
  final UsersRepository repository;

  GetUserDetail(this.repository);

  Future<Either<Failure, UsersModel>> execute({required String id}) {
    return repository.getUsersDetail(id: id);
  }
}
