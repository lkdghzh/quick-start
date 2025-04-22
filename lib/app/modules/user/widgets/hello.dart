import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

/// hello
class HelloWidget extends GetView<UserController> {
  const HelloWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Obx(() => Text(controller.state.title)));
  }
}
