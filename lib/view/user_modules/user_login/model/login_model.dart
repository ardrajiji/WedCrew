// To parse this JSON data, do
//
//     final userLoginModel = userLoginModelFromJson(jsonString);

import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
    String? status;
    String? message;
    String? role;

    UserLoginModel({
        this.status,
        this.message,
        this.role,
    });

    factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
        status: json["status"],
        message: json["message"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "role": role,
    };
}
