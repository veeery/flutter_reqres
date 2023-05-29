import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';
import 'package:flutter_reqres/presentation/bloc/users/users_bloc.dart';
import 'package:flutter_reqres/presentation/widgets/loading_widget.dart';
import 'package:flutter_reqres/presentation/widgets/loadmore_widget.dart';
import 'package:flutter_reqres/presentation/widgets/user_card.dart';

import '../../common/app_routes.dart';
import '../widgets/empty_widget.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<UsersModel> userList = [];
  bool isFailed = false;
  bool hasReachedMax = false;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<UsersBloc>().add(const FetchUsers());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.black,
        onPressed: () async {
          context.read<UsersBloc>().add(const LoadAllUsersEvent());
          // context.read<UsersBloc>().add(LoadCacheUsers(userId: 1));
          // context.read<UsersBloc>().add(LoadCacheAllUser());
        },
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const LoadingWidget();
          } else if (state is UsersLoaded || state is UsersLoadMoreError || state is UserStatus || state is UserCacheLoaded) {
            bool isCache = false;
            if (state is UsersLoadMoreError) {
              isFailed = true;
            }

            if (state is UsersLoaded) {
              userList = state.usersList;
              hasReachedMax = state.hasReachedMax;
              isLoadingMore = state.isLoadingMore;
            }

            if (state is UserStatus) {
              isCache = state.isCache;
            }

            if (state is UserCacheLoaded) {
              userList.clear();
              userList = state.usersList;
            }

            return LoadMoreWidget(
              hasReachedMax: hasReachedMax,
              isLoadingMore: isLoadingMore,
              isLoadMoreFailed: isFailed,
              itemCount: userList.length,
              event: () {
                context.read<UsersBloc>().add(const OnNextPage());
              },
              itemBuilder: (context, index) {
                UsersModel user = userList[index];
                return UserCard(
                  users: user,
                  isCache: isCache,
                  onTap: () {
                    context.read<UsersBloc>().add(SaveUserEvent(usersModel: user));
                    // context.read<UsersBloc>().add(SaveCacheUsers(users: user));
                    // Navigator.pushNamed(context, AppPages.userDetail, arguments: user.id.toString());
                  },
                );
              },
            );
          } else if (state is UsersError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is UsersEmpty) {
            return const Center(
              child: EmptyWidget(),
            );
          } else {
            return const Center(
              child: Text('Not Found'),
            );
          }
        },
      ),
    );
  }
}
