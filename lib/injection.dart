import 'package:dio/dio.dart';
import 'package:flutter_reqres/data/datasources/db/database_helper.dart';
import 'package:flutter_reqres/data/datasources/users/users_local_data_source.dart';
import 'package:flutter_reqres/data/datasources/users/users_remote_data_source.dart';
import 'package:flutter_reqres/data/repositories/users_repository_impl.dart';
import 'package:flutter_reqres/domain/repositories/users_repository.dart';
import 'package:flutter_reqres/domain/usecases/users/cache_load_all_user.dart';
import 'package:flutter_reqres/domain/usecases/users/cache_save_user.dart';
import 'package:flutter_reqres/domain/usecases/users/cache_user_status.dart';
import 'package:flutter_reqres/domain/usecases/users/get_user_detail.dart';
import 'package:flutter_reqres/domain/usecases/users/get_users.dart';
import 'package:flutter_reqres/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'package:flutter_reqres/presentation/bloc/users/users_bloc.dart';
import 'package:get_it/get_it.dart';

import 'app_dio.dart';

final locator = GetIt.instance;

void init() {
  // BLoC
  locator.registerFactory(
    () => UsersBloc(
      getUsers: locator(),
      cacheLoadAllUser: locator(),
      cacheSaveUser: locator(),
      cacheUserStatus: locator(),
    ),
  );
  locator.registerFactory(() => UserDetailBloc(getUserDetail: locator()));

  // Use case
  locator.registerLazySingleton(() => GetUsers(locator()));
  locator.registerLazySingleton(() => GetUserDetail(locator()));
  locator.registerLazySingleton(() => CacheSaveUser(locator()));
  locator.registerLazySingleton(() => CacheLoadAllUser(locator()));
  locator.registerLazySingleton(() => CacheUserStatus(locator()));

  // Repository
  locator.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // Data Source
  locator.registerLazySingleton<UsersRemoteDataSource>(() => UsersRemoteDataSourceImpl(dioClient: locator()));
  locator.registerLazySingleton<UsersLocalDataSource>(() => UsersLocalDataSourceImpl(databaseHelper: locator()));

  // Database Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // External
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerSingleton<DioClient>(DioClient(locator<Dio>()));
}
