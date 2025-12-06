import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pcom_app/app/data/repositories/repository.dart';
import 'package:pcom_app/app/data/services/auth_service.dart';
import 'package:pcom_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:pcom_app/utils/helpers/easy_loading.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<Repository>(Repository(), permanent: true);
    Get.put<Logger>(Logger(), permanent: true);
    Get.put<MyLoading>(MyLoading(), permanent: true);
    Get.put<FlutterSecureStorage>(const FlutterSecureStorage(),
        permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);

  }
}

