import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_detail_controller.dart';

class ChatDetailView extends GetView<ChatDetailController> {
  const ChatDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatData = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              chatData['name'] as String,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('在线', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 消息列表
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return _buildMessageItem(message);
                },
              ),
            ),
          ),
          // 输入框
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, -1),
                  blurRadius: 5,
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.image_outlined),
                    onPressed: () {},
                    color: Colors.grey[600],
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        onChanged:
                            (value) => controller.inputText.value = value,
                        decoration: InputDecoration(
                          hintText: '发送消息...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Obx(
                    () => IconButton(
                      icon: Icon(Icons.send),
                      onPressed:
                          controller.inputText.isEmpty
                              ? null
                              : () => controller.sendMessage(
                                controller.inputText.value,
                              ),
                      color:
                          controller.inputText.isEmpty
                              ? Colors.grey[400]
                              : Colors.pink,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(Get.arguments['avatar'] as String),
            ),
            SizedBox(width: 8),
          ],
          Column(
            crossAxisAlignment:
                message.isSender
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: Get.width * 0.7),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: message.isSender ? Colors.pink : Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child:
                    message.image != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            message.image!,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                        : Text(
                          message.message,
                          style: TextStyle(
                            color:
                                message.isSender
                                    ? Colors.white
                                    : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
              ),
              SizedBox(height: 4),
              Text(
                message.time,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          if (message.isSender) ...[
            SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.person, color: Colors.grey[400], size: 20),
            ),
          ],
        ],
      ),
    );
  }
}
