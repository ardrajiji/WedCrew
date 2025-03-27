// To parse this JSON data, do
//
//     final venueModel = venueModelFromJson(jsonString);

import 'dart:convert';

List<VenueModel> venueModelFromJson(String str) => 
    List<VenueModel>.from(json.decode(str).map((x) => VenueModel.fromJson(x)));

String venueModelToJson(List<VenueModel> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VenueModel {
  int? id;
  String? name;
  String? address;
  String? email;
  String? mobileNo;
  int? yearInBusiness;
  String? shopImage;
  int? vendor;
  List<String>? workImages;

  // Default values
  static const String defaultShopImage = "assets/image/img2.png";
  static const List<String> defaultWorkImages = [
    "assets/image/img5.png",
    "assets/image/img2.png",
    "assets/image/decor2.jpg"
  ];

  VenueModel({
    this.id,
    this.name,
    this.address,
    this.email,
    this.mobileNo,
    this.yearInBusiness,
    this.shopImage,
    this.vendor,
    this.workImages,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) => VenueModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "Unknown",
        address: json["address"] ?? "Not Available",
        email: json["email"] ?? "No Email",
        mobileNo: json["mobile_no"] ?? "No Mobile",
        yearInBusiness: json["year_in_business"] ?? 0,
        shopImage: (json["shop_image"] == null || json["shop_image"].isEmpty)
            ? defaultShopImage
            : json["shop_image"],
        vendor: json["vendor"] ?? 0,
        workImages: (json["work_images"] == null || (json["work_images"] as List).isEmpty)
            ? defaultWorkImages
            : List<String>.from(json["work_images"].map((x) => x ?? "")),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "name": name ?? "Unknown",
        "address": address ?? "Not Available",
        "email": email ?? "No Email",
        "mobile_no": mobileNo ?? "No Mobile",
        "year_in_business": yearInBusiness ?? 0,
        "shop_image": shopImage == null || shopImage!.isEmpty
            ? defaultShopImage
            : shopImage,
        "vendor": vendor ?? 0,
        "work_images": workImages == null || workImages!.isEmpty
            ? defaultWorkImages
            : List<dynamic>.from(workImages!.map((x) => x ?? "")),
      };
}
