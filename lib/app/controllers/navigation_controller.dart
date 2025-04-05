import 'package:get/get.dart';
import '../routes/app_pages.dart';

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.offNamed(Routes.HOME);
        break;
      case 1:
        Get.offNamed(Routes.MESSAGES);
        break;
      case 2:
        Get.offNamed(Routes.PROFILE);
        break;
    }
  }
}
