// ignore_for_file: constant_identifier_names

class ApiConstant {
  static const String baseUrl = "http://192.168.43.13:9000";
  //run on real device php artisan serve --host 0.0.0.0 --port 9000

  // static const String baseUrl = "http://127.0.0.1:8000";

  //auth
  static const String authSignInUrl = "$baseUrl/api/v1/auth/login";
  static const String authSignUpUrl = "$baseUrl/api/v1/auth/register";

  //products
  static const String getPopularProducsUrl = "$baseUrl/api/v1/products/popular";
  static const String getRecommendedProducsUrl =
      "$baseUrl/api/v1/products/popular";
  static const String uploadsUrl = "$baseUrl/uploads/";

  //address
  static const String geocodeUrl = "$baseUrl/api/v1/config/geocode-api";
  static const String addUserAddressUrl = "$baseUrl/api/v1/address/add";
  static const String updateUserAddressUrl = "$baseUrl/api/v1/address/update/";
   static const String getUserAddressUrl = "$baseUrl/api/v1/customer/address/list";

//user info
  static const String userInfoUrl = "$baseUrl/api/v1/customer/info";
}

class SharedPreferencesKeys {
  static const String CART_ITEMS = "Cart-Items";
  static const String CART_HISTORY = "Cart-History";
  static const String USER_ADDRESS = "USER_ADDRESS";
  static const String APP_TOKEN = "token";
}
