import 'package:bitel_ventas/main/ui/main/drawer/drawer_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DrawerPage extends GetView<DrawerLogic>{
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DrawerLogic(),
      builder: (controller) {
      return Scaffold();
    },);
  }

}