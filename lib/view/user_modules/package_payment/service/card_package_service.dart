import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/user_modules/package_payment/model/card_package_model.dart';
import 'package:wed_crew/view/utils/preference_values.dart';


Future<CardPaymentModel> cardPayService({
  required String name,
  required String booking_id,
  required String card_number,
  required String expiry_date,
  required String cvv,
  required String amount,
}) async {
  try {
    String userId = await PreferenceValues.getUserId();
    Map<String, dynamic> param = {
      "booking": booking_id,
      "cardholder_name": name,
      "card_number": card_number,
      "expiry_date": expiry_date,
      "cvv_number": cvv,
      "user":userId,
      "amount_paid":amount,
       "payment_method" :"card",
    };

    final resp = await http.post(
      Uri.parse(UserUrl.package_card),
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (resp.statusCode == 201) {
      final dynamic decoded = jsonDecode(resp.body);
      final response = CardPaymentModel.fromJson(decoded);

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
