// To parse this JSON data, do
//
//     final serviceDeleteModel = serviceDeleteModelFromJson(jsonString);

import 'dart:convert';

ServiceDeleteModel serviceDeleteModelFromJson(String str) => ServiceDeleteModel.fromJson(json.decode(str));

String serviceDeleteModelToJson(ServiceDeleteModel data) => json.encode(data.toJson());

class ServiceDeleteModel {
    String? message;

    ServiceDeleteModel({
        this.message,
    });

    factory ServiceDeleteModel.fromJson(Map<String, dynamic> json) => ServiceDeleteModel(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
