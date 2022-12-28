import 'package:bitel_ventas/main/ui/main/main_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController{
  MainLogic mainLogic = Get.find<MainLogic>();
  final controllerPage = PageController(viewportFraction: 0.9, keepPage: true);
  void openDrawer(){
    mainLogic.openDrawer();
  }
}