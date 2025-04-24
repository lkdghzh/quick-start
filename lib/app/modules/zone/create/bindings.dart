import 'package:get/get.dart';

import 'controller.dart';

class ZoneCreateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoneCreateController>(() => ZoneCreateController());
  }
}
