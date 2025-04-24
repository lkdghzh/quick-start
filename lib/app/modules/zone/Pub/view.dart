import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ZonePubPage extends GetView<ZonePubController> {
  const ZonePubPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZonePubController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("zonepub")),
          body: SafeArea(child: _buildView()),
        );
      },
    );
  }
}
