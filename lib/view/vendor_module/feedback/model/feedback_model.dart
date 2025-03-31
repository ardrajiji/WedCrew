// To parse this JSON data, do
//
//     final vendorFeedbackModel = vendorFeedbackModelFromJson(jsonString);

import 'dart:convert';

VendorFeedbackModel vendorFeedbackModelFromJson(String str) => VendorFeedbackModel.fromJson(json.decode(str));

String vendorFeedbackModelToJson(VendorFeedbackModel data) => json.encode(data.toJson());

class VendorFeedbackModel {
    String? status;
    int? id;
    String? text;
    int? rating;
    DateTime? createdAt;
    int? vendor;

    VendorFeedbackModel({
        this.status,
        this.id,
        this.text,
        this.rating,
        this.createdAt,
        this.vendor,
    });

    factory VendorFeedbackModel.fromJson(Map<String, dynamic> json) => VendorFeedbackModel(
        status: json["status"],
        id: json["id"],
        text: json["text"],
        rating: json["rating"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        vendor: json["vendor"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "text": text,
        "rating": rating,
        "created_at": createdAt?.toIso8601String(),
        "vendor": vendor,
    };
}
