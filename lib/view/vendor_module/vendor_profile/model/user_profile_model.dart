// To parse this JSON data, do
//
//     final vendorProfileModel = vendorProfileModelFromJson(jsonString);

import 'dart:convert';

VendorProfileModel vendorProfileModelFromJson(String str) => VendorProfileModel.fromJson(json.decode(str));

String vendorProfileModelToJson(VendorProfileModel data) => json.encode(data.toJson());

class VendorProfileModel {
    int? vendorId;
    String? name;
    String? email;
    String? mobileNo;
    String? category;
    String? status;
    List<Service>? services;

    VendorProfileModel({
        this.vendorId,
        this.name,
        this.email,
        this.mobileNo,
        this.category,
        this.status,
        this.services,
    });

    factory VendorProfileModel.fromJson(Map<String, dynamic> json) => VendorProfileModel(
        vendorId: json["vendor_id"],
        name: json["name"],
        email: json["email"],
        mobileNo: json["mobile_no"],
        category: json["category"],
        status: json["status"],
        services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "name": name,
        "email": email,
        "mobile_no": mobileNo,
        "category": category,
        "status": status,
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    };
}

class Service {
    int? id;
    String? serviceName;
    String? details;
    String? totalAmount;
    int? vendor;

    Service({
        this.id,
        this.serviceName,
        this.details,
        this.totalAmount,
        this.vendor,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
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
