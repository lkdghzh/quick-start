import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/base_layout.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      body: HomeContent(),
    );
  }
}

class HomeContent extends GetView<HomeController> {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.home, size: 100),
          const SizedBox(height: 16),
          Obx(() => Text(
                controller.welcomeMessage.value,
                style: Theme.of(context).textTheme.headlineMedium,
              )),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: controller.updateWelcomeMessage,
            child: const Text('点击我'),
          ),
        ],
      ),
    );
  }
}
