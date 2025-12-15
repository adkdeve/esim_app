import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/modules/main/controllers/main_controller.dart';
import '../../../../../utils/helpers/snackbar.dart';
import '../../../../core/core.dart';
import '../../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final name = TextEditingController();
  final email = TextEditingController();
  final birthdayController = TextEditingController();

  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    super.onInit();
    final user = mainController.user;

    if (user != null) {
      name.text = user.displayName ?? '';
      email.text = user.userEmail ?? '';
      birthdayController.text = user.dob ?? '';
    }
  }

  // Contact Us
  final contactName = TextEditingController();
  final contactlastName = TextEditingController();
  final contactEmail = TextEditingController();
  final contactSubject = TextEditingController();
  final contactMessage = TextEditingController();

  DateTime? selectedDate;

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.grey[850],
            colorScheme: ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate = picked;
      birthdayController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  Future<void> logout() async {
    mainController.loading.showEasyLoading('Logging out...');

    try {
      await mainController.authService.logout();

      mainController.loading.easyLoadingSuccess();

      Get.offAllNamed(Routes.ONBOARDING);
    } catch (e) {
      mainController.loading.dismissEasyLoading();
      SnackBarUtils.errorMsg("Something went wrong!");
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    birthdayController.dispose();
    super.dispose();
  }
}
