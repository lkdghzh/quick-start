import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'controller.dart';
import '../../widgets/image.dart';
import 'widgets/swipeable_card.dart';

class UserPage extends GetView<UserController> {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SwipeableCard(
      onLike: controller.handleLike,
      onDislike: () => Get.back(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserInfo(),
                  _buildBio(),
                  _buildInterests(),
                  _buildPhotoGallery(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300.h,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Obx(
          () => CommonImage(
            imageUrl: controller.state.avatar,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Obx(
                () => Text(
                  '${controller.state.name}，${controller.state.age}',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.verified, color: Colors.blue, size: 20.sp),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.work, size: 16.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Obx(() => Text(controller.state.job)),
              SizedBox(width: 16.w),
              Icon(Icons.location_on, size: 16.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Obx(() => Text(controller.state.location)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBio() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '关于我',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Obx(
            () => Text(
              controller.state.bio,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterests() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '兴趣爱好',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Obx(
            () => Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children:
                  controller.state.interests
                      .map(
                        (interest) => Chip(
                          label: Text(interest),
                          backgroundColor: Colors.pink[50],
                          labelStyle: TextStyle(color: Colors.pink),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGallery() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '照片墙',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Obx(
            () => GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.h,
                crossAxisSpacing: 8.w,
              ),
              itemCount: controller.state.photos.length,
              itemBuilder: (context, index) {
                return CommonImage(
                  imageUrl: controller.state.photos[index],
                  borderRadius: BorderRadius.circular(8.r),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: controller.handleLike,
            icon: Icon(Icons.favorite),
            label: Text('喜欢'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
            ),
          ),
          ElevatedButton.icon(
            onPressed: controller.handleChat,
            icon: Icon(Icons.chat_bubble),
            label: Text('聊天'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }
}
