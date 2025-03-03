// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_package_selection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserPackageSelectionModelImpl _$$UserPackageSelectionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPackageSelectionModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: json['price'] as String?,
      maxGuests: (json['maxGuests'] as num?)?.toInt(),
      services: json['services'] as String?,
      extraServices: json['extraServices'] as String?,
    );

Map<String, dynamic> _$$UserPackageSelectionModelImplToJson(
        _$UserPackageSelectionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'maxGuests': instance.maxGuests,
      'services': instance.services,
      'extraServices': instance.extraServices,
    };
