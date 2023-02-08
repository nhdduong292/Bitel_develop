import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/login/login_page.dart';
import 'package:bitel_ventas/main/ui/main/home/home_page.dart';
import 'package:bitel_ventas/main/ui/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginLogic extends GetxController{
  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  void onInit() {
    // TODO: implement onInit
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   focusNode.requestFocus();
    // });
    super.onInit();
  }
  void loginSuccess(){
    Get.offAllNamed(RouteConfig.main);
  }
}