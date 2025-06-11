import '../../data/models/file_model.dart';

abstract class FileRepository {
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
  });
  
  Future<List<FileModel>> getFiles();
  Future<List<int>> downloadFile(String fileId);
  Future<String> deleteFile(String fileId);
}
