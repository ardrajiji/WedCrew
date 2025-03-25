class UserUrl {
  // Base URL for the API server  
  static const String baseUrl="https://6jclb41w-8001.inc1.devtunnels.ms";
  static const String userbaseUrl="$baseUrl/userapp";
  static const String vendorbaseUrl="$baseUrl/vendor";

  static const String user_register ="$userbaseUrl/users/";
  static const String user_login ="$userbaseUrl/login/";
  
  static const String homePackage ="$userbaseUrl/event-packages/";
  static const String packageDetails ="$userbaseUrl/packages/";
  static const String PackageBookingForm ="$userbaseUrl/bookings/";
  static const String package_upi ="$userbaseUrl/eventpayment/googlepay/";
  static const String package_card ="$userbaseUrl/eventpayment/card/";
  static const String PhotographyPage ="$userbaseUrl/photography/";




  static const String vendor_register ="$vendorbaseUrl/vendors/";
  static const String vendor_login ="$vendorbaseUrl/login/";
  static const String vendor_service_add ="$vendorbaseUrl/services/";
  static const String vendor_shop_register ="$vendorbaseUrl/vendor-shops/";
   static const String vendor_service_view ="$vendorbaseUrl/vendor-services/";
  static const String vendor_profile ="$vendorbaseUrl/profile/";
   static const String shopView ="$vendorbaseUrl/view-shop/";
   static const String shopImages ="$vendorbaseUrl/update-shop/";
  
}
