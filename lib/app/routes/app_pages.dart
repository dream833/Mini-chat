import 'package:get/get.dart';

import '../modules/Call/bindings/call_binding.dart';
import '../modules/Call/views/call_view.dart';
import '../modules/Chat/bindings/chat_binding.dart';
import '../modules/Chat/views/chat_view.dart';
import '../modules/ChatDetails/bindings/chat_details_binding.dart';
import '../modules/ChatDetails/views/chat_details_view.dart';
import '../modules/ContactsPage/bindings/contacts_page_binding.dart';
import '../modules/ContactsPage/views/contacts_page_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/UserSettingsPage/bindings/user_settings_page_binding.dart';
import '../modules/UserSettingsPage/views/user_settings_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_DETAILS,
      page: () => const ChatDetailsView(),
      binding: ChatDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CALL,
      page: () => const CallView(),
      binding: CallBinding(),
    ),
    GetPage(
      name: _Paths.USER_SETTINGS_PAGE,
      page: () => const UserSettingsPageView(),
      binding: UserSettingsPageBinding(),
    ),
    GetPage(
      name: _Paths.CONTACTS_PAGE,
      page: () => const ContactsPageView(),
      binding: ContactsPageBinding(),
    ),
  ];
}
