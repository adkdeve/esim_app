import '../core.dart';

class ApisUrl {

  // Auth Section
  static const String login = '${AppConfig.baseUrl}login';
  static const String signUp = '${AppConfig.baseUrl}signup';

  // Products Section
  static const String getAllProducts = '${AppConfig.mayaBaseUrl}account/products';
  static const String getSingleProduct = '${AppConfig.mayaBaseUrl}product/';

  // Profile Section
  static const String updateProfile = '${AppConfig.baseUrl}update-profile';
  static const String contactUs = '${AppConfig.baseUrl}contact-us';
  static const String changePassword = '${AppConfig.baseUrl}change-password';


}
