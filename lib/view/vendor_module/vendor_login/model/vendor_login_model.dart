// To parse this JSON data, do
//
//     final vendorLoginModel = vendorLoginModelFromJson(jsonString);

import 'dart:convert';

VendorLoginModel vendorLoginModelFromJson(String str) => VendorLoginModel.fromJson(json.decode(str));

String vendorLoginModelToJson(VendorLoginModel data) => json.encode(data.toJson());

class VendorLoginModel {
    String? message;
    int? vendorId;
    String? role;

    VendorLoginModel({
        this.message,
        this.vendorId,
        this.role,
    });

    factory VendorLoginModel.fromJson(Map<String, dynamic> json) => VendorLoginModel(
        message: json["message"],
        vendorId: json["vendor_id"],
        role: json["Role"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "vendor_id": vendorId,
        "Role": role,
    };
}
