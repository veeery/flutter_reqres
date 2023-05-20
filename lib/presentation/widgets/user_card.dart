import 'package:flutter/material.dart';
import 'package:flutter_reqres/domain/entities/users/users.dart';

import '../../common/responsive.dart';

class UserCard extends StatelessWidget {
  final Users users;
  final int index;

  const UserCard({super.key, required this.users, this.index = 1});

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);
    return Container(
      constraints: BoxConstraints(minHeight: 5.h),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(2.w),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 10.h,
      ),
      child: Column(
        children: [
          Text("${index}. ${users.firstName} ${users.lastName}"),
        ],
      ),
    );
  }
}
