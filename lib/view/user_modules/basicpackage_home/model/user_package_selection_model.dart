  // To parse this JSON data, do
//
//     final userPackageSelectionModel = userPackageSelectionModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_package_selection_model.freezed.dart';
part 'user_package_selection_model.g.dart';

List<UserPackageSelectionModel> userPackageSelectionModelFromJson(String str) => List<UserPackageSelectionModel>.from(json.decode(str).map((x) => UserPackageSelectionModel.fromJson(x)));

String userPackageSelectionModelToJson(List<UserPackageSelectionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class UserPackageSelectionModel with _$UserPackageSelectionModel {
    const factory UserPackageSelectionModel({
        int? id,
        String? name,
        String? price,
        int? maxGuests,
        String? services,
        String? extraServices,
    }) = _UserPackageSelectionModel;

    factory UserPackageSelectionModel.fromJson(Map<String, dynamic> json) => _$UserPackageSelectionModelFromJson(json);
}
