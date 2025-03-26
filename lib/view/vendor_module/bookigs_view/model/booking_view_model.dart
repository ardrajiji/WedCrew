// To parse this JSON data, do
//
//     final viewBooknigModel = viewBooknigModelFromJson(jsonString);

import 'dart:convert';

List<ViewBooknigModel> viewBooknigModelFromJson(String str) => List<ViewBooknigModel>.from(json.decode(str).map((x) => ViewBooknigModel.fromJson(x)));

String viewBooknigModelToJson(List<ViewBooknigModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewBooknigModel {
    int? id;
    String? serviceName;
    String? advancedPrice;
    String? time;
    DateTime? date;
    String? address;
    String? status;

    ViewBooknigModel({
        this.id,
        this.serviceName,
        this.advancedPrice,
        this.time,
        this.date,
        this.address,
        this.status,
    });

    factory ViewBooknigModel.fromJson(Map<String, dynamic> json) => ViewBooknigModel(
        id: json["id"],
        serviceName: json["service_name"],
        advancedPrice: json["advanced_price"],
        time: json["time"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        address: json["address"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "advanced_price": advancedPrice,
        "time": time,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "address": address,
        "status": status,
    };
}
