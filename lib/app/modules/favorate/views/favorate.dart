import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/user.dart';
import '../../../widgets/layout/view.dart' show BaseLayout;
import '../../../widgets/image.dart';
import '../controllers/favorate_controller.dart';

class FavorateView extends GetView<FavorateController> {
  const FavorateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: '对我心动',
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final user = controller.users[index];
            return _buildUserCard(user, index);
          },
        ),
      ),
    );
  }

  Widget _buildUserCard(User user, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                index % 4 == 0
                    ? [Color(0xFFE6D5DC), Color(0xFFD5DCEE)]
                    : index % 4 == 1
                    ? [Color(0xFFD5DCEE), Color(0xFFF2F2E6)]
                    : index % 4 == 2
                    ? [Color(0xFFE6D5DC), Color(0xFFFFE6E6)]
                    : [Color(0xFFE6F2EC), Color(0xFFE6F2EC)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildAvatar(user),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserInfo(user),
                    const SizedBox(height: 8),
                    _buildUserDetails(user),
                    const SizedBox(height: 8),
                    _buildActionButtons(index),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(User user) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: ClipOval(
        child: CommonImage(imageUrl: user.avatar, width: 80, height: 80),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Row(
      children: [
        Text(
          user.name ?? '',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Text(user.job ?? '', style: TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _buildUserDetails(User user) {
    return Row(
      children: [
        Text(user.location ?? ''),
        const SizedBox(width: 16),
        Text(user.marriage ?? ''),
        const SizedBox(width: 16),
        Text(user.gender ?? ''),
        const SizedBox(width: 16),
        Text(user.age ?? ''),
      ],
    );
  }

  Widget _buildActionButtons(int index) {
    return Row(
      children: [
        TextButton(
          onPressed: () => controller.viewDetails(index),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text('详细资料'),
        ),
        const Spacer(),
        TextButton(
          onPressed: () => controller.sendGreeting(index),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text('打个招呼'),
        ),
      ],
    );
  }
}
