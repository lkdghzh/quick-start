import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/favorate/bindings/favorate_binding.dart';
import '../modules/favorate/views/favorate.dart';
import '../modules/test/bindings/messages_binding.dart';
import '../modules/profile/binding.dart';
import '../modules/home/home_view.dart';
import '../modules/test/messages_view.dart';
import '../modules/profile/view.dart';
import '../modules/message/views/chats.dart';
import '../modules/message/views/chat.dart';
import '../modules/message/bindings/chat_binding.dart';
import '../modules/user/bindings.dart';
import '../modules/user/view.dart';

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
      name: Routes.FAVORATE,
      page: () => const FavorateView(),
      binding: StarsBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: Routes.USER,
      page: () => const UserPage(),
      binding: UserBinding(),
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
      page: () => const ChatsView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.CHAT_DETAIL,
      page: () => const ChatDetailView(),
      binding: ChatDetailBinding(),
    ),
  ];
}
