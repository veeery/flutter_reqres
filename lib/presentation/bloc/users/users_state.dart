part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersEmpty extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoadMoreError extends UsersState {}

class UsersLoaded extends UsersState {
  final List<UsersModel> usersList;
  final int page;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final bool isFailed;

  UsersLoaded({
    required this.usersList,
    required this.page,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.isFailed = false,
  });

  @override
  List<Object> get props => [usersList, page, hasReachedMax, isLoadingMore, isFailed];
}

class UsersError extends UsersState {
  final String message;

  UsersError({required this.message});

  @override
  List<Object> get props => [message];
}

class UsersCache extends UsersState {
  final bool isCache;

  UsersCache({required this.isCache});

  @override
  List<Object> get props => [isCache];
}


