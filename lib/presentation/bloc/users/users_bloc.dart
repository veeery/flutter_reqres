import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';
import 'package:flutter_reqres/domain/usecases/users/cache_user_status.dart';

import '../../../domain/usecases/users/cache_load_all_user.dart';
import '../../../domain/usecases/users/cache_save_user.dart';
import '../../../domain/usecases/users/get_users.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  // remote
  final GetUsers getUsers;

  // local / cache
  final CacheSaveUsers cacheSaveUsers;
  final CacheLoadAllUser cacheLoadAllUser;
  final CacheUserStatus cacheUserStatus;

  List<UsersModel> userList = [];
  int page = 1;

  // Initial Data or can be used for Refresh too
  UsersBloc({
    required this.getUsers,
    required this.cacheSaveUsers,
    required this.cacheLoadAllUser,
    required this.cacheUserStatus,
  }) : super(UsersInitial()) {
    on<FetchUsers>(onFetchUsers);
    on<OnNextPage>(onLoadMore);
    on<SaveCacheUsers>(onCacheSaveUsers);
    on<LoadCacheUsers>(onCacheLoadUsers);
  }

  Future<void> onFetchUsers(event, emit) async {
    emit(UsersLoading());

    page = 1;

    final result = await getUsers.execute(page: page);

    result.fold(
      (failure) {
        emit(UsersError(message: failure.message));
      },
      (dataUsersList) {
        if (dataUsersList.isEmpty) {
          emit(UsersEmpty());
        } else {
          userList = [];
          userList = dataUsersList;
          emit(UsersLoaded(usersList: userList, page: page));
        }
      },
    );
  }

  Future<void> onLoadMore(event, emit) async {
    page++;

    emit(UsersLoaded(usersList: userList, page: page, isLoadingMore: true));
    final result = await getUsers.execute(page: page);

    result.fold(
      (failure) {
        page--;
        emit(UsersLoadMoreError());
      },
      (dataLoadMore) {
        if (dataLoadMore.isNotEmpty) {
          userList.addAll(dataLoadMore);
          emit(UsersLoaded(usersList: userList, page: page, isLoadingMore: false));
        } else {
          emit(UsersLoaded(usersList: userList, page: page, hasReachedMax: true));
        }
      },
    );
  }

  Future<void> onCacheSaveUsers(event, emit) async {
    final user = event.users;
    emit(UsersLoading());
    final result = await cacheSaveUsers.execute(usersModel: user);

    result.fold(
      (l) => emit(UsersError(message: l.message)),
      (r) => emit(UsersCache(isCache: true)),
    );
  }

  Future<void> onCacheLoadUsers(event, emit) async {
    emit(UsersLoading());

    page = 1;

    final result = await cacheLoadAllUser.execute();

    result.fold(
      (failure) {
        emit(UsersError(message: failure.message));
      },
      (dataLocal) {
        if (dataLocal.isEmpty) {
          emit(UsersEmpty());
        } else {
          userList = [];
          userList = dataLocal;
          emit(UsersLoaded(usersList: userList, page: page));
        }
      },
    );
  }
}
