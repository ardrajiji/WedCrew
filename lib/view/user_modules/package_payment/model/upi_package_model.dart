// To parse this JSON data, do
//
//     final upiPaymentModel = upiPaymentModelFromJson(jsonString);

import 'dart:convert';

UpiPaymentModel upiPaymentModelFromJson(String str) => UpiPaymentModel.fromJson(json.decode(str));

String upiPaymentModelToJson(UpiPaymentModel data) => json.encode(data.toJson());

class UpiPaymentModel {
    String? message;
    String? status;
    int? paymentId;

    UpiPaymentModel({
        this.message,
        this.status,
        this.paymentId,
    });

    factory UpiPaymentModel.fromJson(Map<String, dynamic> json) => UpiPaymentModel(
        message: json["message"],
        status: json["status"],
        paymentId: json["payment_id"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "payment_id": paymentId,
    };
}
