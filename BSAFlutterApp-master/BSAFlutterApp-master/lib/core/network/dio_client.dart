import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/injection.dart';
import '../utils/logger.dart';

class DioClient {
  static Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://miscapi.finanalyz.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'XApiKey' : 'fininternalkey'
      },
    ));
    
    // Add interceptors
    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => AppLogger.d(object.toString()),
    ));
    
    return dio;
  }
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final prefs = getIt<SharedPreferences>();
      final token = prefs.getString('auth_token');
      
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
        print('🔑 Adding token to request: ${options.path}');
      } else {
        print('🔑 No token available for request: ${options.path}');
      }
    } catch (e) {
      print('🔑 Error getting token for request: $e');
    }
    
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      print('🔑 Received 401 error, clearing token...');
      try {
        final prefs = getIt<SharedPreferences>();
        await prefs.remove('auth_token');
        print('🔑 Token cleared from storage');
      } catch (e) {
        print('🔑 Error clearing token: $e');
      }
    }
    
    handler.next(err);
  }
}
