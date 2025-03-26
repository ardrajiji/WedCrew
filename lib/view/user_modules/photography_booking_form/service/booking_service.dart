import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/user_modules/photography_booking_form/model/service_booking.dart';

Future<ServiceBookModel> confirmBookingService({
  required List service_ids,
  required String advanced_price,
  required String time,
  required String date,
  required String address,
  required String vendor,
}) async {
  try {
   
    Map<String, dynamic> param = {
      "user": 13.toString(),
      "service_ids": service_ids, 
      "advanced_price":advanced_price,
      "time": time, 
      "date":date,
      "address":address,
      "vendor":vendor,
    };

    final resp = await http.post(
      Uri.parse(UserUrl.Photographybooking),
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (resp.statusCode == 201) {
      final dynamic decoded = jsonDecode(resp.body);
      final response = ServiceBookModel.fromJson(decoded);
      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(resp.body);
      throw Exception(
        '${errorResponse['message'] ?? 'Unknown error'}',
      );
    }
  } on SocketException {
    throw Exception('No Internet connection');
  } on HttpException {
    throw Exception('Server error');
  } on FormatException {
    throw Exception('Bad response format');
  } catch (e) {
    throw Exception('Unexpected error: ${e.toString()}');
  }
}
