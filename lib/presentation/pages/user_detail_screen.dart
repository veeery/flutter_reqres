import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reqres/common/responsive.dart';
import 'package:flutter_reqres/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'package:flutter_reqres/presentation/widgets/empty_widget.dart';
import 'package:flutter_reqres/presentation/widgets/user_card.dart';

class UserDetailScreen extends StatefulWidget {
  final String id;

  const UserDetailScreen({super.key, required this.id});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<UserDetailBloc>().add(FetchUserDetail(id: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);

    return Scaffold(
      body: BlocConsumer<UserDetailBloc, UserDetailState>(
        listener: (context, state) async {

        },
        builder: (context, state) {
          if (state is UserDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserDetailLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserCard(
                  users: state.usersModel,
                  isCache: false,
                  onTap: () {

                  },
                ),
              ],
            );
          } else if (state is UserDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is UserDetailEmpty) {
            return const Center(
              child: EmptyWidget(),
            );
          } else {
            return const Center(
              child: Text("Not found"),
            );
          }
        },
      ),
    );
  }
}
