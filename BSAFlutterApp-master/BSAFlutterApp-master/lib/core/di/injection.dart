import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_client.dart';
import '../network/dio_client.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/accounts/data/repositories/account_repository_impl.dart';
import '../../features/accounts/domain/repositories/account_repository.dart';
import '../../features/files/data/repositories/file_repository_impl.dart';
import '../../features/files/domain/repositories/file_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  print('🔧 Setting up dependency injection...');
  
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  print('🔧 SharedPreferences registered');
  
  // Network
  getIt.registerSingleton<Dio>(DioClient.createDio());
  getIt.registerSingleton<ApiClient>(ApiClient(getIt<Dio>()));
  print('🔧 Network dependencies registered');
  
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<ApiClient>(), getIt<SharedPreferences>()),
  );
  print('🔧 AuthRepository registered');
  
  getIt.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(getIt<ApiClient>()),
  );
  print('🔧 AccountRepository registered');
  
  getIt.registerLazySingleton<FileRepository>(
    () => FileRepositoryImpl(getIt<ApiClient>()),
  );
  print('🔧 FileRepository registered');
  
  print('🔧 Dependency injection setup complete');
}
