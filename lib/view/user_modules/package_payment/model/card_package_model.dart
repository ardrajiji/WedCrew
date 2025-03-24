// To parse this JSON data, do
//
//     final cardPaymentModel = cardPaymentModelFromJson(jsonString);

import 'dart:convert';

CardPaymentModel cardPaymentModelFromJson(String str) => CardPaymentModel.fromJson(json.decode(str));

String cardPaymentModelToJson(CardPaymentModel data) => json.encode(data.toJson());

class CardPaymentModel {
    String? message;
    String? status;
    int? paymentId;

    CardPaymentModel({
        this.message,
        this.status,
        this.paymentId,
    });

    factory CardPaymentModel.fromJson(Map<String, dynamic> json) => CardPaymentModel(
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
