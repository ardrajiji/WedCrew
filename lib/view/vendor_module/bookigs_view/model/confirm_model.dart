// To parse this JSON data, do
//
//     final confirmModel = confirmModelFromJson(jsonString);

import 'dart:convert';

ConfirmModel confirmModelFromJson(String str) => ConfirmModel.fromJson(json.decode(str));

String confirmModelToJson(ConfirmModel data) => json.encode(data.toJson());

class ConfirmModel {
    String? message;
    String? status;

    ConfirmModel({
        this.message,
        this.status,
    });

    factory ConfirmModel.fromJson(Map<String, dynamic> json) => ConfirmModel(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
