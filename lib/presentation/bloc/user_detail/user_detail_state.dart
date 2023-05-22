part of 'user_detail_bloc.dart';

abstract class UserDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailEmpty extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final Users users;

  UserDetailLoaded({
    required this.users,
  });

  @override
  List<Object> get props => [users];
}

class UserDetailError extends UserDetailState {
  final String message;

  UserDetailError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
