import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/user_modules/package_payment/model/upi_package_model.dart';


Future<UpiPaymentModel> gpayService({
  required String upi_id,
  required String booking_id,
  required String amount,
}) async {
  try {
    //String userId = await PreferenceValues.getUserId();
    Map<String, dynamic> param = {
      "upi_id": upi_id,
      "booking": booking_id,
      "user":13.toString(),
      "amount_paid":amount,
      "payment_method":"googlepay",
    };

    final resp = await http.post(
      Uri.parse(UserUrl.package_upi),
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (resp.statusCode == 201) {
      final dynamic decoded = jsonDecode(resp.body);
      final response = UpiPaymentModel.fromJson(decoded);

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
