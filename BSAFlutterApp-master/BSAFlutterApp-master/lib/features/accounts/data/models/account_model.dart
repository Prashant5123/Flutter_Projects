import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
class AccountModel with _$AccountModel {
  const factory AccountModel({
    @JsonKey(name: 'badId') required int badId,
    @JsonKey(name: 'accountName') required String accountName,
    @JsonKey(name: 'accountNumber') required String accountNumber,
    @JsonKey(name: 'bankName') required String bankName,
    @JsonKey(name: 'accountType') required String accountType,
    @JsonKey(name: 'progress', fromJson: _progressFromJson) required int progress,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}

// Custom converter for progress field to handle different types
int _progressFromJson(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.round();
  if (value is String) {
    final parsed = int.tryParse(value);
    if (parsed != null) return parsed;
    // Try parsing as double then convert to int
    final parsedDouble = double.tryParse(value);
    if (parsedDouble != null) return parsedDouble.round();
    return 0;
  }
  return 0;
}
