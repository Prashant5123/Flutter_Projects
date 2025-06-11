import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_client.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/interceptors/logging_interceptor.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/accounts/domain/repositories/account_repository.dart';
import '../../features/accounts/data/repositories/account_repository_impl.dart';
import '../../features/files/domain/repositories/file_repository.dart';
import '../../features/files/data/repositories/file_repository_impl.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(sharedPreferences);

  // Dio setup
  final dio = Dio(BaseOptions(
    baseUrl: 'https://your-api-base-url.com', // Replace with your actual API URL
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  ));

  // Add interceptors
  dio.interceptors.add(AuthInterceptor(sharedPreferences));
  dio.interceptors.add(LoggingInterceptor());

  serviceLocator.registerSingleton<Dio>(dio);

  // API Client
  serviceLocator.registerSingleton<ApiClient>(ApiClient(dio));

  // Repositories
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator<ApiClient>(), sharedPreferences),
  );

  serviceLocator.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(serviceLocator<ApiClient>()),
  );

  serviceLocator.registerLazySingleton<FileRepository>(
    () => FileRepositoryImpl(serviceLocator<ApiClient>()),
  );
}
