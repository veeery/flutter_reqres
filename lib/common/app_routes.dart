import 'package:flutter/material.dart';
import 'package:flutter_reqres/presentation/pages/user_detail_screen.dart';
import 'package:flutter_reqres/presentation/pages/users_screen.dart';

class AppPages {
  static const String users = "/users";
  static const String userDetail = "/user-detail";
}

class AppRoutes {
  static route({required RouteSettings settings}) {
    switch (settings.name) {
      case AppPages.users:
        return MaterialPageRoute(builder: (_) => const UsersScreen());
      case AppPages.userDetail:
        String id = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => UserDetailScreen(id: id),
          settings: settings,
        );
    }
  }
}
