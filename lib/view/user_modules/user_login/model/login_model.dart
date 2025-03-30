// To parse this JSON data, do
//
//     final userLoginModel = userLoginModelFromJson(jsonString);

import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
    String? message;
    int? userId;
    String? role;

    UserLoginModel({
        this.message,
        this.userId,
        this.role,
    });

    factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
        message: json["message"],
        userId: json["user_id"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user_id": userId,
        "role": role,
    };
}
