import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/app/modules/auth/controllers/auth_controller.dart';
import '../../../data/repositories/repository.dart';
import '../../../data/services/auth_service.dart';
import '../../../../utils/helpers/easy_loading.dart';
import '../../../../utils/helpers/snackbar.dart';
import '../../../routes/app_pages.dart';

class SignupController extends GetxController {
  /// Reactive
  var isSignupButtonEnabled = false.obs;

  var isLengthValid = false.obs;
  var hasUpperLower = false.obs;
  var hasNumber = false.obs;
  var hasSpecial = false.obs;
  var hasPasswordText = false.obs;

  /// Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late VoidCallback _listener;

  /// Dependencies
  final _repo = Get.find<Repository>();
  final logger = Get.find<Logger>();
  final storage = Get.find<FlutterSecureStorage>();
  final loading = Get.find<MyLoading>();
  final authService = Get.find<AuthService>();

  AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();

    _listener = () {
      checkPasswordStrength(passwordController.text);
      _updateSignupButtonState();
    };

    emailController.addListener(_listener);
    passwordController.addListener(_listener);
  }

  void checkPasswordStrength(String value) {
    hasPasswordText.value = value.isNotEmpty;
    isLengthValid.value = value.length >= 8;
    hasUpperLower.value = value.contains(RegExp(r'(?=.*[a-z])(?=.*[A-Z])'));
    hasNumber.value = value.contains(RegExp(r'[0-9]'));
    hasSpecial.value = value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
  }

  void _updateSignupButtonState() {
    final emailValid = emailController.text.isEmailAddress;

    isSignupButtonEnabled.value =
        emailValid &&
            isLengthValid.value &&
            hasUpperLower.value &&
            hasNumber.value &&
            hasSpecial.value;
  }

  @override
  void onClose() {
    emailController.removeListener(_listener);
    passwordController.removeListener(_listener);
    super.onClose();
  }



}
