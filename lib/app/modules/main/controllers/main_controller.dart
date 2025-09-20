import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/modules/main/guide/controllers/guide_controller.dart';
import 'package:pcom_app/app/modules/main/guide/views/guide_view.dart';
import 'package:pcom_app/app/modules/main/home/controllers/home_controller.dart';
import 'package:pcom_app/app/modules/main/my_esim/views/my_esim_view.dart';
import 'package:pcom_app/app/modules/main/profile/controllers/profile_controller.dart';
import '../home/views/home_view.dart';
import '../my_esim/controllers/my_esim_controller.dart';
import '../profile/views/profile_edit.dart';

class MainController extends GetxController {
  RxInt selectedIndex = 0.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var userFullName = ''.obs;
  var userImage = ''.obs;
  final index = 0.obs;

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  final List<Widget> screens = [
    GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) => HomeView(),
    ),
    GetBuilder<MyEsimController>(
      init: MyEsimController(),
      builder: (_) => MyEsimView(),
    ),
    GetBuilder<GuideController>(
      init: GuideController(),
      builder: (_) => GuideView(),
    ),
    GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (_) => ProfileEdit(),
    ),
  ];

}
