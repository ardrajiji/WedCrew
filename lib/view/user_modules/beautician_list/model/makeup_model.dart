import 'dart:convert';

List<MakeupModel> makeupModelFromJson(String str) => List<MakeupModel>.from(json.decode(str).map((x) => MakeupModel.fromJson(x)));

String makeupModelToJson(List<MakeupModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MakeupModel {
    int? id;
    String? name;
    String? address;
    String? email;
    String? mobileNo;
    int? yearInBusiness;
    String shopImage;
    int? vendor;
    List<dynamic> workImages;

    MakeupModel({
        this.id,
        this.name,
        this.address,
        this.email,
        this.mobileNo,
        this.yearInBusiness,
        String? shopImage,
        this.vendor,
        List<dynamic>? workImages,
    })  : shopImage = shopImage ?? "default_image.png",
         workImages = workImages ?? [];

    factory MakeupModel.fromJson(Map<String, dynamic> json) => MakeupModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        email: json["email"],
        mobileNo: json["mobile_no"],
        yearInBusiness: json["year_in_business"],
        shopImage: json["shop_image"] ?? "default_image.png",
        vendor: json["vendor"],
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
