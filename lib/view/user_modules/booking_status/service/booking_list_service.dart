import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/user_modules/booking_status/model/booking_list_model.dart';
import 'package:wed_crew/view/utils/preference_values.dart';

Future<List<BookingListModel>> servicehistoryList() async {
  try {
    String userId = await PreferenceValues.getUserId();
    Map<String, dynamic> params = {
      'user_id': userId,
    };
    final resp = await http.get(
      Uri.parse(UserUrl.bookingHistory).replace(queryParameters: params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    final List<dynamic> decoded = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
      final response =
          decoded.map((item) => BookingListModel.fromJson(item)).toList();
      response.sort((a, b) => b.date!.compareTo(a.date!));
      return response;
    } else {
      throw Exception('Failed to load response');
    }
  } on SocketException {
    throw Exception('Server error');
  } on HttpException {
    throw Exception('Something went wrong');
  } on FormatException {
    throw Exception('Bad request');
  } catch (e) {
    throw Exception(e.toString());
  }
}
