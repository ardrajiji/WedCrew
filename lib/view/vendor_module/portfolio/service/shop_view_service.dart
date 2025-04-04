import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/utils/preference_values.dart';
import 'package:wed_crew/view/vendor_module/portfolio/model/shop_view_model.dart';


Future<PortfolioModel> shopViewService() async {
  try {
    //final user_id =int.parse("2");
   String vendorId = await PreferenceValues.getVendorId();

    Map<String, dynamic> params = {
      //'id': userId.toString(),
      'vendor_id' : vendorId,
    };

    final resp = await http.get(
      Uri.parse(UserUrl.shopView).replace(queryParameters: params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    //final List<dynamic> decoded = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);
      final response = PortfolioModel.fromJson(decoded);
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
