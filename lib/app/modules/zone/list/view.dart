import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woome/app/widgets/layout/view.dart';

import '../../../widgets/image.dart';
import 'controller.dart';

class ZonePage extends GetView<ZoneListController> {
  const ZonePage({super.key});

  // 顶部标签栏
  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10.w),
          Container(
            child: Text(
              '关注',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            child: Text(
              '推荐',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined, color: Colors.black87),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(2.r),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14.r,
                      minHeight: 14.r,
                    ),
                    child: Text(
                      '2',
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // 朋友圈动态列表
  Widget _buildPostList() {
    return Obx(
      () => ListView.builder(
        itemCount: controller.posts.length,
        itemBuilder: (context, index) {
          final post = controller.posts[index];
          return _buildPostItem(
            id: post['id'] ?? '',
            username: post['username'] ?? '',
            avatar: post['avatar'] ?? '',
            timeAgo: post['timeAgo'] ?? '',
            content: post['content'] ?? '',
            imageUrls: List<String>.from(post['imageUrls'] ?? []),
            likes: post['likes'] ?? 0,
            comments: post['comments'] ?? 0,
          );
        },
      ),
    );
  }

  // 单个动态
  Widget _buildPostItem({
    required String username,
    required String avatar,
    required String timeAgo,
    required String content,
    required List<String> imageUrls,
    required int likes,
    required int comments,
    String id = '',
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 头像
              ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: Image.network(
                  avatar,
                  width: 50.w,
                  height: 50.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              // 用户名和时间
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      timeAgo,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // 关注按钮
              IconButton(
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.black87,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ],
          ),
          // 内容 - 点击进入详情页
          GestureDetector(
            onTap: () {
              print('点击了');
              controller.goToDetail({
                'id': id,
                'username': username,
                'avatar': avatar,
                'timeAgo': timeAgo,
                'content': content,
                'imageUrls': imageUrls,
                'likes': likes,
                'comments': comments,
              });
            },
            child: Padding(
              padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
              child: Text(content, style: TextStyle(fontSize: 15.sp)),
            ),
          ),
          // 图片 - 可点击进入详情页
          if (imageUrls.isNotEmpty)
            GestureDetector(
              onTap:
                  () => controller.goToDetail({
                    'id': id,
                    'username': username,
                    'avatar': avatar,
                    'timeAgo': timeAgo,
                    'content': content,
                    'imageUrls': imageUrls,
                    'likes': likes,
                    'comments': comments,
                  }),
              child: Container(
                margin: EdgeInsets.only(bottom: 12.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                    imageUrl: imageUrls[0],
                    height: 300.h,
                    width: 200.w,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) =>
                            Container(color: Colors.grey[300], height: 200.h),
                    errorWidget:
                        (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: Icon(Icons.error, color: Colors.grey[400]),
                        ),
                  ),
                ),
              ),
            ),
          // 互动区域
          Row(
            children: [
              Spacer(),
              _buildInteractionButton(
                icon: Icons.favorite,
                label: likes.toString(),
                color: Colors.redAccent,
                onTap: () => controller.likePost(id),
              ),
              SizedBox(width: 16.w),
              _buildInteractionButton(
                icon: Icons.comment_outlined,
                label: comments.toString(),
                color: Colors.grey,
                onTap:
                    () => controller.goToDetail({
                      'id': id,
                      'username': username,
                      'avatar': avatar,
                      'timeAgo': timeAgo,
                      'content': content,
                      'imageUrls': imageUrls,
                      'likes': likes,
                      'comments': comments,
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 互动按钮
  Widget _buildInteractionButton({
    required IconData icon,
    String? label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(width: 4.w),
          label != null && label.isNotEmpty
              ? Text(label, style: TextStyle(color: color, fontSize: 12.sp))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  // 主视图
  Widget _buildView() {
    return Column(children: [_buildTabs(), Expanded(child: _buildPostList())]);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoneListController>(
      builder: (_) {
        return BaseLayout(title: '', body: SafeArea(child: _buildView()));
      },
    );
  }
}
