import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import '../../widgets/layout/view.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: '我的',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 100),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Obx(
                        () => ListTile(
                          title: const Text('用户名'),
                          subtitle: Text(controller.username.value),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed:
                                () => controller.updateProfile(
                                  newUsername: '新用户名',
                                ),
                          ),
                        ),
                      ),
                      const Divider(),
                      Obx(
                        () => ListTile(
                          title: const Text('邮箱'),
                          subtitle: Text(controller.email.value),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed:
                                () => controller.updateProfile(
                                  newEmail: 'new@email.com',
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => SwitchListTile(
                  title: const Text('暗黑模式'),
                  value: controller.isDarkMode.value,
                  onChanged: (_) => controller.toggleTheme(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
