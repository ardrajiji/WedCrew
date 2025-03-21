// To parse this JSON data, do
//
//     final vendorShopViewModel = vendorShopViewModelFromJson(jsonString);

import 'dart:convert';

List<VendorShopViewModel> vendorShopViewModelFromJson(String str) => List<VendorShopViewModel>.from(json.decode(str).map((x) => VendorShopViewModel.fromJson(x)));

String vendorShopViewModelToJson(List<VendorShopViewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VendorShopViewModel {
    int? id;
    String? name;
    String? address;
    String? email;
    String? mobileNo;
    String? image;
    int? yearInBusiness;
    int? vendor;

    VendorShopViewModel({
        this.id,
        this.name,
        this.address,
        this.email,
        this.mobileNo,
        this.image,
        this.yearInBusiness,
        this.vendor,
    });

    factory VendorShopViewModel.fromJson(Map<String, dynamic> json) => VendorShopViewModel(
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
