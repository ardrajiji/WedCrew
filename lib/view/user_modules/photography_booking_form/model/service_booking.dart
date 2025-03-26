// To parse this JSON data, do
//
//     final serviceBookModel = serviceBookModelFromJson(jsonString);

import 'dart:convert';

ServiceBookModel serviceBookModelFromJson(String str) =>
    ServiceBookModel.fromJson(json.decode(str));

String serviceBookModelToJson(ServiceBookModel data) =>
    json.encode(data.toJson());

class ServiceBookModel {
  String? status;
  String? message;
  List<Booking>? bookings;

  ServiceBookModel({
    this.status,
    this.message,
    this.bookings,
  });

  factory ServiceBookModel.fromJson(Map<String, dynamic> json) =>
      ServiceBookModel(
        status: json["status"],
        message: json["message"],
        bookings: json["bookings"] == null
            ? []
            : List<Booking>.from(
                json["bookings"]!.map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "bookings": bookings == null
            ? []
            : List<dynamic>.from(bookings!.map((x) => x.toJson())),
      };
}

class Booking {
  int? id;
  int? user;
  int? service;
  String? advancedPrice;
  String? time;
  DateTime? date;
  String? address;
  int? vendor;

  Booking({
    this.id,
    this.user,
    this.service,
    this.advancedPrice,
    this.time,
    this.date,
    this.address,
    this.vendor,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"] is int
            ? json["id"]
            : int.tryParse(json["id"].toString()),
        user: json["user"] is int
            ? json["user"]
            : int.tryParse(json["user"].toString()),
        service: json["service"] is int
            ? json["service"]
            : int.tryParse(json["service"].toString()),
        advancedPrice: json["advanced_price"],
        time: json["time"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        address: json["address"],
        vendor: json["vendor"] is int
            ? json["vendor"]
            : int.tryParse(json["vendor"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "service": service,
        "advanced_price": advancedPrice,
        "time": time,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "address": address,
        "vendor": vendor,
      };
}
