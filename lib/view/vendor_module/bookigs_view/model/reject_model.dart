// To parse this JSON data, do
//
//     final rejectModel = rejectModelFromJson(jsonString);

import 'dart:convert';

RejectModel rejectModelFromJson(String str) => RejectModel.fromJson(json.decode(str));

String rejectModelToJson(RejectModel data) => json.encode(data.toJson());

class RejectModel {
    String? message;
    String? status;

    RejectModel({
        this.message,
        this.status,
    });

    factory RejectModel.fromJson(Map<String, dynamic> json) => RejectModel(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
