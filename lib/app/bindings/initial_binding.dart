import 'package:get/get.dart';
import '../controllers/app_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/navigation_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // 注入全局控制器
    Get.put(AppController(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(NavigationController(), permanent: true);
    // 初始化操作
    // final appController = Get.find<AppController>();
    // final authController = Get.find<AuthController>();

    // 加载主题设置
    // appController.isDarkMode.value = false;

    // 延迟检查登录状态，确保 GetMaterialApp 已完全初始化
    // Future.delayed(Duration.zero, () {
    //   if (authController.isLoggedIn) {
    //     authController.refreshToken();
    //   } else {
    //     Get.offAllNamed('/login');
    //   }
    // });
  }
}
