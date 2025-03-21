// To parse this JSON data, do
//
//     final homePackageModel = homePackageModelFromJson(jsonString);

import 'dart:convert';

List<HomePackageModel> homePackageModelFromJson(String str) => List<HomePackageModel>.from(json.decode(str).map((x) => HomePackageModel.fromJson(x)));

String homePackageModelToJson(List<HomePackageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomePackageModel {
    int? id;
    String? name;
    String? image;

    HomePackageModel({
        this.id,
        this.name,
        this.image,
    });

    factory HomePackageModel.fromJson(Map<String, dynamic> json) => HomePackageModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
    };
}
