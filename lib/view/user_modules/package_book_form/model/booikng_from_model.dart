// To parse this JSON data, do
//
//     final bookingFormModel = bookingFormModelFromJson(jsonString);

import 'dart:convert';

BookingFormModel bookingFormModelFromJson(String str) => BookingFormModel.fromJson(json.decode(str));

String bookingFormModelToJson(BookingFormModel data) => json.encode(data.toJson());

class BookingFormModel {
    String? message;
    int? id;
    Data? data;

    BookingFormModel({
        this.message,
        this.id,
        this.data,
    });

    factory BookingFormModel.fromJson(Map<String, dynamic> json) => BookingFormModel(
        message: json["message"],
        id: json["id"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? name;
    String? mobileNumber;
    String? email;
    String? location;
    DateTime? dateOfMarriage;
    int? numberOfParticipants;
    int? user;
    int? eventPackage;

    Data({
        this.id,
        this.name,
        this.mobileNumber,
        this.email,
        this.location,
        this.dateOfMarriage,
        this.numberOfParticipants,
        this.user,
        this.eventPackage,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        location: json["location"],
        dateOfMarriage: json["date_of_marriage"] == null ? null : DateTime.parse(json["date_of_marriage"]),
        numberOfParticipants: json["number_of_participants"],
        user: json["user"],
        eventPackage: json["event_package"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile_number": mobileNumber,
        "email": email,
        "location": location,
        "date_of_marriage": "${dateOfMarriage!.year.toString().padLeft(4, '0')}-${dateOfMarriage!.month.toString().padLeft(2, '0')}-${dateOfMarriage!.day.toString().padLeft(2, '0')}",
        "number_of_participants": numberOfParticipants,
        "user": user,
        "event_package": eventPackage,
    };
}
