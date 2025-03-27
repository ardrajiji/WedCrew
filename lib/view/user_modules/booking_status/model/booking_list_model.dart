import 'dart:convert';

List<BookingListModel> bookingListModelFromJson(String str) =>
    List<BookingListModel>.from(
        json.decode(str).map((x) => BookingListModel.fromJson(x)));

String bookingListModelToJson(List<BookingListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingListModel {
  int? id;
  String? serviceName;
  String? advancedPrice;
  String? time;
  DateTime? date;
  String? address;
  Status? status;

  BookingListModel({
    this.id,
    this.serviceName,
    this.advancedPrice,
    this.time,
    this.date,
    this.address,
    this.status,
  });

  factory BookingListModel.fromJson(Map<String, dynamic> json) =>
      BookingListModel(
        id: json["id"],
        serviceName: json["service_name"],
        advancedPrice: json["advanced_price"],
        time: json["time"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        address: json["address"],
        status: json["status"] == null ? null : statusValues.map[json["status"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName ?? "Unknown Service",
        "advanced_price": advancedPrice ?? "0.00",
        "time": time ?? "00:00:00",
        "date": date != null
            ? "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}"
            : "0000-00-00",
        "address": address ?? "No Address Provided",
        "status": status != null ? statusValues.reverse[status] : "unknown",
      };
}

/// ✅ **Fixed: Added more status options**
enum Status { BOOKED, CONFIRMED, REJECTED }

/// ✅ **Updated status mapping**
final statusValues = EnumValues({
  "booked": Status.BOOKED,
  "confirm": Status.CONFIRMED,
  "rejected": Status.REJECTED,
  
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
