import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';
import 'package:flutter_reqres/domain/usecases/users/cache_load_all_user.dart';
import 'package:flutter_reqres/domain/usecases/users/cache_save_user.dart';
import 'package:flutter_reqres/domain/usecases/users/cache_user_status.dart';
import '../../../domain/usecases/users/get_users.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  // remote
  final GetUsers getUsers;

  // local
  final CacheUserStatus cacheUserStatus;
  final CacheLoadAllUser cacheLoadAllUser;
  final CacheSaveUser cacheSaveUser;

  List<UsersModel> userList = [];
  int page = 1;

  // Initial Data or can be used for Refresh too
  UsersBloc({
    required this.getUsers,
    required this.cacheSaveUser,
    required this.cacheLoadAllUser,
    required this.cacheUserStatus,
  }) : super(UsersInitial()) {
    // on<FetchUsers>(onFetchUsers);
    // on<OnNextPage>(onLoadMore);
    on<FetchUsers>((event, emit) async {
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
    });
    on<OnNextPage>((event, emit) async {
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
    });
    on<SaveUserEvent>((event, emit) async {
      // emit loading
      final result = await cacheSaveUser.execute(usersModel: event.usersModel);

      result.fold(
        (l) => emit(UsersError(message: l.message)),
        (r) => emit(UserStatus(isCache: true)),
      );
    });
    on<LoadUserStatusEvent>((event, emit) async {
      final result = await cacheUserStatus.execute(id: event.userId);
      emit(UserStatus(isCache: result));
    });

    on<LoadAllUsersEvent>((event, emit) async {
      emit(UsersLoading());
      
      final result = await cacheLoadAllUser.execute();
      
      result.fold((l) {
        emit(UsersError(message: l.message));
      }, (data) {
        if (data.isEmpty) {
          emit(UsersEmpty());
        } else {
          emit(UserStatus(isCache: true));
          emit(UserCacheLoaded(usersList: data));
        }
      });
      
    });


  }
}
