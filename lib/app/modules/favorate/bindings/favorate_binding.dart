import 'package:get/get.dart';
import '../controllers/favorate_controller.dart';
// import '../controllers/star_controller.dart';

class StarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavorateController>(() => FavorateController());
  }
}

// class ChatDetailBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<ChatDetailController>(() => ChatDetailController());
//   }
// }
