import 'dart:ui';

import 'package:bitel_ventas/main/ui/login/login_binding.dart';
import 'package:bitel_ventas/main/ui/login/login_page.dart';
import 'package:bitel_ventas/main/ui/main/main_binding.dart';
import 'package:bitel_ventas/main/ui/main/setting/my_info/my_info_page.dart';
import 'package:bitel_ventas/main/ui/main/setting/sync_data/sync_data_page.dart';
import 'package:get/get.dart';

import '../ui/main/main_page.dart';
import '../ui/main/setting/regiester_finger/register_finger_page.dart';

class RouteConfig {
  ///name page
  static const String login = "/login";
  static const String main = "/main";
  static const String myInfo = "/setting/myInfo";
  static const String syncData = "/setting/syncData";
  static const String registerFinger = "/setting/registerFinger";

  ///page
  static final List<GetPage> getPages = [
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: main, page: () => MainPage(), binding: MainBinding()),
    GetPage(name: myInfo, page: () => MyInfoPage()),
    GetPage(name: syncData, page: () => SyncDataPage()),
    GetPage(name: registerFinger, page: () => RegisterFingerPage()),
  ];

  ///language
  static final List<Locale> listLanguage = [
    Locale('en', ''), // English, no country code
    Locale('vi', ''), // vn, no country code
    Locale('es', ''), // TBN, no country code
  ];
}
