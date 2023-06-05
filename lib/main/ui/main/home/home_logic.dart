import 'dart:async';

import 'package:bitel_ventas/main/services/settings_service.dart';
import 'package:bitel_ventas/main/ui/main/main_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  MainLogic mainLogic = Get.find<MainLogic>();
  SettingService settingService = Get.find();
  final controllerPage = PageController(viewportFraction: 0.9, keepPage: true);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void openDrawer() {
    mainLogic.openDrawer();
  }
}
