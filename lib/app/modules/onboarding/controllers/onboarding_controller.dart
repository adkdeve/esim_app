import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  final List<Map<String, dynamic>> onboardingData = [
    {
      'title': RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, height: 1.6),
          children: [
            TextSpan(text: 'Make sure your ', style: TextStyle(color: Colors.white)),
            TextSpan(text: 'device ', style: TextStyle(color: Color(0xFFB87333))),
            TextSpan(text: 'is\ncompatible with ', style: TextStyle(color: Colors.white)),
            TextSpan(text: 'eSIM technology.', style: TextStyle(color: Color(0xFFB87333))),
          ],
        ),
      ),
      'image': 'assets/images/img_onboarding1.png',
    },
    {
      'title': RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, height: 1.6),
          children: [
            TextSpan(text: 'Choose the ', style: TextStyle(color: Colors.white)),
            TextSpan(text: 'number of days ', style: TextStyle(color: Color(0xFFB87333), fontWeight: FontWeight.bold)),
            TextSpan(text: '\nand eSIMs ', style: TextStyle(color: Color(0xFFB87333), fontWeight: FontWeight.bold)),
            TextSpan(text: 'you need to', style: TextStyle(color: Colors.white)),
            TextSpan(text: '\npurchase. ', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      'image': 'assets/images/img_onboarding2.png',
    },
    {
      'title': RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, height: 1.6),
          children: [
            TextSpan(text: 'Set up your eSIMs easily ', style: TextStyle(color: Color(0xFFB87333))),
            TextSpan(text: 'and', style: TextStyle(color: Colors.white)),
            TextSpan(text: '\nkeep track of your ', style: TextStyle(color: Colors.white)),
            TextSpan(text: 'plan’s data', style: TextStyle(color: Color(0xFFB87333))),
            TextSpan(text: '\nand expiration date.', style: TextStyle(color: Color(0xFFB87333))),

          ],
        ),
      ),
      'image': 'assets/images/img_onboarding3.png',
    },
  ];


}
