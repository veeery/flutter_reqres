part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class FetchUsers extends UsersEvent {
  const FetchUsers();

  @override
  List<Object> get props => [];
}

class OnNextPage extends UsersEvent {
  const OnNextPage();

  @override
  List<Object> get props => [];
}

class SaveUserEvent extends UsersEvent {
  final UsersModel usersModel;

  const SaveUserEvent({required this.usersModel});

  @override
  List<Object> get props => [usersModel];
}

class LoadUserStatusEvent extends UsersEvent {
  final int userId;

  const LoadUserStatusEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LoadAllUsersEvent extends UsersEvent {
  const LoadAllUsersEvent();

  @override
  List<Object> get props => [];
}
