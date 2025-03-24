import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/vendor_module/vendor_register/model/sign_up_model.dart';


Future<VedorRegistrationModel> vendorRegistrationService({
  required String name,
  required String email,
  required String password,
  required String phone,
  required String category,
 
}) async {
  try {
    Map<String, dynamic> param = {
      "name": name,
      "email": email,
      "password": password,
      "mobile_no": phone,
      "category": category,
    };

    final response = await http.post(
      Uri.parse(UserUrl.vendor_register),
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
  final dynamic decoded = jsonDecode(response.body);
    if (response.statusCode == 201) {
    
      final response = VedorRegistrationModel.fromJson(decoded);

      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      throw Exception(
        'Failed to register: ${errorResponse['message'] ?? 'Unknown error'}',
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
