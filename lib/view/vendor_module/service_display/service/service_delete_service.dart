import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/vendor_module/service_display/model/service_delete_model.dart';

Future<ServiceDeleteModel> serviceDeleteService({
  required String service_id,
  
}) async {
  try {
   
    Map<String, dynamic> param = {
     
      "service_id":service_id,
    };
     
   
    final resp = await http.delete(
      Uri.parse(UserUrl.vendor_service_view).replace(queryParameters: param),
      //body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    
    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);
      final response = ServiceDeleteModel.fromJson(decoded);
     
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
