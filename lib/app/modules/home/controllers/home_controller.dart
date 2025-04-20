import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxString welcomeMessage = '欢迎来到首页'.obs;
  final RxInt clickCount = 0.obs;

  void updateWelcomeMessage() {
    clickCount.value++;
    welcomeMessage.value = '点击了 ${clickCount.value} 次';
  }
}
