import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/utils/preference_values.dart';
import 'package:wed_crew/view/vendor_module/vendor_shop_register/model/shop_register_model.dart';

Future<VendorShopRegister> shopRegistrationService({
  required String name,
  required String address,
  required String email,
  required String phone,
  required String yearInBusiness,
  required File shopImage,
}) async {
  try {
    // Create a multipart request
    var request = http.MultipartRequest("POST", Uri.parse(UserUrl.vendor_shop_register));

    // Get service centre ID
   String tempVendorId = await PreferenceValues.getTempVendorId();
    // Add text fields
    request.fields['name'] = name;
    request.fields['address'] = address;
    request.fields['email'] = email;
    request.fields['mobile_no'] = phone;
    request.fields['year_in_business'] = yearInBusiness;
    request.fields['vendor'] = tempVendorId;

    // Add the image file
    var imageStream = http.ByteStream(shopImage.openRead());
    var imageLength = await shopImage.length();
    var multiPartFile = http.MultipartFile(
      'image',
      imageStream,
      imageLength,
      filename: shopImage.path.split("/").last,
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
        'Failed to register : ${errorResponse['message'] ?? 'Unknown error'}',
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
