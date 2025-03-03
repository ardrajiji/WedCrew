// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_package_selection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserPackageSelectionModel _$UserPackageSelectionModelFromJson(
    Map<String, dynamic> json) {
  return _UserPackageSelectionModel.fromJson(json);
}

/// @nodoc
mixin _$UserPackageSelectionModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  int? get maxGuests => throw _privateConstructorUsedError;
  String? get services => throw _privateConstructorUsedError;
  String? get extraServices => throw _privateConstructorUsedError;

  /// Serializes this UserPackageSelectionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPackageSelectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPackageSelectionModelCopyWith<UserPackageSelectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPackageSelectionModelCopyWith<$Res> {
  factory $UserPackageSelectionModelCopyWith(UserPackageSelectionModel value,
          $Res Function(UserPackageSelectionModel) then) =
      _$UserPackageSelectionModelCopyWithImpl<$Res, UserPackageSelectionModel>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? price,
      int? maxGuests,
      String? services,
      String? extraServices});
}

/// @nodoc
class _$UserPackageSelectionModelCopyWithImpl<$Res,
        $Val extends UserPackageSelectionModel>
    implements $UserPackageSelectionModelCopyWith<$Res> {
  _$UserPackageSelectionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPackageSelectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? price = freezed,
    Object? maxGuests = freezed,
    Object? services = freezed,
    Object? extraServices = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      maxGuests: freezed == maxGuests
          ? _value.maxGuests
          : maxGuests // ignore: cast_nullable_to_non_nullable
              as int?,
      services: freezed == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as String?,
      extraServices: freezed == extraServices
          ? _value.extraServices
          : extraServices // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPackageSelectionModelImplCopyWith<$Res>
    implements $UserPackageSelectionModelCopyWith<$Res> {
  factory _$$UserPackageSelectionModelImplCopyWith(
          _$UserPackageSelectionModelImpl value,
          $Res Function(_$UserPackageSelectionModelImpl) then) =
      __$$UserPackageSelectionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? price,
      int? maxGuests,
      String? services,
      String? extraServices});
}

/// @nodoc
class __$$UserPackageSelectionModelImplCopyWithImpl<$Res>
    extends _$UserPackageSelectionModelCopyWithImpl<$Res,
        _$UserPackageSelectionModelImpl>
    implements _$$UserPackageSelectionModelImplCopyWith<$Res> {
  __$$UserPackageSelectionModelImplCopyWithImpl(
      _$UserPackageSelectionModelImpl _value,
      $Res Function(_$UserPackageSelectionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPackageSelectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? price = freezed,
    Object? maxGuests = freezed,
    Object? services = freezed,
    Object? extraServices = freezed,
  }) {
    return _then(_$UserPackageSelectionModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      maxGuests: freezed == maxGuests
          ? _value.maxGuests
          : maxGuests // ignore: cast_nullable_to_non_nullable
              as int?,
      services: freezed == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as String?,
      extraServices: freezed == extraServices
          ? _value.extraServices
          : extraServices // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPackageSelectionModelImpl implements _UserPackageSelectionModel {
  const _$UserPackageSelectionModelImpl(
      {this.id,
      this.name,
      this.price,
      this.maxGuests,
      this.services,
      this.extraServices});

  factory _$UserPackageSelectionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPackageSelectionModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? price;
  @override
  final int? maxGuests;
  @override
  final String? services;
  @override
  final String? extraServices;

  @override
  String toString() {
    return 'UserPackageSelectionModel(id: $id, name: $name, price: $price, maxGuests: $maxGuests, services: $services, extraServices: $extraServices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPackageSelectionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.maxGuests, maxGuests) ||
                other.maxGuests == maxGuests) &&
            (identical(other.services, services) ||
                other.services == services) &&
            (identical(other.extraServices, extraServices) ||
                other.extraServices == extraServices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, price, maxGuests, services, extraServices);

  /// Create a copy of UserPackageSelectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPackageSelectionModelImplCopyWith<_$UserPackageSelectionModelImpl>
      get copyWith => __$$UserPackageSelectionModelImplCopyWithImpl<
          _$UserPackageSelectionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPackageSelectionModelImplToJson(
      this,
    );
  }
}

abstract class _UserPackageSelectionModel implements UserPackageSelectionModel {
  const factory _UserPackageSelectionModel(
      {final int? id,
      final String? name,
      final String? price,
      final int? maxGuests,
      final String? services,
      final String? extraServices}) = _$UserPackageSelectionModelImpl;

  factory _UserPackageSelectionModel.fromJson(Map<String, dynamic> json) =
      _$UserPackageSelectionModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get price;
  @override
  int? get maxGuests;
  @override
  String? get services;
  @override
  String? get extraServices;

  /// Create a copy of UserPackageSelectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPackageSelectionModelImplCopyWith<_$UserPackageSelectionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
