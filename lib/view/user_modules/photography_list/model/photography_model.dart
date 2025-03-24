// To parse this JSON data, do
//
//     final photographyModel = photographyModelFromJson(jsonString);

import 'dart:convert';

List<PhotographyModel> photographyModelFromJson(String str) => List<PhotographyModel>.from(json.decode(str).map((x) => PhotographyModel.fromJson(x)));

String photographyModelToJson(List<PhotographyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhotographyModel {
    int? id;
    String? name;
    String? address;
    String? email;
    String? mobileNo;
    int? yearInBusiness;
    dynamic shopImage;
    int? vendor;
    List<WorkImage>? workImages;

    PhotographyModel({
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

    factory PhotographyModel.fromJson(Map<String, dynamic> json) => PhotographyModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        email: json["email"],
        mobileNo: json["mobile_no"],
        yearInBusiness: json["year_in_business"],
        shopImage: json["shop_image"],
        vendor: json["vendor"],
        workImages: json["work_images"] == null ? [] : List<WorkImage>.from(json["work_images"]!.map((x) => WorkImage.fromJson(x))),
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
        "work_images": workImages == null ? [] : List<dynamic>.from(workImages!.map((x) => x.toJson())),
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
        id: json["id"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
    };
}
