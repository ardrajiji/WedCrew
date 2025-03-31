import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/utils/preference_values.dart';
import 'package:wed_crew/view/vendor_module/vendor_shop_register/model/shop_register_model.dart';

Future<VendorShopRegister> vendorAddService({
  required String service_name,
  required String details,
  required String amount, 
  required File image,
}) async {
  try {
    // Create a multipart request
    var request = http.MultipartRequest("POST", Uri.parse(UserUrl.vendor_service_add));

    // Get service centre ID
     String vendorId = await PreferenceValues.getVendorId();
    // Add text fields
    request.fields['service_name'] = service_name;
    request.fields['details'] = details;
    request.fields['total_amount'] = amount;
    request.fields['vendor'] = vendorId;
    

    // Add the image file
    var imageStream = http.ByteStream(image.openRead());
    var imageLength = await image.length();
    var multiPartFile = http.MultipartFile(
      'image',
      imageStream,
      imageLength,
      filename: image.path.split("/").last,
    );
    request.files.add(multiPartFile);

    // Send request
    final resp = await request.send();

    // Convert the response stream to a string
    final responseBody = await resp.stream.bytesToString();

    if (resp.statusCode == 201) {
      final dynamic decoded = jsonDecode(responseBody);
      final VendorShopRegister response =
          VendorShopRegister.fromJson(decoded);
      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(responseBody);
      throw Exception(
        'Failed to add products: ${errorResponse['message'] ?? 'Unknown error'}',
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
