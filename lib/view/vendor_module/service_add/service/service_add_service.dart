import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/vendor_module/service_add/model/service_add_model.dart';

Future<VendorServiceAddModel> vendorAddService({
  required String service_name,
  required String details,
  required String amount,
 
}) async {
  try {
    Map<String, dynamic> param = {
      "service_name": service_name,
      "details": details,
      "total_amount": amount,
      "vendor" : 8,
      
    };

    final response = await http.post(
      Uri.parse(UserUrl.vendor_service_add),
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
  final dynamic decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
    
      final response = VendorServiceAddModel.fromJson(decoded);

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
