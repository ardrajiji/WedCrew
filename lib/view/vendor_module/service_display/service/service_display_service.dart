import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/vendor_module/service_display/model/service_display_model.dart';

Future<List<VendorserviceDisplayModel>> serviceCenterDisplay() async {
  try {
    Map<String, dynamic> params = {
      'vendor_id': 3.toString(),
    };
    final resp = await http.get(
      Uri.parse(UserUrl.vendor_service_view).replace(queryParameters: params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    final List<dynamic> decoded = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
      final response = decoded
          .map((item) => VendorserviceDisplayModel.fromJson(item))
          .toList();
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
