import 'dart:convert';

List<DecorModel> decorModelFromJson(String str) =>
    List<DecorModel>.from(json.decode(str).map((x) => DecorModel.fromJson(x)));

String decorModelToJson(List<DecorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DecorModel {
  int id;
  String name;
  String address;
  String email;
  String mobileNo;
  int yearInBusiness;
  String shopImage;
  int vendor;
  List<WorkImage> workImages; // Ensuring workImages is of type List<WorkImage>

  DecorModel({
    this.id = 0,
    this.name = "Unknown",
    this.address = "No address provided",
    this.email = "No email provided",
    this.mobileNo = "No mobile number",
    this.yearInBusiness = 0,
    this.shopImage = "default_image.png",
    this.vendor = 0,
    List<WorkImage>? workImages, // Updated to List<WorkImage>
  }) : workImages = workImages ?? [];

  factory DecorModel.fromJson(Map<String, dynamic> json) => DecorModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "Unknown",
        address: json["address"] ?? "No address provided",
        email: json["email"] ?? "No email provided",
        mobileNo: json["mobile_no"] ?? "No mobile number",
        yearInBusiness: json["year_in_business"] ?? 0,
        shopImage: json["shop_image"] ?? "default_image.png",
        vendor: json["vendor"] ?? 0,
        workImages: (json["work_images"] as List<dynamic>?)
                ?.map((x) => WorkImage.fromJson(x))
                .toList() ??
            [], // Explicitly converting to List<WorkImage>
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
        "work_images": workImages.map((x) => x.toJson()).toList(),
      };
}

// WorkImage model (same as in PhotographyModel)
class WorkImage {
  int id;
  String image;

  WorkImage({
    this.id = 0,
    this.image = "default_image.png",
  });

  factory WorkImage.fromJson(Map<String, dynamic> json) => WorkImage(
        id: json["id"] ?? 0,
        image: json["image"] ?? "default_image.png",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
