import 'package:get/get.dart';
import '../bindings/home_binding.dart';
import '../bindings/messages_binding.dart';
import '../bindings/profile_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/messages/messages_view.dart';
import '../modules/profile/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: Routes.MESSAGES,
      page: () => const MessagesView(),
      binding: MessagesBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fade,
    ),
  ];
}
