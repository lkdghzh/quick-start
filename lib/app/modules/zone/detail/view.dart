import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'controller.dart';

class ZoneDetailPage extends GetView<ZoneDetailController> {
  const ZoneDetailPage({super.key});

  // 顶部帖子内容
  Widget _buildPostContent() {
    final Map<String, dynamic> post = Get.arguments as Map<String, dynamic>;

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
                  post['avatar'] ?? 'https://picsum.photos/200/200?random=1',
                  width: 50.w,
                  height: 50.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50.w,
                      height: 50.w,
                      color: Colors.grey[300],
                      child: Icon(Icons.person, color: Colors.grey[600]),
                    );
                  },
                ),
              ),
              SizedBox(width: 12.w),
              // 用户名和时间
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['username'] ?? '用户名',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      post['timeAgo'] ?? '刚刚',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // 关注按钮
              Container(
                height: 32.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.teal),
                ),
                child: Center(
                  child: Text(
                    '关注',
                    style: TextStyle(color: Colors.teal, fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),

          // 内容
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              post['content'] ?? '帖子内容',
              style: TextStyle(fontSize: 16.sp),
            ),
          ),

          // 图片
          if ((post['imageUrls'] as List<String>? ?? []).isNotEmpty)
            Container(
              margin: EdgeInsets.only(bottom: 16.h),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      (post['imageUrls'] as List).length == 1 ? 1 : 3,
                  mainAxisSpacing: 4.h,
                  crossAxisSpacing: 4.w,
                  childAspectRatio:
                      (post['imageUrls'] as List).length == 1 ? 1.5 : 1.0,
                ),
                itemCount: (post['imageUrls'] as List).length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      (post['imageUrls'] as List)[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[600],
                            size: 50.sp,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

          // 点赞和评论信息
          Row(
            children: [
              Text(
                '${post['likes'] ?? 0} 赞 · ${post['comments'] ?? 0} 评论',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
              Spacer(),
              Text(
                '${DateTime.now().toString().substring(0, 10)}',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),

          // Divider(height: 32.h, thickness: 0.5),
          SizedBox(height: 32.h),
          // 互动按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(Icons.favorite_border, '赞', () {}),
              _buildActionButton(Icons.comment_outlined, '评论', () {}),
              _buildActionButton(Icons.share_outlined, '分享', () {}),
            ],
          ),

          Divider(height: 32.h, thickness: 8, color: Colors.grey[100]),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: Colors.grey[700]),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  // 评论列表
  Widget _buildCommentList() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: ListView.separated(
          itemCount: 15, // 模拟15条评论
          separatorBuilder:
              (context, index) => Divider(height: 1, indent: 68.w),
          itemBuilder: (context, index) {
            return _buildCommentItem(
              username: '用户${index + 1}',
              avatar: 'https://picsum.photos/200/200?random=${index + 10}',
              content: '这是第${index + 1}条评论，评论内容可能很长很长很长很长很长很长很长很长很长很长很长很长',
              timeAgo: '${index * 5 + 1}分钟前',
              likes: index % 5 == 0 ? index + 3 : 0,
            );
          },
        ),
      ),
    );
  }

  Widget _buildCommentItem({
    required String username,
    required String avatar,
    required String content,
    required String timeAgo,
    required int likes,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.network(
              avatar,
              width: 40.w,
              height: 40.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 40.w,
                  height: 40.w,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    color: Colors.grey[600],
                    size: 20.sp,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 12.w),
          // 评论内容
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 用户名
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4.h),
                // 评论内容
                Text(content, style: TextStyle(fontSize: 14.sp)),
                SizedBox(height: 4.h),
                // 时间和点赞
                Row(
                  children: [
                    Text(
                      timeAgo,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      '回复',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    Spacer(),
                    if (likes > 0)
                      Text(
                        likes.toString(),
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 16.sp,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoneDetailController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('详情'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0.5,
          ),
          body: _buildView(),
        );
      },
    );
  }

  // 主视图
  Widget _buildView() {
    // 使用Expanded包裹可滚动内容
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPostContent(),
          Container(
            color: Colors.white,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 15, // 模拟15条评论
              separatorBuilder:
                  (context, index) => Divider(height: 1, indent: 68.w),
              itemBuilder: (context, index) {
                return _buildCommentItem(
                  username: '用户${index + 1}',
                  avatar: 'https://picsum.photos/200/200?random=${index + 10}',
                  content: '这是第${index + 1}条评论，评论内容可能很长很长很长很长很长很长很长很长很长很长很长很长',
                  timeAgo: '${index * 5 + 1}分钟前',
                  likes: index % 5 == 0 ? index + 3 : 0,
                );
              },
            ),
          ),
        ],
      ),
    );
    // 评论输入框固定在底部
    // _buildCommentInput(),
  }

  // 底部评论输入框
  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '说点什么...',
                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 10.h),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            icon: Icon(Icons.send, color: Colors.teal),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
