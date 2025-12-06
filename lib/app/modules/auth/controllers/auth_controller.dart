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
  // /// --- Reactive states ---
  // var isLoginButtonEnabled = false.obs;
  // var isSignupButtonEnabled = false.obs;
  //
  // var isLengthValid = false.obs;
  // var hasUpperLowerCase = false.obs;
  // var hasNumber = false.obs;
  // var hasSpecialChar = false.obs;
  // final hasPasswordText = false.obs;
  //
  // /// --- Form Keys ---
  // final formLoginKey = GlobalKey<FormState>();
  // final formSignupKey = GlobalKey<FormState>();
  //
  // /// --- Controllers ---
  // final emailLoginController = TextEditingController();
  // final passwordLoginController = TextEditingController();
  //
  // final emailSignupController = TextEditingController();
  // final passwordSignupController = TextEditingController();
  //
  // /// --- Listener refs ---
  // late VoidCallback _loginListener;
  // late VoidCallback _signupListener;

  /// --- Dependencies ---
  final _myRepo = Get.find<Repository>();
  final logger = Get.find<Logger>();
  final storage = Get.find<FlutterSecureStorage>();
  final loading = Get.find<MyLoading>();
  final authService = Get.find<AuthService>();

  // ------------------------------
  //           API CALL
  // ------------------------------
  Future<void> postApi(var data, String url) async {
    logger.v(url);
    logger.v(data);
    loading.showEasyLoading('Loading...');
    Get.focusScope?.unfocus();

    _myRepo.postApi(data, url).then((value) async {
      loading.dismissEasyLoading();

      if (value == null) {
        SnackBarUtils.showError("Unexpected empty response");
        return;
      }

      try {
        final response = json.decode(value);
        logger.d(response);

        if (response['success'] == true) {
          switch (url) {
            case ApisUrl.login:
              await authService.saveUserData(response, '');
              Get.offAllNamed(Routes.MAIN);
              break;

            case ApisUrl.signUp:
              Get.toNamed(Routes.SIGNIN);
              break;

            default:
              SnackBarUtils.successMsg(response['message']);
          }
        } else {
          SnackBarUtils.errorMsg(response['message']);
        }
      } catch (e) {
        logger.e("JSON Parsing Error: $e");
        SnackBarUtils.showError("Invalid server response format");
      }
    }).onError((error, stackTrace) {
      logger.e(error);
      loading.dismissEasyLoading();
      SnackBarUtils.showError(error.toString());
    });
  }

  // // ------------------------------
  // //       LIFECYCLE INIT
  // // ------------------------------
  // @override
  // void onInit() {
  //   super.onInit();
  //
  //   /// LOGIN LISTENER
  //   _loginListener = _updateLoginButtonState;
  //   emailLoginController.addListener(_loginListener);
  //   passwordLoginController.addListener(_loginListener);
  //
  //   /// SIGNUP LISTENER
  //   _signupListener = () {
  //     checkPasswordStrength(passwordSignupController.text);
  //     _updateSignupButtonState();
  //   };
  //   emailSignupController.addListener(_signupListener);
  //   passwordSignupController.addListener(_signupListener);
  // }
  //
  // // ------------------------------
  // //       PASSWORD CHECKER
  // // ------------------------------
  // void checkPasswordStrength(String value) {
  //   hasPasswordText.value = value.isNotEmpty;
  //   isLengthValid.value = value.length >= 8;
  //   hasUpperLowerCase.value = value.contains(RegExp(r'(?=.*[a-z])(?=.*[A-Z])'));
  //   hasNumber.value = value.contains(RegExp(r'[0-9]'));
  //   hasSpecialChar.value = value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
  // }
  //
  // // ------------------------------
  // //      EMAIL MASK HELPER
  // // ------------------------------
  // String maskEmail(String email) {
  //   final parts = email.split('@');
  //   if (parts.length != 2) return email;
  //
  //   final username = parts[0];
  //   final domain = parts[1];
  //
  //   if (username.length <= 2) {
  //     return '***$username@$domain';
  //   } else {
  //     final visible = username.substring(username.length - 2);
  //     return '***$visible@$domain';
  //   }
  // }
  //
  // // ------------------------------
  // //   UPDATE LOGIN BUTTON STATE
  // // ------------------------------
  // void _updateLoginButtonState() {
  //   final isEmailValid = emailLoginController.text.isEmailAddress;
  //   final isValid =
  //       isEmailValid && passwordLoginController.text.trim().isNotEmpty;
  //
  //   isLoginButtonEnabled.value = isValid;
  // }
  //
  // // ------------------------------
  // //   UPDATE SIGNUP BUTTON STATE
  // // ------------------------------
  // void _updateSignupButtonState() {
  //   final isEmailValid = emailSignupController.text.isEmailAddress;
  //
  //   isSignupButtonEnabled.value = isEmailValid &&
  //       isLengthValid.value &&
  //       hasUpperLowerCase.value &&
  //       hasNumber.value &&
  //       hasSpecialChar.value;
  // }
  //
  // // ------------------------------
  // //   USER SESSION CHECK
  // // ------------------------------
  // Future<bool> isUserLoggedIn() async {
  //   final token = await authService.getToken();
  //   return token != null && token.isNotEmpty;
  // }
  //
  // void checkUserSession() async {
  //   if (await isUserLoggedIn()) {
  //     Get.offAllNamed(Routes.MAIN);
  //   }
  // }
  //
  // // ------------------------------
  // //           CLEANUP
  // // ------------------------------
  // @override
  // void onClose() {
  //   /// Remove login listeners
  //   emailLoginController.removeListener(_loginListener);
  //   passwordLoginController.removeListener(_loginListener);
  //
  //   /// Remove signup listeners (FIXED)
  //   emailSignupController.removeListener(_signupListener);
  //   passwordSignupController.removeListener(_signupListener);
  //
  //   super.onClose();
  // }
}
