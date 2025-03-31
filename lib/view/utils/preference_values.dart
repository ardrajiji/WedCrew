
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wed_crew/view/utils/preference_keys.dart';

class PreferenceValues {


  static Future<void> disableUserIntroScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferenceKeys.isUserFirstLaunch, false);
  }

  static Future<bool> getUserIntroScreenStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isFirstLaunch = preferences.getBool(PreferenceKeys.isUserFirstLaunch);
    return isFirstLaunch ?? true;
  }

  
  static Future<void> disableVendorIntroScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferenceKeys.isVendorFirstLaunch, false);
  }

  static Future<bool> getVendorIntroScreenStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isFirstLaunch = preferences.getBool(PreferenceKeys.isVendorFirstLaunch);
    return isFirstLaunch ?? true;
  }

  static Future<void> userLogin({
    required String userId,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferenceKeys.isUserLoggedIn, true);
    await preferences.setString(PreferenceKeys.userId, userId);
  }

  static Future<void> userLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferenceKeys.isUserLoggedIn, false);
    await preferences.remove(PreferenceKeys.userId);
  }

  static Future<bool> getUserLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isLoggedIn = preferences.getBool(PreferenceKeys.isUserLoggedIn);
    return isLoggedIn ?? false;
  }
  
  
  static Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(PreferenceKeys.userId);
    return userId ?? "0";
  }
  


  static Future<void> vendorLogin({
    required String vendorId,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferenceKeys.isVendorLoggedIn, true);
    await preferences.setString(PreferenceKeys.vendorId, vendorId);
  }

   static Future<void> vendorLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferenceKeys.isVendorLoggedIn, false);
    await preferences.remove(PreferenceKeys.vendorId);
  }

  

  static Future<bool> getVendorLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isLoggedIn = preferences.getBool(PreferenceKeys.isVendorLoggedIn);
    return isLoggedIn ?? false;
  }


  static Future<String> getVendorId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? vendorId = preferences.getString(PreferenceKeys.vendorId);
    return vendorId ?? "0";
  }

   static Future<void> addShop({
    required String shopId,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(PreferenceKeys.shopId, shopId);
  }

  static Future<String> getShopId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? serviceCentreId = preferences.getString(PreferenceKeys.shopId);
    return serviceCentreId ?? "0";
  }

  static Future<void> tempVendorLogin({
    required String tempVendorId,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferenceKeys.isVendorLoggedIn, true);
    await preferences.setString(PreferenceKeys.tempVendorId, tempVendorId);
  }

 static Future<String> getTempVendorId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? tempVendorId = preferences.getString(PreferenceKeys.tempVendorId);
    return tempVendorId ?? "0";
  }
   static Future<void> tempVendorLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferenceKeys.isVendorLoggedIn, false);
    await preferences.remove(PreferenceKeys.vendorId);
  }

}
