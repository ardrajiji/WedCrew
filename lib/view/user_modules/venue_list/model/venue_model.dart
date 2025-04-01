// To parse this JSON data, do
//
//     final venueModel = venueModelFromJson(jsonString);

import 'dart:convert';

List<VenueModel> venueModelFromJson(String str) => 
    List<VenueModel>.from(json.decode(str).map((x) => VenueModel.fromJson(x)));

String venueModelToJson(List<VenueModel> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VenueModel {
  int id;
  String name;
  String address;
  String email;
  String mobileNo;
  int yearInBusiness;
  String shopImage;
  int vendor;
  List<WorkImage> workImages;

  VenueModel({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.mobileNo,
    required this.yearInBusiness,
    required this.shopImage,
    required this.vendor,
    required this.workImages,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) => VenueModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "No Name",
        address: json["address"] ?? "No Address",
        email: json["email"] ?? "No Email",
        mobileNo: json["mobile_no"] ?? "No Mobile",
        yearInBusiness: json["year_in_business"] ?? 0,
        shopImage: json["shop_image"] ?? "",
        vendor: json["vendor"] ?? 0,
        workImages: (json["work_images"] != null && json["work_images"] is List)
            ? List<WorkImage>.from(json["work_images"].map((x) => WorkImage.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "email": email,
        "mobile_no": mobileNo,
        "year_in_business": yearInBusiness,
        "shop_image": shopImage,
        "vendor": vendor,
        "work_images": List<dynamic>.from(workImages.map((x) => x.toJson())),
      };
}

class WorkImage {
  int id;
  String image;

  WorkImage({
    required this.id,
    required this.image,
  });

  factory WorkImage.fromJson(Map<String, dynamic> json) => WorkImage(
        id: json["id"] ?? 0,
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
