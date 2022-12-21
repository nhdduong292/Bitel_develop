import 'package:bitel_ventas/main/ui/main/home/home_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeLogic> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeLogic(),
      builder: (controller) {
        return Scaffold(
          body: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              controller.openDrawer();

            },
            color: Colors.red,
          ),

        );
      },
    );
  }
}
