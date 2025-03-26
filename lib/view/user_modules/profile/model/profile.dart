// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    int? userId;
    String? name;
    String? email;
    String? phone;

    UserProfileModel({
        this.userId,
        this.name,
        this.email,
        this.phone,
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
    };
}
