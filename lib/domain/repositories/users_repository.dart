
import 'package:dartz/dartz.dart';
import 'package:flutter_reqres/domain/entities/users/users.dart';

import '../../common/failure.dart';

abstract class UsersRepository {
  // Remote
  Future<Either<Failure, List<Users>>> getUsers({required int page, int perPage = 5});
}