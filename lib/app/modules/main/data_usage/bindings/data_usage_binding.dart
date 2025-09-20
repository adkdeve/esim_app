import 'package:get/get.dart';

import '../controllers/data_usage_controller.dart';

class DataUsageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataUsageController>(
      () => DataUsageController(),
    );
  }
}
