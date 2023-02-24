import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/login/login_page.dart';
import 'package:bitel_ventas/main/ui/main/home/home_page.dart';
import 'package:bitel_ventas/main/ui/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginLogic extends GetxController{
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  FocusNode focusUser = FocusNode();
  FocusNode focusPass = FocusNode();
  bool isSubmitPass = false;
  bool isSubmitUser = false;

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

  void setStateUser(bool value){
    isSubmitUser = value;
    update();
  }
  void setStatePass(bool value){
    isSubmitPass = value;
    update();
  }

  void loginSuccess(){
    if(controllerUser.value.text.isEmpty){
      setStateUser(true);
      focusUser.requestFocus();
      return;
    }
    if(controllerPass.value.text.isEmpty) {
      setStatePass(true);
      focusPass.requestFocus();
      return;
    }
    Get.offAllNamed(RouteConfig.main);
  }
}