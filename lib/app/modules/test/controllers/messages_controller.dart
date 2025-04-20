import 'package:get/get.dart';

class MessagesController extends GetxController {
  final RxList<String> messages = <String>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  Future<void> loadMessages() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // 模拟加载
    messages.assignAll([
      '消息1: 你好',
      '消息2: GetX很棒',
      '消息3: Flutter很棒',
    ]);
    isLoading.value = false;
  }

  Future<void> refreshMessages() async {
    messages.clear();
    await loadMessages();
  }
}
