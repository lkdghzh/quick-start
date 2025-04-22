import 'package:get/get.dart';

import 'state.dart';

class UserController extends GetxController {
  UserController();

  final state = UserState();

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    // 从路由参数中获取用户数据
    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      state.name = args['name'] ?? '爱自由的小鹿';
      state.avatar =
          args['avatar'] ??
          'https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg';
      state.age = args['age'] ?? '25岁';
      state.gender = args['gender'] ?? '女';
      state.location = args['location'] ?? '在北京';
      state.job = args['job'] ?? '设计师';
      state.marriage = args['marriage'] ?? '未婚';
      state.bio = args['bio'] ?? '喜欢旅行、摄影、美食，希望能遇到一个有趣的灵魂～';
      state.interests =
          (args['interests'] as List<String>?) ??
          ['旅行', '摄影', '美食', '音乐', '电影'];
      state.photos =
          (args['photos'] as List<String>?) ??
          [
            'https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg',
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
            'https://images.pexels.com/photos/1858175/pexels-photo-1858175.jpeg',
          ];
    }
  }

  void handleLike() {
    Get.snackbar('提示', '已喜欢');
  }

  void handleChat() {
    Get.toNamed(
      '/chat/detail',
      arguments: {'id': '1', 'name': state.name, 'avatar': state.avatar},
    );
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }
}
