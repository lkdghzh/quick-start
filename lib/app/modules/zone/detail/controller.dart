import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ZoneDetailController extends GetxController {
  // 评论控制器
  late TextEditingController commentController;

  // 评论列表
  final comments = <Map<String, dynamic>>[].obs;

  // 帖子信息
  final post = <String, dynamic>{}.obs;

  // 是否已点赞
  final isLiked = false.obs;

  @override
  void onInit() {
    super.onInit();
    commentController = TextEditingController();

    // 初始化帖子数据
    if (Get.arguments != null) {
      post.value = Map<String, dynamic>.from(Get.arguments);
    }

    // 初始化一些模拟评论数据
    _loadComments();
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }

  // 加载评论
  void _loadComments() {
    // 实际项目中应该从服务器获取评论
    // 这里模拟一些评论数据
    comments.addAll([
      {
        'id': '1',
        'userName': '用户1',
        'userAvatar': 'https://picsum.photos/200/200?random=10',
        'content': '很棒的分享！',
        'timeAgo': '5分钟前',
        'likes': 3,
      },
      {
        'id': '2',
        'userName': '用户2',
        'userAvatar': 'https://picsum.photos/200/200?random=11',
        'content': '我也想去这个地方！',
        'timeAgo': '10分钟前',
        'likes': 1,
      },
      {
        'id': '3',
        'userName': '用户3',
        'userAvatar': 'https://picsum.photos/200/200?random=12',
        'content': '太美了，请问是在哪里拍的？',
        'timeAgo': '15分钟前',
        'likes': 0,
      },
    ]);
  }

  // 发表评论
  void submitComment() {
    if (commentController.text.isEmpty) return;

    // 添加新评论
    comments.insert(0, {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'userName': '我',
      'userAvatar': 'https://picsum.photos/200/200?random=1',
      'content': commentController.text,
      'timeAgo': '刚刚',
      'likes': 0,
    });

    // 更新评论数
    if (post['comments'] != null) {
      post['comments'] = (post['comments'] as int) + 1;
    }

    // 清空输入框
    commentController.clear();
    update();
  }

  // 点赞评论
  void likeComment(String commentId) {
    final index = comments.indexWhere((comment) => comment['id'] == commentId);
    if (index != -1) {
      comments[index]['likes'] = (comments[index]['likes'] as int) + 1;
      update();
    }
  }

  // 点赞帖子
  void likePost() {
    isLiked.value = !isLiked.value;

    if (isLiked.value) {
      if (post['likes'] != null) {
        post['likes'] = (post['likes'] as int) + 1;
      }
    } else {
      if (post['likes'] != null && (post['likes'] as int) > 0) {
        post['likes'] = (post['likes'] as int) - 1;
      }
    }

    update();
  }

  // 分享帖子
  void sharePost() {
    Get.snackbar('提示', '分享功能正在开发中');
  }
}
