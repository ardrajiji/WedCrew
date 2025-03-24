// To parse this JSON data, do
//
//     final responseStatusModel = responseStatusModelFromJson(jsonString);

import 'dart:convert';

ShopAddModel responseStatusModelFromJson(String str) => ShopAddModel.fromJson(json.decode(str));

String responseStatusModelToJson(ShopAddModel data) => json.encode(data.toJson());

class ShopAddModel {
    String? status;
    String? message;

    ShopAddModel({
        this.status,
        this.message,
    });

    factory ShopAddModel.fromJson(Map<String, dynamic> json) => ShopAddModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
