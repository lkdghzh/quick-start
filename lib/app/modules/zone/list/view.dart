import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ZonePage extends GetView<ZoneListController> {
  const ZonePage({super.key});

  // 主视图
  Widget _buildView() {
    return const Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoneListController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("zone")),
          body: SafeArea(child: _buildView()),
        );
      },
    );
  }
}
