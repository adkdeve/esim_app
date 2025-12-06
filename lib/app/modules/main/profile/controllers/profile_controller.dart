import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/modules/main/controllers/main_controller.dart';

class ProfileController extends GetxController {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final birth = TextEditingController();
  final birthdayController = TextEditingController();


  late MainController mainController;

  @override
  void onInit() {
    super.onInit();
    // 2. Initialize it here
    mainController = Get.find<MainController>();
  }

  // Contact Us
  final contactName = TextEditingController();
  final contactlastName = TextEditingController();
  final contactEmail = TextEditingController();
  final contactSubject = TextEditingController();
  final contactMessage = TextEditingController();


  DateTime? selectedDate;

  final List<String> countries = [
    '🇬🇧 +44',
    '🇫🇷 +33',
    '🇺🇸 +1',
    '🇮🇳 +91',
  ];

  String selectedCountry = '🇬🇧 +44';


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


  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    birth.dispose();
    super.dispose();
  }
}
