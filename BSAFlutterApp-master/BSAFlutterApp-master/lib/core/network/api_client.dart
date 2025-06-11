import 'package:dio/dio.dart';

import '../../features/auth/data/models/login_request.dart';
import '../../features/auth/data/models/login_response.dart';
import '../../features/auth/data/models/register_request.dart';
import '../../features/accounts/data/models/account_model.dart';
import '../../features/files/data/models/file_model.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  // Auth endpoints
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post('/api/Auth/login', data: request.toJson());
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      print('🔴 Login API error: $e');
      rethrow;
    }
  }

  Future<String> register(RegisterRequest request) async {
    try {
      final response = await _dio.post('/api/Auth/register', data: request.toJson());
      return response.data as String;
    } catch (e) {
      print('🔴 Register API error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await _dio.post('/api/Auth/logout');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('🔴 Logout API error: $e');
      rethrow;
    }
  }

  Future<void> validateToken() async {
    try {
      await _dio.get('/api/Auth/validate');
    } catch (e) {
      print('🔴 Token validation error: $e');
      rethrow;
    }
  }

  // Account endpoints
  Future<List<AccountModel>> getAccounts() async {
    try {
      print('🏦 Fetching accounts from API...');
      final response = await _dio.get('/api/Auth/ListAllAccounts');

      if (response.data == null) {
        print('🔴 API returned null data');
        return [];
      }

      final List<dynamic> data = response.data as List<dynamic>;
      print('🏦 Received ${data.length} accounts from API');

      final List<AccountModel> accounts = [];

      for (int i = 0; i < data.length; i++) {
        try {
          final accountJson = data[i] as Map<String, dynamic>;
          final sanitizedJson = _sanitizeAccountJson(accountJson);
          final account = AccountModel.fromJson(sanitizedJson);
          accounts.add(account);
        } catch (e) {
          print('🔴 Error parsing account at index $i: $e');
          print('🔴 Account data: ${data[i]}');
          continue;
        }
      }

      print('🏦 Successfully parsed ${accounts.length} accounts');
      return accounts;
    } catch (e) {
      print('🔴 Get accounts API error: $e');
      rethrow;
    }
  }

  Map<String, dynamic> _sanitizeAccountJson(Map<String, dynamic> json) {
    return {
      'badId': _sanitizeInt(json['badId']),
      'accountName': _sanitizeString(json['accountName']),
      'accountNumber': _sanitizeString(json['accountNumber']),
      'bankName': _sanitizeString(json['bankName']),
      'accountType': _sanitizeString(json['accountType']),
      'progress': json['progress'],
    };
  }

  int _sanitizeInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String) {
      final parsed = int.tryParse(value);
      return parsed ?? 0;
    }
    return 0;
  }

  String _sanitizeString(dynamic value) {
    if (value == null) return '--';
    if (value is String) return value.trim();
    return value.toString();
  }

  // Export Excel endpoint
  Future<String> exportExcel(List<String> accountIds) async {
    try {
      final response = await _dio.post(
        '/api/Auth/ExportExcel',
        data: accountIds,
      );
      final data = response.data as Map<String, dynamic>;
      if (data['downloadUrl'] == null) {
        throw Exception('No download URL provided in response');
      }
      return data['downloadUrl'] as String;
    } catch (e) {
      print('🔴 Export Excel API error: $e');
      rethrow;
    }
  }

  Future<List<int>> downloadExcelFile(String downloadUrl) async {
    try {
      final response = await _dio.get(
        downloadUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      return response.data as List<int>;
    } catch (e) {
      print('🔴 Download Excel file error: $e');
      rethrow;
    }
  }

  // File endpoints
  Future<Map<String, dynamic>> uploadFile(FormData formData) async {
    try {
      final response = await _dio.post('/api/Auth/upload', data: formData);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('🔴 Upload file API error: $e');
      rethrow;
    }
  }

  Future<List<FileModel>> getFiles() async {
    try {
      final response = await _dio.get('/api/Auth/listfiles');
      print('📂 API Response: ${response.data}'); // Log raw response
      if (response.data == null) {
        print('🔴 API returned null data');
        return [];
      }
      final List<dynamic> data = response.data as List<dynamic>;
      print('📂 Received ${data.length} files from API');
      final List<FileModel> files = [];
      for (int i = 0; i < data.length; i++) {
        try {
          final fileJson = data[i] as Map<String, dynamic>;
          final file = FileModel.fromJson(fileJson);
          files.add(file);
        } catch (e) {
          print('🔴 Error parsing file at index $i: $e');
          continue;
        }
      }
      print('📂 Successfully parsed ${files.length} files');
      return files;
    } catch (e) {
      print('🔴 Get files API error: $e');
      rethrow;
    }
  }
  Future<Response<List<int>>> downloadFile(String fileId) async {
    try {
      final response = await _dio.get(
        '/api/Auth/download/$fileId',
        options: Options(responseType: ResponseType.bytes),
      );
      return Response<List<int>>(
        data: response.data as List<int>,
        requestOptions: response.requestOptions,
        statusCode: response.statusCode,
      );
    } catch (e) {
      print('🔴 Download file API error: $e');
      rethrow;
    }
  }
  Future<String> getDownloadUrl(int fileId) async {
    // Replace this with your actual API call
    final response = await _dio.get('https://miscapi.finanalyz.com/api/Auth/ExportExcel', queryParameters: {
      'fileId': fileId,
    });

    if (response.statusCode == 200 && response.data['downloadUrl'] != null) {
      return response.data['downloadUrl'];
    } else {
      throw Exception('Download URL not found');
    }
  }



  Future<String> deleteFile(String fileId) async {
    try {
      final response = await _dio.delete('/api/Auth/deletefile/$fileId');
      return response.data as String;
    } catch (e) {
      print('🔴 Delete file API error: $e');
      rethrow;
    }
  }
}