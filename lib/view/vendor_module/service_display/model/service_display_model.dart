// To parse this JSON data, do
//
//     final vendorserviceDisplayModel = vendorserviceDisplayModelFromJson(jsonString);

import 'dart:convert';

List<VendorserviceDisplayModel> vendorserviceDisplayModelFromJson(String str) => List<VendorserviceDisplayModel>.from(json.decode(str).map((x) => VendorserviceDisplayModel.fromJson(x)));

String vendorserviceDisplayModelToJson(List<VendorserviceDisplayModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VendorserviceDisplayModel {
    int? id;
    String? serviceName;
    String? details;
    String? totalAmount;
    int? vendor;

    VendorserviceDisplayModel({
        this.id,
        this.serviceName,
        this.details,
        this.totalAmount,
        this.vendor,
    });

    factory VendorserviceDisplayModel.fromJson(Map<String, dynamic> json) => VendorserviceDisplayModel(
        id: json["id"],
        serviceName: json["service_name"],
        details: json["details"],
        totalAmount: json["total_amount"],
        vendor: json["vendor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "details": details,
        "total_amount": totalAmount,
        "vendor": vendor,
    };
}
