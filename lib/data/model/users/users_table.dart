import 'package:equatable/equatable.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';
import 'package:flutter_reqres/domain/entities/users/users.dart';

class UserTable extends Equatable {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final Uri avatar;

  const UserTable({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  factory UserTable.fromEntity(UsersModel usersModel) {
    return UserTable(
      id: usersModel.id,
      firstName: usersModel.firstName,
      lastName: usersModel.lastName,
      email: usersModel.email,
      avatar: usersModel.avatar,
    );
  }

  factory UserTable.fromMap(Map<String, dynamic> map) {
    return UserTable(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      avatar: map['avatar'],
    );
  }

  // Users toEntity() {
  //   return Users(
  //     id: id,
  //     firstName: firstName,
  //     lastName: lastName,
  //     email: email,
  //     avatar: avatar,
  //   );
  // }

  @override
  List<Object?> get props => [id, email, firstName, lastName, avatar];
}
