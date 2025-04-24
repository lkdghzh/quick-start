import 'package:get/get.dart';

import 'controller.dart';

class ZoneDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoneDetailController>(() => ZoneDetailController());
  }
}
