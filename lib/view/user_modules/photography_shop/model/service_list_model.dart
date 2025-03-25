// To parse this JSON data, do
//
//     final serviceListModel = serviceListModelFromJson(jsonString);

import 'dart:convert';

List<ServiceListModel> serviceListModelFromJson(String str) => List<ServiceListModel>.from(json.decode(str).map((x) => ServiceListModel.fromJson(x)));

String serviceListModelToJson(List<ServiceListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceListModel {
    int? id;
    String? details;
    String? totalAmount;
    int? vendorId;

    ServiceListModel({
        this.id,
        this.details,
        this.totalAmount,
        this.vendorId,
    });

    factory ServiceListModel.fromJson(Map<String, dynamic> json) => ServiceListModel(
        id: json["id"],
        details: json["details"],
        totalAmount: json["total_amount"],
        vendorId: json["vendor_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "details": details,
        "total_amount": totalAmount,
        "vendor_id": vendorId,
    };
}
