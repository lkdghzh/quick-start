import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/messages_controller.dart';
import '../../widgets/base_layout.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      body: RefreshIndicator(
        onRefresh: controller.refreshMessages,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.messages.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.message),
                  title: Text(controller.messages[index]),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
