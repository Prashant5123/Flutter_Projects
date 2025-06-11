import 'package:dio/dio.dart';
import 'api_exception.dart';

class NetworkException extends ApiException {
  NetworkException(super.message, {super.statusCode, super.data});

  factory NetworkException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException('Connection timeout');
      case DioExceptionType.sendTimeout:
        return NetworkException('Send timeout');
      case DioExceptionType.receiveTimeout:
        return NetworkException('Receive timeout');
      case DioExceptionType.badResponse:
        return NetworkException(
          'Server error: ${dioError.response?.statusMessage ?? 'Unknown error'}',
          statusCode: dioError.response?.statusCode,
          data: dioError.response?.data,
        );
      case DioExceptionType.cancel:
        return NetworkException('Request cancelled');
      case DioExceptionType.connectionError:
        return NetworkException('Connection error');
      case DioExceptionType.badCertificate:
        return NetworkException('Bad certificate');
      case DioExceptionType.unknown:
      default:
        return NetworkException('Network error: ${dioError.message}');
    }
  }
}
