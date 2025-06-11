class FileModel {
  final int fileId;
  final String filePath;
  final int uploadBy;
  final bool deleted;

  FileModel({
    required this.fileId,
    required this.filePath,
    required this.uploadBy,
    required this.deleted,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      fileId: json['fileId'],
      filePath: json['filePath'],
      uploadBy: json['uploadBy'],
      deleted: json['deleted'],
    );
  }
}
