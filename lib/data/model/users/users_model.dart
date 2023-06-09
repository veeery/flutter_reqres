import '../../../domain/entities/users/users.dart';

class UsersModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UsersModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  factory UsersModel.fromDatabase(Map<String, dynamic> json) {
    return UsersModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      avatar: json['avatar'],
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName' : firstName,
      'lastName' : lastName,
      'email': email,
      'avatar': avatar,
    };
  }

}
