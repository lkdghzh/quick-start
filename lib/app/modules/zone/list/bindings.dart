import 'package:get/get.dart';

import 'controller.dart';

class ZoneListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoneListController>(() => ZoneListController());
  }
}
