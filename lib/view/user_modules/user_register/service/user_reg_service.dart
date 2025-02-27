import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/user_modules/user_register/model/user_reg_model.dart';

Future<UserRegistrationModel> UserRegistrationService({
  required String name,
  required String email,
  required String password,
  required String phone,
}) async {
  try {
    Map<String, dynamic> param = {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    };

    final response = await http.post(
      Uri.parse(UserUrl.user_register),
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
  final dynamic decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
    
      final response = UserRegistrationModel.fromJson(decoded);

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
