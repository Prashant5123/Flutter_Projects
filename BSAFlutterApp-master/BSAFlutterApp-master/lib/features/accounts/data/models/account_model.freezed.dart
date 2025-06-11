// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) {
  return _AccountModel.fromJson(json);
}

/// @nodoc
mixin _$AccountModel {
  @JsonKey(name: 'badId')
  int get badId => throw _privateConstructorUsedError;
  @JsonKey(name: 'accountName')
  String get accountName => throw _privateConstructorUsedError;
  @JsonKey(name: 'accountNumber')
  String get accountNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'bankName')
  String get bankName => throw _privateConstructorUsedError;
  @JsonKey(name: 'accountType')
  String get accountType => throw _privateConstructorUsedError;
  @JsonKey(name: 'progress', fromJson: _progressFromJson)
  int get progress => throw _privateConstructorUsedError;

  /// Serializes this AccountModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountModelCopyWith<AccountModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountModelCopyWith<$Res> {
  factory $AccountModelCopyWith(
          AccountModel value, $Res Function(AccountModel) then) =
      _$AccountModelCopyWithImpl<$Res, AccountModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'badId') int badId,
      @JsonKey(name: 'accountName') String accountName,
      @JsonKey(name: 'accountNumber') String accountNumber,
      @JsonKey(name: 'bankName') String bankName,
      @JsonKey(name: 'accountType') String accountType,
      @JsonKey(name: 'progress', fromJson: _progressFromJson) int progress});
}

/// @nodoc
class _$AccountModelCopyWithImpl<$Res, $Val extends AccountModel>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? badId = null,
    Object? accountName = null,
    Object? accountNumber = null,
    Object? bankName = null,
    Object? accountType = null,
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      badId: null == badId
          ? _value.badId
          : badId // ignore: cast_nullable_to_non_nullable
              as int,
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      accountType: null == accountType
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountModelImplCopyWith<$Res>
    implements $AccountModelCopyWith<$Res> {
  factory _$$AccountModelImplCopyWith(
          _$AccountModelImpl value, $Res Function(_$AccountModelImpl) then) =
      __$$AccountModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'badId') int badId,
      @JsonKey(name: 'accountName') String accountName,
      @JsonKey(name: 'accountNumber') String accountNumber,
      @JsonKey(name: 'bankName') String bankName,
      @JsonKey(name: 'accountType') String accountType,
      @JsonKey(name: 'progress', fromJson: _progressFromJson) int progress});
}

/// @nodoc
class __$$AccountModelImplCopyWithImpl<$Res>
    extends _$AccountModelCopyWithImpl<$Res, _$AccountModelImpl>
    implements _$$AccountModelImplCopyWith<$Res> {
  __$$AccountModelImplCopyWithImpl(
      _$AccountModelImpl _value, $Res Function(_$AccountModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? badId = null,
    Object? accountName = null,
    Object? accountNumber = null,
    Object? bankName = null,
    Object? accountType = null,
    Object? progress = null,
  }) {
    return _then(_$AccountModelImpl(
      badId: null == badId
          ? _value.badId
          : badId // ignore: cast_nullable_to_non_nullable
              as int,
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      accountType: null == accountType
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountModelImpl implements _AccountModel {
  const _$AccountModelImpl(
      {@JsonKey(name: 'badId') required this.badId,
      @JsonKey(name: 'accountName') required this.accountName,
      @JsonKey(name: 'accountNumber') required this.accountNumber,
      @JsonKey(name: 'bankName') required this.bankName,
      @JsonKey(name: 'accountType') required this.accountType,
      @JsonKey(name: 'progress', fromJson: _progressFromJson)
      required this.progress});

  factory _$AccountModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountModelImplFromJson(json);

  @override
  @JsonKey(name: 'badId')
  final int badId;
  @override
  @JsonKey(name: 'accountName')
  final String accountName;
  @override
  @JsonKey(name: 'accountNumber')
  final String accountNumber;
  @override
  @JsonKey(name: 'bankName')
  final String bankName;
  @override
  @JsonKey(name: 'accountType')
  final String accountType;
  @override
  @JsonKey(name: 'progress', fromJson: _progressFromJson)
  final int progress;

  @override
  String toString() {
    return 'AccountModel(badId: $badId, accountName: $accountName, accountNumber: $accountNumber, bankName: $bankName, accountType: $accountType, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountModelImpl &&
            (identical(other.badId, badId) || other.badId == badId) &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountType, accountType) ||
                other.accountType == accountType) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, badId, accountName,
      accountNumber, bankName, accountType, progress);

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountModelImplCopyWith<_$AccountModelImpl> get copyWith =>
      __$$AccountModelImplCopyWithImpl<_$AccountModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountModelImplToJson(
      this,
    );
  }
}

abstract class _AccountModel implements AccountModel {
  const factory _AccountModel(
      {@JsonKey(name: 'badId') required final int badId,
      @JsonKey(name: 'accountName') required final String accountName,
      @JsonKey(name: 'accountNumber') required final String accountNumber,
      @JsonKey(name: 'bankName') required final String bankName,
      @JsonKey(name: 'accountType') required final String accountType,
      @JsonKey(name: 'progress', fromJson: _progressFromJson)
      required final int progress}) = _$AccountModelImpl;

  factory _AccountModel.fromJson(Map<String, dynamic> json) =
      _$AccountModelImpl.fromJson;

  @override
  @JsonKey(name: 'badId')
  int get badId;
  @override
  @JsonKey(name: 'accountName')
  String get accountName;
  @override
  @JsonKey(name: 'accountNumber')
  String get accountNumber;
  @override
  @JsonKey(name: 'bankName')
  String get bankName;
  @override
  @JsonKey(name: 'accountType')
  String get accountType;
  @override
  @JsonKey(name: 'progress', fromJson: _progressFromJson)
  int get progress;

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountModelImplCopyWith<_$AccountModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
