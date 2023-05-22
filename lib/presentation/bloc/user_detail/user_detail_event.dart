part of 'user_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();
}

class FetchUserDetail extends UserDetailEvent {
  final String id;

  const FetchUserDetail({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
