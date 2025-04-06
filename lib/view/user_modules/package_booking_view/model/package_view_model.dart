// To parse this JSON data, do
//
//     final packageBookingView = packageBookingViewFromJson(jsonString);

import 'dart:convert';

List<PackageBookingView> packageBookingViewFromJson(String str) => List<PackageBookingView>.from(json.decode(str).map((x) => PackageBookingView.fromJson(x)));

String packageBookingViewToJson(List<PackageBookingView> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PackageBookingView {
    int? id;
    String? name;
    String? mobileNumber;
    String? email;
    String? location;
    DateTime? dateOfMarriage;
    int? numberOfParticipants;
    String? eventPackageName;

    PackageBookingView({
        this.id,
        this.name,
        this.mobileNumber,
        this.email,
        this.location,
        this.dateOfMarriage,
        this.numberOfParticipants,
        this.eventPackageName,
    });

    factory PackageBookingView.fromJson(Map<String, dynamic> json) => PackageBookingView(
        id: json["id"],
        name: json["name"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        location: json["location"],
        dateOfMarriage: json["date_of_marriage"] == null ? null : DateTime.parse(json["date_of_marriage"]),
        numberOfParticipants: json["number_of_participants"],
        eventPackageName: json["event_package_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile_number": mobileNumber,
        "email": email,
        "location": location,
        "date_of_marriage": "${dateOfMarriage!.year.toString().padLeft(4, '0')}-${dateOfMarriage!.month.toString().padLeft(2, '0')}-${dateOfMarriage!.day.toString().padLeft(2, '0')}",
        "number_of_participants": numberOfParticipants,
        "event_package_name": eventPackageName,
    };
}
