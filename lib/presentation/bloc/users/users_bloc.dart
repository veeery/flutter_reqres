import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/users/users.dart';
import '../../../domain/usecases/users/get_users.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsers getUsers;
  List<Users> userList = [];
  int page = 1;

  // Initial Data or can be used for Refresh too

  UsersBloc({required this.getUsers}) : super(UsersInitial()) {
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

    // Load More
    on<OnNextPage>((event, emit) async {
      page++;

      emit(UsersLoaded(usersList: userList,page: page,isLoadingMore: true));
      final result = await getUsers.execute(page: page);

      result.fold(
        (failure) {
          page--;
          emit(UsersError(message: failure.message));
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
  }
}
