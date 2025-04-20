import 'package:get/get.dart';

class ChatMessage {
  final String id;
  final bool isSender;
  final String message;
  final String time;
  final String? image;

  ChatMessage({
    required this.id,
    required this.isSender,
    required this.message,
    required this.time,
    this.image,
  });
}

class ChatDetailController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxString inputText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // 模拟历史消息
    messages.addAll([
      ChatMessage(
        id: '1',
        isSender: false,
        message: '你好，很高兴认识你！',
        time: '12:30',
      ),
      ChatMessage(
        id: '2',
        isSender: true,
        message: '你好，我也很高兴认识你！',
        time: '12:31',
      ),
      ChatMessage(id: '3', isSender: false, message: '最近在忙什么呢？', time: '12:32'),
    ]);
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    messages.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        isSender: true,
        message: text,
        time: '${DateTime.now().hour}:${DateTime.now().minute}',
      ),
    );

    inputText.value = '';
  }

  void sendImage(String imagePath) {
    messages.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        isSender: true,
        message: '',
        time: '${DateTime.now().hour}:${DateTime.now().minute}',
        image: imagePath,
      ),
    );
  }
}
