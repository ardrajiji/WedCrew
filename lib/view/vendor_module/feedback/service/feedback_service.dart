import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/utils/preference_values.dart';
import 'package:wed_crew/view/vendor_module/feedback/model/feedback_model.dart';

Future<VendorFeedbackModel> vendorFeedbackService({
  required String rating,
  required String feedback,
  
}) async {
  try {

     String vendorId = await PreferenceValues.getVendorId();
    Map<String, dynamic> param = {
      "vendor": vendorId,
      "rating": rating,
      "review_text" :feedback,
      
    };

    final resp = await http.post(
      Uri.parse(UserUrl.feedbackvendor), 
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (resp.statusCode == 201) {
      /**
       *  final List<dynamic> decoded = jsonDecode(resp.body);
      final response =
          decoded.map((item) => ProductModel.fromJson(item)).toList();
      return response;
       */

      final dynamic decoded = jsonDecode(resp.body);
      final response = VendorFeedbackModel.fromJson(decoded);
          
      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(resp.body);
      throw Exception(
        'Failed to login: ${errorResponse['message'] ?? 'Unknown error'}',
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