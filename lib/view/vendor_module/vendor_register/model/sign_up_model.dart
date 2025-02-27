// To parse this JSON data, do
//
//     final vedorRegistrationModel = vedorRegistrationModelFromJson(jsonString);

import 'dart:convert';

VedorRegistrationModel vedorRegistrationModelFromJson(String str) => VedorRegistrationModel.fromJson(json.decode(str));

String vedorRegistrationModelToJson(VedorRegistrationModel data) => json.encode(data.toJson());

class VedorRegistrationModel {
    String? status;
    String? message;
    int? vendorId;

    VedorRegistrationModel({
        this.status,
        this.message,
        this.vendorId,
    });

    factory VedorRegistrationModel.fromJson(Map<String, dynamic> json) => VedorRegistrationModel(
        status: json["status"],
        message: json["message"],
        vendorId: json["vendor_id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "vendor_id": vendorId,
    };
}
