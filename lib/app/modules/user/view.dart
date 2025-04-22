import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'widgets/widgets.dart';

class UserPage extends GetView<UserController> {
  const UserPage({super.key});

  // 主视图
  Widget _buildView() {
    return const HelloWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("user")),
          body: SafeArea(child: _buildView()),
        );
      },
    );
  }
}
