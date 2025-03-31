import 'dart:convert';

List<HomePackageModel> homePackageModelFromJson(String str) =>
    List<HomePackageModel>.from(
        json.decode(str).map((x) => HomePackageModel.fromJson(x)));

String homePackageModelToJson(List<HomePackageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomePackageModel {
  int id;
  String name;
  String image;

  HomePackageModel({
    this.id = 0,
    this.name = "Unknown",
    this.image = "default_image.png",
  });

  factory HomePackageModel.fromJson(Map<String, dynamic> json) => HomePackageModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "Unknown",
        image: json["image"] ?? "default_image.png",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
