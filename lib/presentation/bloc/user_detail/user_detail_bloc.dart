import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_reqres/domain/entities/users/users.dart';

import '../../../domain/usecases/users/get_user_detail.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final GetUserDetail getUserDetail;

  UserDetailBloc({required this.getUserDetail}) : super(UserDetailInitial()) {
    on<FetchUserDetail>((event, emit) async {
      emit(UserDetailLoading());

      final result = await getUserDetail.execute(id: event.id);

      result.fold(
        (failure) => emit(UserDetailError(message: failure.message)),
        (userDetail) => emit(UserDetailLoaded(users: userDetail)),
      );
    });
  }
}
