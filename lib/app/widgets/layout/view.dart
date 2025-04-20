import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;

  const BaseLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();

    return Scaffold(
      body: body,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navigationController.selectedIndex.value,
          onTap: navigationController.changePage,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
              label: '对我心动',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
          ],
        ),
      ),
    );
  }
}
