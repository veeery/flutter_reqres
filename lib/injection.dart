import 'package:dio/dio.dart';
import 'package:flutter_reqres/data/datasources/users/users_remote_data_source.dart';
import 'package:flutter_reqres/data/repositories/users_repository_impl.dart';
import 'package:flutter_reqres/domain/repositories/users_repository.dart';
import 'package:flutter_reqres/domain/usecases/users/get_user_detail.dart';
import 'package:flutter_reqres/domain/usecases/users/get_users.dart';
import 'package:flutter_reqres/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'package:flutter_reqres/presentation/bloc/users/users_bloc.dart';
import 'package:get_it/get_it.dart';

import 'app_dio.dart';

final locator = GetIt.instance;

void init() {
  // BLoC
  locator.registerFactory(() => UsersBloc(getUsers: locator()));
  locator.registerFactory(() => UserDetailBloc(getUserDetail: locator()));

  // Use case
  locator.registerLazySingleton(() => GetUsers(locator()));
  locator.registerLazySingleton(() => GetUserDetail(locator()));

  // Repository
  locator.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(remoteDataSource: locator()));

  // Data Source
  locator.registerLazySingleton<UsersRemoteDataSource>(() => UsersRemoteDataSourceImpl(dioClient: locator()));

  // External
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerSingleton<DioClient>(DioClient(locator<Dio>()));
}
