import 'package:get/get.dart';
import '../controllers/stars_controller.dart';
// import '../controllers/star_controller.dart';

class StarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StarsController>(() => StarsController());
  }
}

// class ChatDetailBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<ChatDetailController>(() => ChatDetailController());
//   }
// }
