import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:pcom_app/app/core/core.dart';
import '../../../data/repositories/repository.dart';
import '../../../data/services/auth_service.dart';
import '../../../../utils/helpers/easy_loading.dart';
import '../../../../utils/helpers/snackbar.dart';
import '../../../routes/app_pages.dart';
import 'auth_controller.dart';

class SigninController extends GetxController {
  /// --- Reactive states ---
  var isLoginButtonEnabled = false.obs;

  /// --- Controllers ---
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late VoidCallback _listener;

  /// --- Dependencies ---
  final _repo = Get.find<Repository>();
  final logger = Get.find<Logger>();
  final storage = Get.find<FlutterSecureStorage>();
  final loading = Get.find<MyLoading>();
  final authService = Get.find<AuthService>();

  AuthController authController = Get.find<AuthController>();


  @override
  void onInit() {
    super.onInit();

    /// listener to update button state
    _listener = _updateLoginButtonState;

    emailController.addListener(_listener);
    passwordController.addListener(_listener);
  }

  @override
  void onClose() {
    emailController.removeListener(_listener);
    passwordController.removeListener(_listener);
    super.onClose();
  }

  void _updateLoginButtonState() {
    final isEmailValid = emailController.text.isEmailAddress;
    final isValid =
        isEmailValid && passwordController.text.trim().isNotEmpty;

    isLoginButtonEnabled.value = isValid;
  }

  Future<void> login() async {
    final data = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    };

    loading.showEasyLoading('Logging in...');
    _repo.postApi(data, ApisUrl.login).then((value) async {
      loading.dismissEasyLoading();

      if (value == null) {
        SnackBarUtils.errorMsg("Empty server response");
        return;
      }

      try {
        final response = json.decode(value);

        if (response["success"] == true) {
          await authService.saveUserData(response, '');
          Get.offAllNamed(Routes.MAIN);
        } else {
          SnackBarUtils.errorMsg(response["message"]);
        }
      } catch (e) {
        logger.e(e);
        SnackBarUtils.showError("Invalid server response");
      }
    }).onError((error, _) {
      loading.dismissEasyLoading();
      SnackBarUtils.errorMsg(error.toString());
    });
  }
}
