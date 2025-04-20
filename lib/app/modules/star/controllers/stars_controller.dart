import 'package:get/get.dart';

class ChatListMessage {
  final String id;
  final String name;
  final String avatar;
  final String lastMessage;
  final String time;
  final int unreadCount;

  ChatListMessage({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'avatar': avatar,
    'lastMessage': lastMessage,
    'time': time,
    'unreadCount': unreadCount,
  };
}

class StarsController extends GetxController {
  final RxList<ChatListMessage> chatList = <ChatListMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    // 模拟数据
    chatList.addAll([
      ChatListMessage(
        id: '1',
        name: '文静女孩11',
        avatar:
            'https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg',
        lastMessage: '你好，很高兴认识你',
        time: '12:30',
        unreadCount: 2,
      ),
      ChatListMessage(
        id: '2',
        name: '慢慢进步2',
        avatar:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
        lastMessage: '最近在忙什么呢？',
        time: '昨天',
        unreadCount: 0,
      ),
      ChatListMessage(
        id: '3',
        name: '可爱一点4',
        avatar: 'assets/girl2.png',
        lastMessage: '周末有空吗？',
        time: '星期一',
        unreadCount: 1,
      ),
      ChatListMessage(
        id: '3',
        name: '可爱一点4',
        avatar: 'assets/girl2.png',
        lastMessage: '周末有空吗？',
        time: '星期一',
        unreadCount: 1,
      ),
      ChatListMessage(
        id: '3',
        name: '可爱一点4',
        avatar: 'assets/girl2.png',
        lastMessage: '周末有空吗？',
        time: '星期一',
        unreadCount: 1,
      ),
      ChatListMessage(
        id: '3',
        name: '可爱一点4',
        avatar: 'assets/girl2.png',
        lastMessage: '周末有空吗？',
        time: '星期一',
        unreadCount: 1,
      ),
      ChatListMessage(
        id: '3',
        name: '可爱一点4',
        avatar: 'assets/girl2.png',
        lastMessage: '周末有空吗？',
        time: '星期一',
        unreadCount: 1,
      ),
      ChatListMessage(
        id: '3',
        name: '可爱一点4',
        avatar: 'assets/girl2.png',
        lastMessage: '周末有空吗？',
        time: '星期一',
        unreadCount: 1,
      ),
      ChatListMessage(
        id: '3',
        name: '可爱一点4',
        avatar: 'assets/girl2.png',
        lastMessage: '周末有空吗？',
        time: '星期一',
        unreadCount: 1,
      ),
      ChatListMessage(
        id: '3',
        name: '可爱一点4',
        avatar: 'assets/girl2.png',
        lastMessage: '周末有空吗？',
        time: '星期一',
        unreadCount: 1,
      ),
      ChatListMessage(
        id: '3',
        name: '可爱一点4',
        avatar: 'assets/girl2.png',
        lastMessage: '周末有空吗？',
        time: '星期一',
        unreadCount: 1,
      ),
      ChatListMessage(
        id: '3',
        name: '可爱一点4',
        avatar: 'assets/girl2.png',
        lastMessage: '周末有空吗？',
        time: '星期一',
        unreadCount: 1,
      ),
      ChatListMessage(
        id: '3',
        name: '可爱一点4',
        avatar: 'assets/girl2.png',
        lastMessage: '周末有空吗？',
        time: '星期一',
        unreadCount: 1,
      ),
    ]);
  }
}
