import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZoneCreateController extends GetxController {
  // 文本输入控制器
  late TextEditingController textController;
  late TextEditingController topicSearchController;

  // 选择的图片列表
  final selectedImages = <String>[].obs;

  // 选择的话题列表
  final selectedTopics = <String>[].obs;

  // 选择的位置
  final location = ''.obs;

  // 显示表情选择器
  final showEmojis = false.obs;

  // 显示话题选择器
  final showTopics = false.obs;

  // 可见性
  final visibility = 0.obs; // 0: 所有人, 1: 仅自己, 2: 部分可见

  // 上传状态
  final isUploading = false.obs;

  // 话题列表
  final topics =
      [
        '热门',
        '旅行',
        '美食',
        '电影',
        '音乐',
        '运动',
        '摄影',
        '科技',
        '宠物',
        '时尚',
        '汽车',
        '游戏',
        '健康',
        '教育',
        '职场',
        '情感',
        '明星',
        '美妆',
        '家居',
        '育儿',
      ].obs;

  // 过滤后的话题列表
  List<String> get filteredTopics {
    final query = topicSearchController.text.toLowerCase();
    if (query.isEmpty) {
      return topics;
    }
    return topics
        .where((topic) => topic.toLowerCase().contains(query))
        .toList();
  }

  // 检查是否可以发布
  bool get canPost {
    return textController.text.isNotEmpty || selectedImages.isNotEmpty;
  }

  // 可见性文本
  String get visibilityText {
    switch (visibility.value) {
      case 0:
        return '所有人可见';
      case 1:
        return '仅自己可见';
      case 2:
        return '部分可见';
      default:
        return '所有人可见';
    }
  }

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    topicSearchController = TextEditingController();

    // 监听搜索框变化
    topicSearchController.addListener(() {
      update();
    });
  }

  @override
  void onClose() {
    textController.dispose();
    topicSearchController.dispose();
    super.onClose();
  }

  // 选择图片
  void pickImages() {
    // 实际项目中这里应该使用image_picker插件
    // 这里简单模拟添加一些图片
    selectedImages.add(
      'https://picsum.photos/500/500?random=${selectedImages.length + 1}',
    );
    update();
  }

  // 选择视频
  void pickVideo() {
    Get.snackbar('提示', '选择视频功能正在开发中');
  }

  // 删除图片
  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
      update();
    }
  }

  // 显示表情选择器
  void showEmojiPicker() {
    showEmojis.value = !showEmojis.value;
    if (showEmojis.value) {
      showTopics.value = false;
    }
  }

  // 插入表情
  void insertEmoji(String emoji) {
    final text = textController.text;
    final selection = textController.selection;
    final newText = text.replaceRange(selection.start, selection.end, emoji);
    textController.text = newText;
    textController.selection = TextSelection.collapsed(
      offset: selection.start + emoji.length,
    );
  }

  // 显示话题选择器
  void showTopicSelector() {
    showTopics.value = !showTopics.value;
    if (showTopics.value) {
      showEmojis.value = false;
    }
  }

  // 添加话题
  void addTopic(String topic) {
    if (!selectedTopics.contains(topic)) {
      selectedTopics.add(topic);
      update();
    }
    showTopics.value = false;
  }

  // 删除话题
  void removeTopic(String topic) {
    selectedTopics.remove(topic);
    update();
  }

  // 清除位置
  void clearLocation() {
    location.value = '';
    update();
  }

  // 发布动态
  void postMoment() async {
    if (!canPost) return;

    isUploading.value = true;
    update();

    // 模拟上传延迟
    await Future.delayed(const Duration(seconds: 2));

    // 实际项目中这里应该将数据上传到服务器
    // 包括文本内容、图片、话题标签等

    isUploading.value = false;
    update();

    Get.back(
      result: {
        'success': true,
        'content': textController.text,
        'images': selectedImages,
        'topics': selectedTopics,
        'location': location.value,
      },
    );

    Get.snackbar('成功', '动态已发布');
  }
}
