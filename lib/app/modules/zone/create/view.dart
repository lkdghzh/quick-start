import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'controller.dart';

class ZoneCreatePage extends GetView<ZoneCreateController> {
  const ZoneCreatePage({super.key});

  // 文本输入区域
  Widget _buildTextInput() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: TextField(
        controller: controller.textController,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: '这一刻的想法...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
        ),
        style: TextStyle(fontSize: 16.sp),
      ),
    );
  }

  // 选择的图片预览
  Widget _buildImagePreview() {
    return Obx(
      () =>
          controller.selectedImages.isEmpty
              ? const SizedBox.shrink()
              : Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.w,
                  ),
                  itemCount: controller.selectedImages.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            controller.selectedImages[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          right: 4.w,
                          top: 4.h,
                          child: GestureDetector(
                            onTap: () => controller.removeImage(index),
                            child: Container(
                              padding: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(153),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
    );
  }

  // 已选择的话题标签
  Widget _buildSelectedTopics() {
    return Obx(
      () =>
          controller.selectedTopics.isEmpty
              ? const SizedBox.shrink()
              : Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children:
                      controller.selectedTopics
                          .map(
                            (topic) => Chip(
                              label: Text(
                                '#$topic',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 14.sp,
                                ),
                              ),
                              backgroundColor: Colors.teal.withOpacity(0.1),
                              deleteIcon: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.teal,
                              ),
                              onDeleted: () => controller.removeTopic(topic),
                            ),
                          )
                          .toList(),
                ),
              ),
    );
  }

  // 底部工具栏
  Widget _buildToolbar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildToolButton(
                  Icons.photo_library,
                  '图片',
                  controller.pickImages,
                ),
                SizedBox(width: 24.w),
                _buildToolButton(Icons.videocam, '视频', controller.pickVideo),
                SizedBox(width: 24.w),
                _buildToolButton(Icons.tag, '话题', controller.showTopicSelector),
                SizedBox(width: 24.w),
                _buildToolButton(
                  Icons.emoji_emotions_outlined,
                  '表情',
                  controller.showEmojiPicker,
                ),
              ],
            ),
            Obx(
              () =>
                  controller.isUploading.value
                      ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                      )
                      : ElevatedButton(
                        onPressed:
                            controller.canPost ? controller.postMoment : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                        ),
                        child: Text(
                          '发布',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.grey[700]),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  // 表情选择器
  Widget _buildEmojiPicker() {
    return Obx(
      () =>
          controller.showEmojis.value
              ? Container(
                height: 250.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: GridView.builder(
                  padding: EdgeInsets.all(8.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: 50, // 假设有50个表情
                  itemBuilder: (context, index) {
                    // 这里使用一些预定义的emoji，实际项目中可以引入表情包
                    return GestureDetector(
                      onTap:
                          () => controller.insertEmoji(
                            [
                              '😀',
                              '😃',
                              '😄',
                              '😁',
                              '😆',
                              '😅',
                              '😂',
                              '🤣',
                              '🥲',
                              '😊',
                              '😇',
                              '🙂',
                              '🙃',
                              '😉',
                              '😌',
                              '😍',
                              '🥰',
                              '😘',
                              '😗',
                              '😙',
                              '😚',
                              '😋',
                              '😛',
                              '😝',
                              '😜',
                              '🤪',
                              '🤨',
                              '🧐',
                              '🤓',
                              '😎',
                              '🥸',
                              '🤩',
                              '🥳',
                              '😏',
                              '😒',
                              '😞',
                              '😔',
                              '😟',
                              '😕',
                              '🙁',
                              '☹️',
                              '😣',
                              '😖',
                              '😫',
                              '😩',
                              '🥺',
                              '😢',
                              '😭',
                              '😤',
                              '😠',
                            ][index % 50],
                          ),
                      child: Center(
                        child: Text(
                          [
                            '😀',
                            '😃',
                            '😄',
                            '😁',
                            '😆',
                            '😅',
                            '😂',
                            '🤣',
                            '🥲',
                            '😊',
                            '😇',
                            '🙂',
                            '🙃',
                            '😉',
                            '😌',
                            '😍',
                            '🥰',
                            '😘',
                            '😗',
                            '😙',
                            '😚',
                            '😋',
                            '😛',
                            '😝',
                            '😜',
                            '🤪',
                            '🤨',
                            '🧐',
                            '🤓',
                            '😎',
                            '🥸',
                            '🤩',
                            '🥳',
                            '😏',
                            '😒',
                            '😞',
                            '😔',
                            '😟',
                            '😕',
                            '🙁',
                            '☹️',
                            '😣',
                            '😖',
                            '😫',
                            '😩',
                            '🥺',
                            '😢',
                            '😭',
                            '😤',
                            '😠',
                          ][index % 50],
                          style: TextStyle(fontSize: 24.sp),
                        ),
                      ),
                    );
                  },
                ),
              )
              : const SizedBox.shrink(),
    );
  }

  // 话题选择器
  Widget _buildTopicSelector() {
    return Obx(
      () =>
          controller.showTopics.value
              ? Container(
                height: 250.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: TextField(
                        controller: controller.topicSearchController,
                        decoration: InputDecoration(
                          hintText: '搜索话题',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: controller.filteredTopics.length,
                        separatorBuilder:
                            (context, index) => Divider(height: 1),
                        itemBuilder: (context, index) {
                          final topic = controller.filteredTopics[index];
                          return ListTile(
                            title: Text('#$topic'),
                            subtitle: Text('${1000 + index * 123}人参与'),
                            trailing: Icon(Icons.add),
                            onTap: () => controller.addTopic(topic),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
              : const SizedBox.shrink(),
    );
  }

  // 位置选择
  Widget _buildLocationSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, color: Colors.grey[700]),
          SizedBox(width: 8.w),
          Text(
            controller.location.value.isEmpty
                ? '添加位置'
                : controller.location.value,
            style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
          ),
          const Spacer(),
          if (controller.location.value.isNotEmpty)
            GestureDetector(
              onTap: controller.clearLocation,
              child: Icon(Icons.close, color: Colors.grey),
            )
          else
            Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
        ],
      ),
    );
  }

  // 可见范围选择
  Widget _buildVisibilitySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Icon(Icons.visibility_outlined, color: Colors.grey[700]),
          SizedBox(width: 8.w),
          Text(
            '谁可以看',
            style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
          ),
          const Spacer(),
          Text(
            controller.visibilityText,
            style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
        ],
      ),
    );
  }

  // 主视图
  Widget _buildView() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextInput(),
                _buildImagePreview(),
                _buildSelectedTopics(),
                const Divider(),
                _buildLocationSelector(),
                const Divider(),
                _buildVisibilitySelector(),
              ],
            ),
          ),
        ),
        _buildEmojiPicker(),
        _buildTopicSelector(),
        _buildToolbar(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoneCreateController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('发布动态'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0.5,
            actions: [
              TextButton(
                onPressed: controller.canPost ? controller.postMoment : null,
                child: Text(
                  '发布',
                  style: TextStyle(
                    color: controller.canPost ? Colors.teal : Colors.grey,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
          body: _buildView(),
        );
      },
    );
  }
}
