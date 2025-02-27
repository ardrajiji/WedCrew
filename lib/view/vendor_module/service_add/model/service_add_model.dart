// To parse this JSON data, do
//
//     final vendorServiceAddModel = vendorServiceAddModelFromJson(jsonString);

import 'dart:convert';

VendorServiceAddModel vendorServiceAddModelFromJson(String str) => VendorServiceAddModel.fromJson(json.decode(str));

String vendorServiceAddModelToJson(VendorServiceAddModel data) => json.encode(data.toJson());

class VendorServiceAddModel {
    String? message;
    String? status;

    VendorServiceAddModel({
        this.message,
        this.status,
    });

    factory VendorServiceAddModel.fromJson(Map<String, dynamic> json) => VendorServiceAddModel(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
