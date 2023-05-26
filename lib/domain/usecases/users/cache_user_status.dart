import 'package:flutter_reqres/domain/repositories/users_repository.dart';

class CacheUserStatus {
  final UsersRepository repository;

  CacheUserStatus(this.repository);

  Future<bool> execute({required int id}) async {
    return repository.isCache(id: id);
  }
}
