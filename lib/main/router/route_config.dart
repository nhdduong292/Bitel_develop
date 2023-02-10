import 'dart:ui';

import 'package:bitel_ventas/main/ui/login/login_binding.dart';
import 'package:bitel_ventas/main/ui/login/login_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/manage_wo/mange_wo_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/create_request_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_page.dart';
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
  static const String manageContact = "/menu/manageContact";
  static const String createRequest = "/menu/CreaetRequest";
  static const String listRequest = "/menu/ListRequest";
  static const String requestDetail = "/menu/RequestDetail";

  ///page
  static final List<GetPage> getPages = [
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: main, page: () => MainPage(), binding: MainBinding()),
    GetPage(name: myInfo, page: () => MyInfoPage()),
    GetPage(name: syncData, page: () => SyncDataPage()),
    GetPage(name: registerFinger, page: () => RegisterFingerPage()),
    GetPage(name: manageContact, page: () => ManageContactPage()),
    GetPage(name: createRequest, page: () => CreateRequestPage()),
    GetPage(name: listRequest, page: () => ListRequestPage()),
    GetPage(name: requestDetail, page: () => RequestDetailPage()),
  ];

  ///language
  static final List<Locale> listLanguage = [
    Locale('en', ''), // English, no country code
    Locale('vi', ''), // vn, no country code
    Locale('es', ''), // TBN, no country code
  ];
}
