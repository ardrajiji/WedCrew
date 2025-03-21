import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/user_modules/package_book_form/model/booikng_from_model.dart';



Future<BookingFormModel>userRegistrationService({
  required String name,
  required String email,
  required String location,
  required String date_of_marriage,
  required String number_of_participants,
  required String mobile_number,
  required String phone,
  required String package_id,
  
 
}) async {
  try {
    Map<String, dynamic> param = {
      "name": name,
      "email": email,
      "location": location,
      "date_of_marriage":date_of_marriage,
      "number_of_participants":number_of_participants,
      "mobile_number":mobile_number,
      "event_package":package_id,
      "user_id" : 7.toString,
      
    };

    final response = await http.post(
      Uri.parse(UserUrl.PackageBookingForm),
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
  final dynamic decoded = jsonDecode(response.body);
    if (response.statusCode == 201) {
    
      final response = BookingFormModel.fromJson(decoded);

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
