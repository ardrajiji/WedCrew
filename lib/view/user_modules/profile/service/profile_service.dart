import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/user_modules/profile/model/profile.dart';

Future<UserProfileModel> userProfileService() async {
  try {
    
    //String userId = await PreferenceValues.getUserId();

    Map<String, dynamic> params = {
     // 'id': userId.toString(),
     'user_id': 13.toString(),
    };

    final resp = await http.get(
      Uri.parse(UserUrl.userProfile).replace(queryParameters: params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    //final List<dynamic> decoded = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);
      final response = UserProfileModel.fromJson(decoded);
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
