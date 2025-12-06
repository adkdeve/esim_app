import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pcom_app/app/modules/main/guide/controllers/guide_controller.dart';
import 'package:pcom_app/app/modules/main/guide/views/guide_view.dart';
import 'package:pcom_app/app/modules/main/home/controllers/home_controller.dart';
import 'package:pcom_app/app/modules/main/my_esim/views/my_esim_view.dart';
import 'package:pcom_app/app/modules/main/profile/controllers/profile_controller.dart';
import '../../../../utils/helpers/easy_loading.dart';
import '../../../../utils/helpers/snackbar.dart';
import '../../../core/core.dart';
import '../../../data/repositories/repository.dart';
import '../../../data/services/auth_service.dart';
import '../home/views/home_view.dart';
import '../my_esim/controllers/my_esim_controller.dart';
import '../profile/views/profile_edit.dart';
import '../profile/views/profile_view.dart';

class MainController extends GetxController {
  RxInt selectedIndex = 0.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var userFullName = ''.obs;
  var userImage = ''.obs;
  final index = 0.obs;

  final _myRepo = Get.find<Repository>();
  final logger = Get.find<Logger>();
  final storage = Get.find<FlutterSecureStorage>();
  final loading = Get.find<MyLoading>();
  var authService = Get.find<AuthService>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  Future<void> postApi(var data, String url) async {
    logger.v(url);
    logger.v(data);
    loading.showEasyLoading('Loading...');
    Get.focusScope?.unfocus();
    _myRepo
        .postApiWithHeader(data, url)
        .then((value) async {
      if (value != null) {
        final response = json.decode(value);
        logger.d(response);

        if (response?['success'] == true) {
          switch (url) {
            case ApisUrl.updateProfile:
              Get.back();
              break;
            case ApisUrl.changePassword:
              SnackBarUtils.successMsg(response['message']);
              Get.back();
              break;
            case ApisUrl.contactUs:
              Get.back();
              break;

            default:
              SnackBarUtils.successMsg(response['message']);
          }
        } else {
          SnackBarUtils.errorMsg(response['message']);
        }
      }loading.dismissEasyLoading();
    }).onError((error, stackTrace) {
      logger.e(error);
      loading.dismissEasyLoading();
      SnackBarUtils.showError(error.toString());
    });
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
      builder: (_) => ProfileView(),
    ),
  ];

}
