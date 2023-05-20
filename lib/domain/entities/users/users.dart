import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final Uri avatar;

  const Users({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id, email, firstName, lastName, avatar];
}
