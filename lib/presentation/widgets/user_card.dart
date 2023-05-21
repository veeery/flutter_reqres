import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reqres/domain/entities/users/users.dart';

import '../../common/responsive.dart';

class UserCard extends StatelessWidget {
  final Function() onTap;
  final Users users;
  final int index;

  const UserCard({super.key, required this.users, required this.onTap, this.index = 1});

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minHeight: 5.h),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(2.w),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 1.h,
        ),
        padding: EdgeInsets.all(2.w),
        child: Row(
          children: [
            buildAvatar(),
            SizedBox(width: 2.w),
            buildAttachmentData(),
          ],
        ),
      ),
    );
  }

  Widget buildAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10000),
      child: CachedNetworkImage(
        height: 15.h,
        width: 25.w,
        imageUrl: users.avatar.toString(),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildAttachmentData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${users.firstName} ${users.lastName}"),
        Text(users.email),
      ],
    );
  }
}
