import 'package:first_project_in_mac/presantation/auth/binding/auth_binding.dart';
import 'package:first_project_in_mac/presantation/auth/login_screen.dart';
import 'package:first_project_in_mac/presantation/auth/registration_page.dart';
import 'package:first_project_in_mac/presantation/home/binding/home_binding.dart';
import 'package:first_project_in_mac/presantation/home/chat/chat_screen.dart';
import 'package:first_project_in_mac/presantation/home/home_screen.dart';
import 'package:first_project_in_mac/presantation/setting/binding/setting_binding.dart';
import 'package:first_project_in_mac/presantation/setting/setting_screen.dart';
import 'package:get/get.dart';
part 'routes.dart';

class AppPages {
  AppPages._();

  static const HOME = Routes.HOME;
  static const CHAT = Routes.CHAT;
  static const LOGIN = Routes.LOGIN;
  static const REGISTER = Routes.REGISTER;
  static const SETTINGS = Routes.SETTINGS;

  static final routes = [
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegistrationPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
  ];
}
