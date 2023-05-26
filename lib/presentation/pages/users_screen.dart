import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reqres/common/app_routes.dart';
import 'package:flutter_reqres/data/model/users/users_model.dart';
import 'package:flutter_reqres/presentation/bloc/users/users_bloc.dart';
import 'package:flutter_reqres/presentation/widgets/loading_widget.dart';
import 'package:flutter_reqres/presentation/widgets/loadmore_widget.dart';
import 'package:flutter_reqres/presentation/widgets/user_card.dart';

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
          context.read<UsersBloc>().add(const OnNextPage());
        },
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const LoadingWidget();
          } else if (state is UsersLoaded || state is UsersLoadMoreError) {

            if (state is UsersLoadMoreError) {
              isFailed = true;
            }

            if (state is UsersLoaded) {
              userList = state.usersList;
              hasReachedMax = state.hasReachedMax;
              isLoadingMore = state.isLoadingMore;
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
                  isCache: false,
                  onTap: () {
                    Navigator.pushNamed(context, AppPages.userDetail, arguments: user.id.toString());
                  },
                );
              },
            );
          } else if (state is UsersEmpty) {
            return const Center(
              child: EmptyWidget(),
            );
          } else if (state is UsersError) {
            return Center(
              child: Text(state.message),
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
