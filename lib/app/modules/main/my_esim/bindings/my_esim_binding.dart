import 'package:get/get.dart';

import '../controllers/my_esim_controller.dart';

class MyEsimBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyEsimController>(
      () => MyEsimController(),
    );
  }
}
