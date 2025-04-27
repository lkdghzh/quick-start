import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class BaseLayout extends GetView<NavigationController> {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  const BaseLayout({
    super.key,
    required this.body,
    required this.title,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    // final navigationController = Get.find<NavigationController>();

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surface,
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '广场'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
              label: '对我心动',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.zoom_in_outlined),
              activeIcon: Icon(Icons.zoom_in),
              label: '心情',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              activeIcon: Icon(Icons.message),
              label: '聊天',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
            // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'xx'),
            // BottomNavigationBarItem(icon: Icon(Icons.message), label: 'test'),
          ],
        ),
      ),
    );
  }

  AppBar? buildAppBar() {
    return title == ''
        ? null
        : AppBar(
          title: Text(
            title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
        );
  }
}
