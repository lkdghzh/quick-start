import 'package:get/get.dart';

import 'controller.dart';

class ZonePubBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZonePubController>(() => ZonePubController());
  }
}
