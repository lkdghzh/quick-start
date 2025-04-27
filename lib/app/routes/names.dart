part of 'routes.dart';

abstract class Routes {
  Routes._();
  static const HOME = '/home';
  static const FAVORATE = '/favorate';
  static const USER = '/user';

  static const Zone_LIST = '/zone/list';
  static const ZONE_DETAIL = '/zone/detail'; // todo 和user整合
  static const ZONE_CREATE = '/zone/create';

  static const CHAT_LIST = '/chat/list';
  static const CHAT_DETAIL = '/chat/detail';

  static const PROFILE = '/profile';

  static const MESSAGES = '/messages';
}
