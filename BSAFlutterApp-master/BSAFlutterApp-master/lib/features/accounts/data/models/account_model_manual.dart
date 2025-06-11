class AccountModelManual {
  final int badId;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String accountType;
  final int progress;

  AccountModelManual({
    required this.badId,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.accountType,
    required this.progress,
  });

  factory AccountModelManual.fromJson(Map<String, dynamic> json) {
    return AccountModelManual(
      badId: _parseId(json['badId']),
      accountName: _parseString(json['accountName']),
      accountNumber: _parseString(json['accountNumber']),
      bankName: _parseString(json['bankName']),
      accountType: _parseString(json['accountType']),
      progress: _parseProgress(json['progress']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'badId': badId,
      'accountName': accountName,
      'accountNumber': accountNumber,
      'bankName': bankName,
      'accountType': accountType,
      'progress': progress,
    };
  }

  static int _parseId(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static String _parseString(dynamic value) {
    if (value == null) return '--';
    if (value is String) return value.trim();
    return value.toString();
  }

  static int _parseProgress(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) return parsed;
      final parsedDouble = double.tryParse(value);
      if (parsedDouble != null) return parsedDouble.round();
    }
    return 0;
  }
}
