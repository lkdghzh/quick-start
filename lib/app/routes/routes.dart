import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/messages/bindings/messages_binding.dart';
import '../modules/profile/binding.dart';
import '../modules/home/home_view.dart';
import '../modules/messages/messages_view.dart';
import '../modules/profile/view.dart';
import '../modules/chat/views/chat_list_view.dart';
import '../modules/chat/views/chat_detail_view.dart';
import '../modules/chat/bindings/chat_binding.dart';

part 'names.dart';

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
    GetPage(
      name: Routes.CHAT_LIST,
      page: () => const ChatListView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.CHAT_DETAIL,
      page: () => const ChatDetailView(),
      binding: ChatDetailBinding(),
    ),
  ];
}
