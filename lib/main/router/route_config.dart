import 'dart:ui';

import 'package:bitel_ventas/main/ui/login/login_binding.dart';
import 'package:bitel_ventas/main/ui/login/login_page.dart';
import 'package:bitel_ventas/main/ui/main/main_binding.dart';
import 'package:get/get.dart';

import '../ui/main/main_page.dart';

class RouteConfig {
  ///name page
  static const String login = "/login";
  static const String main = "/main";

  ///page
  static final List<GetPage> getPages = [
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: main, page: () => MainPage(), binding: MainBinding()),
  ];

  ///language
  static final List<Locale> listLanguage = [
    Locale('en', ''), // English, no country code
    Locale('vi', ''), // vn, no country code
    Locale('es', ''), // TBN, no country code
  ];
}
