import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/repositories/file_repository.dart';
import '../models/file_model.dart';

class FileRepositoryImpl implements FileRepository {
  final ApiClient _apiClient;

  FileRepositoryImpl(this._apiClient);

  @override
  Future<Map<String, dynamic>> uploadFile({
    required String filePath,
    required String bankName,
    required String accountType,
    required String fromWhere,
    required String password,
    required String userId,
    required String odLimit,
    required String names,
    required String dbName,
  }) async {
    // Create form data
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'BankName': bankName,
      'AccountType': accountType,
      'FromWhere': fromWhere,
      'Password': password,
      'UserId': userId,
      'OdLimit': odLimit,
      'Names': names,
      'DbName': dbName,
    });
    
    return await _apiClient.uploadFile(formData);
  }

  @override
  Future<List<FileModel>> getFiles() async {
    return await _apiClient.getFiles();
  }

  @override
  Future<List<int>> downloadFile(String fileId) async {
    final response = await _apiClient.downloadFile(fileId);
    return response.data ?? [];
  }

  @override
  Future<String> deleteFile(String fileId) async {
    return await _apiClient.deleteFile(fileId);
  }
}
