import 'dart:convert';

List<DecorModel> decorModelFromJson(String str) => List<DecorModel>.from(json.decode(str).map((x) => DecorModel.fromJson(x)));

String decorModelToJson(List<DecorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DecorModel {
    int id;
    String name;
    String address;
    String email;
    String mobileNo;
    int yearInBusiness;
    String shopImage;
    int vendor;
    List<dynamic> workImages;

    DecorModel({
        int? id,
        String? name,
        String? address,
        String? email,
        String? mobileNo,
        int? yearInBusiness,
        String? shopImage,
        int? vendor,
        List<dynamic>? workImages,
    })  : id = id ?? 0,
         name = name ?? "Unknown",
         address = address ?? "No address provided",
         email = email ?? "No email provided",
         mobileNo = mobileNo ?? "No mobile number",
         yearInBusiness = yearInBusiness ?? 0,
         shopImage = shopImage ?? "default_image.png",
         vendor = vendor ?? 0,
         workImages = workImages ?? [];

    factory DecorModel.fromJson(Map<String, dynamic> json) => DecorModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "Unknown",
        address: json["address"] ?? "No address provided",
        email: json["email"] ?? "No email provided",
        mobileNo: json["mobile_no"] ?? "No mobile number",
        yearInBusiness: json["year_in_business"] ?? 0,
        shopImage: json["shop_image"] ?? "default_image.png",
        vendor: json["vendor"] ?? 0,
        workImages: json["work_images"] == null ? [] : List<dynamic>.from(json["work_images"].map((x) => x)),
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
        "work_images": workImages.isEmpty ? [] : List<dynamic>.from(workImages.map((x) => x)),
    };
}
