import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';

import 'package:wed_crew/view/vendor_module/portfolio/model/shop_add_model.dart';

Future<ShopAddModel> addImages({
  required List<File> productImages,
  required String shopId,
}) async {
  try {
    //String vendorId = await PreferenceValues.getVendorId();
    var request = http.MultipartRequest("PUT", Uri.parse(UserUrl.shopImages));
    request.fields['shop'] = shopId;
   // print("API URL: ${UserUrl.shopImages}");

    for (var image in productImages) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'work_images', // No `[]`
          image.path,
        ),
      );
    }

    final resp = await request.send();
    final responseBody = await resp.stream.bytesToString();

    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(responseBody); 
      return ShopAddModel.fromJson(decoded);
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(responseBody);
      throw Exception(
        'Failed to add product: ${errorResponse['message'] ?? 'Unknown error'}',
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