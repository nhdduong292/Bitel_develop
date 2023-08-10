import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../networks/api_end_point.dart';
import '../../networks/api_util.dart';
import '../../services/connection_service.dart';
import '../../utils/common.dart';
import '../../utils/common_widgets.dart';

class MainLogic extends GetxController {
  var index = 0.obs;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.onInit();
  }

  void openDrawer() {
    scaffoldKey!.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey!.currentState!.openEndDrawer();
  }

  void setIndex(int index) {
    this.index.value = index;
    update();
  }
}
