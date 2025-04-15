import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/base_layout.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(body: HomeContent());
  }
}

class HomeContent extends GetView<HomeController> {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(width: 300, height: 300, color: Colors.green),
          Container(width: 200, height: 200, color: Colors.red[100]),
          Positioned(
            left: 50,
            top: 50,
            child: Container(width: 200, height: 200, color: Colors.blue[100]),
          ),
        ],
      ),
    );
  }
}
