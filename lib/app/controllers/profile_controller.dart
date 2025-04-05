import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString username = '用户名'.obs;
  final RxString email = 'example@email.com'.obs;
  final RxBool isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    // 这里可以添加切换主题的逻辑
  }

  void updateProfile({
    String? newUsername,
    String? newEmail,
  }) {
    if (newUsername != null) username.value = newUsername;
    if (newEmail != null) email.value = newEmail;
  }
}
