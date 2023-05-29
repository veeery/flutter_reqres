import 'package:flutter_reqres/domain/repositories/users_repository.dart';

class CacheUserStatus {
  final UsersRepository repository;

  CacheUserStatus(this.repository);

  Future<bool> execute({required int id}) {
    return repository.isCache(id: id);
  }
}
