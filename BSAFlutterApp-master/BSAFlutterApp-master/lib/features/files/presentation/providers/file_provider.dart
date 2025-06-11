import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../domain/repositories/file_repository.dart';
import '../../data/models/file_model.dart';

final fileRepositoryProvider = Provider<FileRepository>((ref) {
  return getIt<FileRepository>();
});

// File Upload Provider
final fileNotifierProvider = StateNotifierProvider<FileNotifier, AsyncValue<Map<String, dynamic>?>>((ref) {
  return FileNotifier(ref.read(fileRepositoryProvider));
});

class FileNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>?>> {
  final FileRepository _fileRepository;

  FileNotifier(this._fileRepository) : super(const AsyncValue.data(null));

  Future<void> uploadFile({
    required String filePath,
    required String bankName,
    required String accountType,
    required String password,
    required String odLimit,
    required String names,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final result = await _fileRepository.uploadFile(
        filePath: filePath,
        bankName: bankName,
        accountType: accountType,
        fromWhere: 'Mobile',
        password: password.isEmpty ? 'default' : password,
        userId: '1', // This should come from auth state
        odLimit: odLimit,
        names: names,
        dbName: 'finanalyzuat',
      );
      
      state = AsyncValue.data(result);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// File List Provider
final fileListNotifierProvider = StateNotifierProvider<FileListNotifier, AsyncValue<List<FileModel>>>((ref) {
  return FileListNotifier(ref.read(fileRepositoryProvider));
});

class FileListNotifier extends StateNotifier<AsyncValue<List<FileModel>>> {
  final FileRepository _fileRepository;

  FileListNotifier(this._fileRepository) : super(const AsyncValue.loading());

  Future<void> loadFiles() async {
    state = const AsyncValue.loading();

    try {
      final files = await _fileRepository.getFiles();
      // Filter out deleted files
      final activeFiles = files.where((file) => file.deleted == 0).toList();
      state = AsyncValue.data(activeFiles);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteFile(String fileId) async {
    try {
      await _fileRepository.deleteFile(fileId);
      // Reload files after deletion
      await loadFiles();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }


}

// File Download Provider
final fileDownloadNotifierProvider = StateNotifierProvider<FileDownloadNotifier, AsyncValue<List<int>?>>((ref) {
  return FileDownloadNotifier(ref.read(fileRepositoryProvider));
});

class FileDownloadNotifier extends StateNotifier<AsyncValue<List<int>?>> {
  final FileRepository _fileRepository;

  FileDownloadNotifier(this._fileRepository) : super(const AsyncValue.data(null));

  Future<void> downloadFile(String fileId) async {
    state = const AsyncValue.loading();
    
    try {
      final fileData = await _fileRepository.downloadFile(fileId);
      state = AsyncValue.data(fileData);
      
      // Here you would typically save the file to device storage
      // For now, we'll just indicate success
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
