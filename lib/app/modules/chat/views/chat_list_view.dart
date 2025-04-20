import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/layout/view.dart';
import '../controllers/chat_list_controller.dart';

class ChatListView extends GetView<ChatListController> {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      body: Scaffold(
        appBar: AppBar(
          title: Text(
            '消息',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: controller.chatList.length,
            itemBuilder: (context, index) {
              final chat = controller.chatList[index];
              return InkWell(
                onTap:
                    () => Get.toNamed('/chat/detail', arguments: chat.toJson()),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      // 头像
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child:
                                chat.avatar.contains('http')
                                    ? Image.network(
                                      chat.avatar,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                    : Image.asset(
                                      chat.avatar,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                          ),
                          if (chat.unreadCount > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 18,
                                  minHeight: 18,
                                ),
                                child: Center(
                                  child: Text(
                                    '${chat.unreadCount}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: 12),
                      // 聊天信息
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  chat.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  chat.time,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              chat.lastMessage,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
