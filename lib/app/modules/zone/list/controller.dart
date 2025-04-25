import 'package:get/get.dart';

class ZoneListController extends GetxController {
  // 热门话题列表
  final topTopics = <String>['热门', '旅行', '美食', '电影', '音乐', '运动'].obs;

  // 当前选中的标签索引
  final selectedTabIndex = 1.obs;

  // 模拟的动态列表数据
  final posts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();

    // 加载动态列表数据
    _loadPosts();
  }

  // 加载动态列表
  void _loadPosts() {
    // 实际项目中应该从服务器获取数据
    // 这里模拟一些数据
    posts.addAll([
      {
        'id': '1',
        'username': 'air',
        'avatar': 'https://picsum.photos/200/200?random=1',
        'timeAgo': '13分钟前发布',
        'content': '连的快吗 #蜜桃臀',
        'imageUrls': ['https://picsum.photos/375/760?random=1'],
        'likes': 38,
        'comments': 6,
      },
      {
        'id': '2',
        'username': '不减20斤不改名字',
        'avatar': 'https://picsum.photos/200/200?random=2',
        'timeAgo': '5天前发布',
        'content':
            '本人40+，性格温柔贤淑，离异单身，平时跳舞瑜伽都喜欢，希望认识年龄小一点朋友可以逛街聊天（学生也可以，偷偷说😂） #80后单身阿姨 #弟弟',
        'imageUrls': [],
        'likes': 42,
        'comments': 15,
      },
      {
        'id': '3',
        'username': '用户3',
        'avatar': 'https://picsum.photos/200/200?random=3',
        'timeAgo': '30分钟前发布',
        'content': '这是第3条动态内容，#朋友圈 #测试',
        'imageUrls': [
          'https://picsum.photos/500/500?random=6',
          'https://picsum.photos/500/300?random=7',
        ],
        'likes': 25,
        'comments': 9,
      },
      {
        'id': '4',
        'username': '用户4',
        'avatar': 'https://picsum.photos/200/200?random=4',
        'timeAgo': '40分钟前发布',
        'content': '这是第4条动态内容，#朋友圈 #测试',
        'imageUrls': [],
        'likes': 30,
        'comments': 11,
      },
      {
        'id': '5',
        'username': '用户5',
        'avatar': 'https://picsum.photos/200/200?random=5',
        'timeAgo': '50分钟前发布',
        'content': '这是第5条动态内容，#朋友圈 #测试',
        'imageUrls': ['https://picsum.photos/500/300?random=10'],
        'likes': 35,
        'comments': 13,
      },
    ]);
  }

  // 切换标签
  void changeTab(int index) {
    selectedTabIndex.value = index;
    update();
  }

  // 喜欢/点赞帖子
  void likePost(String postId) {
    final index = posts.indexWhere((post) => post['id'] == postId);
    if (index != -1) {
      posts[index]['likes'] = (posts[index]['likes'] as int) + 1;
      update();
    }
  }

  // 前往详情页
  void goToDetail(Map<String, dynamic> post) {
    Get.toNamed('/zone/detail', arguments: post);
  }

  // 前往发布页
  void goToCreate() {
    Get.toNamed('/zone/create');
  }

  // 前往聊天页
  void goToChat(String userId, String username) {
    Get.snackbar('提示', '正在前往与$username的聊天');
    // 实际项目中应该跳转到聊天页面
  }
}
