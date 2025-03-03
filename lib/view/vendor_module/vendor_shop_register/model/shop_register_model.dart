// To parse this JSON data, do
//
//     final vendorShopRegister = vendorShopRegisterFromJson(jsonString);

import 'dart:convert';

VendorShopRegister vendorShopRegisterFromJson(String str) => VendorShopRegister.fromJson(json.decode(str));

String vendorShopRegisterToJson(VendorShopRegister data) => json.encode(data.toJson());

class VendorShopRegister {
    String? message;
    String? status;
    Data? data;

    VendorShopRegister({
        this.message,
        this.status,
        this.data,
    });

    factory VendorShopRegister.fromJson(Map<String, dynamic> json) => VendorShopRegister(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? name;
    String? address;
    String? email;
    String? mobileNo;
    String? image;
    int? yearInBusiness;
    int? vendor;

    Data({
        this.id,
        this.name,
        this.address,
        this.email,
        this.mobileNo,
        this.image,
        this.yearInBusiness,
        this.vendor,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        email: json["email"],
        mobileNo: json["mobile_no"],
        image: json["image"],
        yearInBusiness: json["year_in_business"],
        vendor: json["vendor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "email": email,
        "mobile_no": mobileNo,
        "image": image,
        "year_in_business": yearInBusiness,
        "vendor": vendor,
    };
}
