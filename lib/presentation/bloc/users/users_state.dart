part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersEmpty extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<Users> usersList;
  final int page;
  final bool hasReachedMax;
  final bool isLoadingMore;

  UsersLoaded({
    required this.usersList,
    required this.page,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [usersList, page, hasReachedMax, isLoadingMore];
}

class UsersError extends UsersState {
  final String message;

  UsersError({required this.message});

  @override
  List<Object> get props => [message];
}
