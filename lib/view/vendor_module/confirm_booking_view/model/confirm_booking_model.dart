// To parse this JSON data, do
//
//     final confirmBookingModel = confirmBookingModelFromJson(jsonString);

import 'dart:convert';

List<ConfirmBookingModel> confirmBookingModelFromJson(String str) => List<ConfirmBookingModel>.from(json.decode(str).map((x) => ConfirmBookingModel.fromJson(x)));

String confirmBookingModelToJson(List<ConfirmBookingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConfirmBookingModel {
    int? id;
    int? vendor;
    String? serviceName;
    String? advancedPrice;
    String? time;
    DateTime? date;
    String? address;
    String? status;

    ConfirmBookingModel({
        this.id,
        this.vendor,
        this.serviceName,
        this.advancedPrice,
        this.time,
        this.date,
        this.address,
        this.status,
    });

    factory ConfirmBookingModel.fromJson(Map<String, dynamic> json) => ConfirmBookingModel(
        id: json["id"],
        vendor: json["vendor"],
        serviceName: json["service_name"],
        advancedPrice: json["advanced_price"],
        time: json["time"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        address: json["address"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "vendor": vendor,
        "service_name": serviceName,
        "advanced_price": advancedPrice,
        "time": time,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "address": address,
        "status": status,
    };
}
