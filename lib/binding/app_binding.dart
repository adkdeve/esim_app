import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/data/repositories/repository.dart';
import 'package:pcom_app/app/data/services/auth_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<Repository>(Repository(), permanent: true);
    Get.put<FlutterSecureStorage>(const FlutterSecureStorage(),
        permanent: true);

  }
}

