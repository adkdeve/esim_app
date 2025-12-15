import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:logger/logger.dart';
import '../../../../utils/helpers/easy_loading.dart';
import '../../../../utils/helpers/snackbar.dart';
import '../../../data/repositories/repository.dart';
import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {

  final _myRepo = Get.find<Repository>();
  final logger = Get.find<Logger>();
  final storage = Get.find<FlutterSecureStorage>();
  final loading = Get.find<MyLoading>();
  final authService = Get.find<AuthService>();

  Future<void> postApi(var data, String url) async {
    logger.v("Requesting URL: $url");
    logger.v("Request Data: $data");

    loading.showEasyLoading('Loading...');
    Get.focusScope?.unfocus();

    _myRepo.postApi(data, url).then((value) async {
      loading.dismissEasyLoading();

      // This is where your error is currently triggering
      if (value == null) {
        logger.e("Repository returned null for URL: $url");
        SnackBarUtils.showError("Unexpected empty response");
        return;
      }

      try {
        // Ensure value is a String before decoding
        final response = value is String ? json.decode(value) : value;
        logger.d("Decoded Response: $response");

        // WordPress/Laravel APIs sometimes use 'status' instead of 'success'
        // Double check your API key names
        bool isSuccess = response['success'] == true || response['status'] == 'success';

        if (isSuccess) {
          if (url.contains(ApisUrl.login)) {
            // Await storage before navigating
            await authService.saveUserData(data['password'], response, '');
            Get.offAllNamed(Routes.MAIN);
          } else if (url.contains(ApisUrl.signUp)) {
            SnackBarUtils.successMsg(response['message'] ?? "Account created!");
            Get.toNamed(Routes.SIGNIN);
          } else {
            SnackBarUtils.successMsg(response['message'] ?? "Success");
          }
        } else {
          SnackBarUtils.errorMsg(response['message'] ?? "Operation failed");
        }
      } catch (e) {
        logger.e("JSON Parsing Error: $e \nRaw Value: $value");
        SnackBarUtils.showError("Invalid server response format");
      }
    }).onError((error, stackTrace) {
      loading.dismissEasyLoading();
      logger.e("API Error: $error");
      SnackBarUtils.showError(error.toString());
    });
  }
}
