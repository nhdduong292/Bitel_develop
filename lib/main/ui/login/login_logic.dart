import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/login/login_page.dart';
import 'package:bitel_ventas/main/ui/main/home/home_page.dart';
import 'package:bitel_ventas/main/ui/main/main_page.dart';
import 'package:bitel_ventas/main/utils/shared_preference.dart';
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
  var isShowPass = true.obs;
  bool isRememberAccount = false;

  @override
  void onInit() async{
    // TODO: implement onInit
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
    isRememberAccount = await SharedPreferenceUtil.isRememberAccount();
    if(isRememberAccount){
      controllerUser.text = await SharedPreferenceUtil.getUserName();
      controllerPass.text = await SharedPreferenceUtil.getUserName();
    }
    update();
    super.onInit();
  }

  void setRememberAccount(bool value){
    isRememberAccount = value;
    update();
  }

  void setShowPass(bool value){
    isShowPass.value = value;
    update();
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
    //todo luu pass vào shareprerence
    if(isRememberAccount){
      SharedPreferenceUtil.saveRememberAccount(isRememberAccount);
      SharedPreferenceUtil.saveUserName(controllerUser.text.trim());
      SharedPreferenceUtil.savePassWord(controllerPass.text.trim());
    }
    Get.offAllNamed(RouteConfig.main);
  }
}