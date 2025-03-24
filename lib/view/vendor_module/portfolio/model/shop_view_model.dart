// To parse this JSON data, do
//
//     final portfolioModel = portfolioModelFromJson(jsonString);

import 'dart:convert';

PortfolioModel portfolioModelFromJson(String str) => PortfolioModel.fromJson(json.decode(str));

String portfolioModelToJson(PortfolioModel data) => json.encode(data.toJson());

class PortfolioModel {
  int? id;
  String? name;
  String? address;
  String? email;
  String? mobileNo;
  int? yearInBusiness;
  String? shopImage;
  int? vendor;
  List<WorkImage>? workImages;

  PortfolioModel({
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

  factory PortfolioModel.fromJson(Map<String, dynamic> json) => PortfolioModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "No Name",
        address: json["address"] ?? "No Address",
        email: json["email"] ?? "No Email",
        mobileNo: json["mobile_no"] ?? "No Mobile",
        yearInBusiness: json["year_in_business"] ?? 0,
        shopImage: json["shop_image"] ?? "",
        vendor: json["vendor"] ?? 0,
        workImages: json["work_images"] == null
            ? []
            : List<WorkImage>.from(
                json["work_images"].map((x) => WorkImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "name": name ?? "No Name",
        "address": address ?? "No Address",
        "email": email ?? "No Email",
        "mobile_no": mobileNo ?? "No Mobile",
        "year_in_business": yearInBusiness ?? 0,
        "shop_image": shopImage ?? "",
        "vendor": vendor ?? 0,
        "work_images": workImages == null
            ? []
            : List<dynamic>.from(workImages!.map((x) => x.toJson())),
      };
}

class WorkImage {
  int? id;
  String? image;

  WorkImage({
    this.id,
    this.image,
  });

  factory WorkImage.fromJson(Map<String, dynamic> json) => WorkImage(
        id: json["id"] ?? 0,
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "image": image ?? "",
      };
}