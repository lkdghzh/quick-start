import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ZoneDetailPage extends GetView<ZoneDetailController> {
  const ZoneDetailPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoneDetailController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("detail")),
          body: SafeArea(child: _buildView()),
        );
      },
    );
  }
}
