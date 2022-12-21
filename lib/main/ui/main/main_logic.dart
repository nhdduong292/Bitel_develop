import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainLogic extends GetxController {
  var index = 0.obs;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
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
