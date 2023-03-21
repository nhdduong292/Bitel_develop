import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/login_model.dart';
import 'package:bitel_ventas/main/networks/model/user_model.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/login/login_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/utilitis/info_bussiness.dart';
import 'package:bitel_ventas/main/ui/main/home/home_page.dart';
import 'package:bitel_ventas/main/ui/main/main_page.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LoginLogic extends GetxController {
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  FocusNode focusUser = FocusNode();
  FocusNode focusPass = FocusNode();
  bool isSubmitPass = false;
  bool isSubmitUser = false;
  var isShowPass = true.obs;
  bool isRememberAccount = false;

  @override
  void onInit() async {
    // TODO: implement onInit
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    isRememberAccount = await SharedPreferenceUtil.isRememberAccount();
    if (isRememberAccount) {
      controllerUser.text = await SharedPreferenceUtil.getUserName();
      controllerPass.text = await SharedPreferenceUtil.getPassWord();
    }
    update();
    super.onInit();
  }

  void setRememberAccount(bool value) {
    isRememberAccount = value;
    update();
  }

  void setShowPass(bool value) {
    isShowPass.value = value;
    update();
  }

  void setStateUser(bool value) {
    isSubmitUser = value;
    update();
  }

  void setStatePass(bool value) {
    isSubmitPass = value;
    update();
  }

  void loginSuccess(BuildContext context) {
    if (controllerUser.value.text.isEmpty) {
      setStateUser(true);
      focusUser.requestFocus();
      return;
    }
    if (controllerPass.value.text.isEmpty) {
      setStatePass(true);
      focusPass.requestFocus();
      return;
    }
    //todo luu pass vào shareprerence
    if (isRememberAccount) {
      SharedPreferenceUtil.saveRememberAccount(isRememberAccount);
      SharedPreferenceUtil.saveUserName(controllerUser.text.trim());
      SharedPreferenceUtil.savePassWord(controllerPass.text.trim());
    }
    // Get.offAllNamed(RouteConfig.main);
    _onLoading(context);
    login(context);
  }

  void login(BuildContext context) async {
    SharedPreferenceUtil.saveToken("");
    Map<String, dynamic> body = {
      "username": controllerUser.text.trim(),
      "password": controllerPass.text.trim(),
      "domainCode": "BCCS_CC"
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_LOGIN,
      body: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          LoginModel loginModel = LoginModel.fromJson(response.data);
          Map<String, dynamic> payload = Jwt.parseJwt(loginModel.token);
          // Print the payload
          InfoBusiness.getInstance()!.setUser(UserModel.fromJson(payload));
          print(payload);
          SharedPreferenceUtil.saveToken(loginModel.token);
          SharedPreferenceUtil.saveRefreshToken(
              DateTime.now().millisecondsSinceEpoch);
          Get.offAllNamed(RouteConfig.main);
        } else {
          Common.showToastCenter(AppLocalizations.of(context)!.textErrorAPI);
        }
      },
      onError: (error) {
        Get.back();
        Common.showToastCenter(AppLocalizations.of(context)!.textErrorAPI);
      },
    );
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: LoadingCirculApi(),
        );
      },
    );
  }
}
