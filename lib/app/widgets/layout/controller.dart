import 'package:get/get.dart';
import '../../routes/routes.dart';

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.offNamed(Routes.HOME);
        break;
      case 1:
        Get.offNamed(Routes.FAVORATE);
        break;
      case 2:
        Get.offNamed(Routes.Zone);
        break;
      case 3:
        Get.offNamed(Routes.CHAT_LIST);
        break;
      case 4:
        Get.offNamed(Routes.PROFILE);
        break;
    }
  }
}
