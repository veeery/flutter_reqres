import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reqres/presentation/bloc/users/users_bloc.dart';
import 'package:flutter_reqres/presentation/widgets/loadmore_widget.dart';
import 'package:flutter_reqres/presentation/widgets/user_card.dart';

import '../../domain/entities/users/users.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
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
          // await onTheNextPage();

          context.read<UsersBloc>().add(const OnNextPage());
        },
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(
              child: Text('Loading...'),
            );
          } else if (state is UsersLoaded) {
            return LoadMoreWidget(
              hasReachedMax: state.hasReachedMax,
              isLoadingMore: state.isLoadingMore,
              itemCount: state.usersList.length,
              // itemCount: (state.isLoadingMore || state.hasReachedMax) ? state.usersList.length + 1 : state.usersList.length,
              event: () {
                context.read<UsersBloc>().add(const OnNextPage());
              },
              itemBuilder: (context, index) {
                Users user = state.usersList[index];
                return UserCard(users: user, index: index + 1);
              },
            );
          } else if (state is UsersEmpty) {
            return const Center(
              child: Text('Empty...'),
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
