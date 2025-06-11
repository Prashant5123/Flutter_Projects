import 'package:dio/dio.dart';
import '../../utils/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.d('🌐 REQUEST: ${options.method} ${options.uri}');
    AppLogger.d('🌐 Headers: ${options.headers}');
    if (options.data != null) {
      AppLogger.d('🌐 Data: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.d('🌐 RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');
    AppLogger.d('🌐 Data: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e('🌐 ERROR: ${err.message}');
    AppLogger.e('🌐 Response: ${err.response?.data}');
    handler.next(err);
  }
}
