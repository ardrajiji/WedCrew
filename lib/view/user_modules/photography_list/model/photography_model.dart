import 'dart:convert';

List<PhotographyModel> photographyModelFromJson(String str) => List<PhotographyModel>.from(
    json.decode(str).map((x) => PhotographyModel.fromJson(x)));

String photographyModelToJson(List<PhotographyModel> data) => json.encode(
    List<dynamic>.from(data.map((x) => x.toJson())));

class PhotographyModel {
  int id;
  String name;
  String address;
  String email;
  String mobileNo;
  int yearInBusiness;
  String shopImage;
  int vendor;
  List<WorkImage> workImages;

  PhotographyModel({
    this.id = 0,
    this.name = "Unknown",
    this.address = "Unknown",
    this.email = "Not provided",
    this.mobileNo = "Not provided",
    this.yearInBusiness = 0,
    this.shopImage = "assets/image/photographer2.jpg",
    this.vendor = 0,
    List<WorkImage>? workImages,
  }) : workImages = workImages ?? [];

  factory PhotographyModel.fromJson(Map<String, dynamic> json) => PhotographyModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "Unknown",
        address: json["address"] ?? "Unknown",
        email: json["email"] ?? "Not provided",
        mobileNo: json["mobile_no"] ?? "Not provided",
        yearInBusiness: json["year_in_business"] ?? 0,
        shopImage: json["shop_image"] ?? "assets/image/photographer2.jpg",
        vendor: json["vendor"] ?? 0,
        workImages: json["work_images"] == null
            ? []
            : List<WorkImage>.from(json["work_images"]!.map((x) => WorkImage.fromJson(x))),
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
    this.id = 0,
    this.image = "assets/image/photographer2.jpg",
  });

  factory WorkImage.fromJson(Map<String, dynamic> json) => WorkImage(
        id: json["id"] ?? 0,
        image: json["image"] ?? "assets/image/photographer2.jpg",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
