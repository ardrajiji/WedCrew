class UserUrl {
  // Base URL for the API server  
  static const String baseUrl="https://nkdz72g4-8001.inc1.devtunnels.ms";
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
  static const String Photographyservice ="$userbaseUrl/servicesdetails/";
  static const String Photographybooking ="$userbaseUrl/servicebookings/";
  static const String bookingHistory ="$userbaseUrl/user_service_bookings/";

  static const String userProfile ="$userbaseUrl/user/profile/";
   static const String feedback ="$userbaseUrl/user-feedbacks/";


  static const String vendor_register ="$vendorbaseUrl/vendors/";
  static const String vendor_login ="$vendorbaseUrl/login/";
  static const String vendor_service_add ="$vendorbaseUrl/services/";
  static const String vendor_shop_register ="$vendorbaseUrl/vendor-shops/";
  static const String vendor_service_view ="$vendorbaseUrl/vendor-services/";
  static const String vendor_profile ="$vendorbaseUrl/profile/";
  static const String shopView ="$vendorbaseUrl/view-shop/";
  static const String shopImages ="$vendorbaseUrl/update-shop/";

  static const String viewbookings ="$vendorbaseUrl/vendor_service_bookings/";
  static const String  confirm="$vendorbaseUrl/booking/confirm/";
  static const String  reject="$vendorbaseUrl/booking/reject/";
  
  
  
}
