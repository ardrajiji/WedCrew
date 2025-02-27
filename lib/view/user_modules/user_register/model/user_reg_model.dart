// To parse this JSON data, do
//
//     final userRegistration = userRegistrationFromJson(jsonString);

import 'dart:convert';

UserRegistrationModel userRegistrationFromJson(String str) => UserRegistrationModel.fromJson(json.decode(str));

String userRegistrationToJson(UserRegistrationModel data) => json.encode(data.toJson());

class UserRegistrationModel {
    String? status;
    String? message;

    UserRegistrationModel({
        this.status,
        this.message,
    });

    factory UserRegistrationModel.fromJson(Map<String, dynamic> json) => UserRegistrationModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
