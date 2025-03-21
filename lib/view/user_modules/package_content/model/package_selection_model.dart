// To parse this JSON data, do
//
//     final packageSelectionModel = packageSelectionModelFromJson(jsonString);

import 'dart:convert';

PackageSelectionModel packageSelectionModelFromJson(String str) => PackageSelectionModel.fromJson(json.decode(str));

String packageSelectionModelToJson(PackageSelectionModel data) => json.encode(data.toJson());

class PackageSelectionModel {
    int? id;
    String? image;
    String? name;
    String? price;
    int? maxGuests;
    String? services;
    String? extraServices;

    PackageSelectionModel({
        this.id,
        this.image,
        this.name,
        this.price,
        this.maxGuests,
        this.services,
        this.extraServices,
    });

    factory PackageSelectionModel.fromJson(Map<String, dynamic> json) => PackageSelectionModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        maxGuests: json["max_guests"],
        services: json["services"],
        extraServices: json["extra_services"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "max_guests": maxGuests,
        "services": services,
        "extra_services": extraServices,
    };
}
