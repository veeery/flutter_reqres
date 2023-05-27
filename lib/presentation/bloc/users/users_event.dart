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
//
// class SaveCacheUsers extends UsersEvent {
//   final UsersModel users;
//
//   const SaveCacheUsers({required this.users});
//
//   @override
//   List<Object> get props => [users];
// }
//
// class LoadCacheUsers extends UsersEvent {
//   final int userId;
//
//   const LoadCacheUsers({required this.userId});
//
//   @override
//   List<Object> get props => [userId];
// }
//
// class LoadCacheAllUser extends UsersEvent {
//   @override
//   List<Object> get props => [];
//
// }