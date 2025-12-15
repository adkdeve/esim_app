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
  final authService = Get.find<AuthService>();

  AuthController authController = Get.find<AuthController>();


  @override
  void onInit() {
    super.onInit();

    _listener = () {
      _updateLoginButtonState();
    };

    emailController.addListener(_listener);
    passwordController.addListener(_listener);
  }

  void _updateLoginButtonState() {
    final isEmailValid = emailController.text.isEmailAddress;
    final isValid =
        isEmailValid && passwordController.text.trim().isNotEmpty;

    isLoginButtonEnabled.value = isValid;
  }

  @override
  void onClose() {
    emailController.removeListener(_listener);
    passwordController.removeListener(_listener);
    super.onClose();
  }

}
