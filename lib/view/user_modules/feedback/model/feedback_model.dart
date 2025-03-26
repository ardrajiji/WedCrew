// To parse this JSON data, do
//
//     final feedbackModel = feedbackModelFromJson(jsonString);

import 'dart:convert';

FeedbackModel feedbackModelFromJson(String str) => FeedbackModel.fromJson(json.decode(str));

String feedbackModelToJson(FeedbackModel data) => json.encode(data.toJson());

class FeedbackModel {
    int? id;
    String? text;
    int? rating;
    DateTime? createdAt;
    int? user;

    FeedbackModel({
        this.id,
        this.text,
        this.rating,
        this.createdAt,
        this.user,
    });

    factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        id: json["id"],
        text: json["text"],
        rating: json["rating"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "rating": rating,
        "created_at": createdAt?.toIso8601String(),
        "user": user,
    };
}
