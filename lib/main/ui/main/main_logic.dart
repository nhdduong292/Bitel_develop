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

  void checkVersionApp(BuildContext context) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    _onLoading(context);
    Map<String, dynamic> body = {
      "version": version,
    };
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CHECK_VERSION_APP,
      params: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          bool needUpdate = response.data['needUpdate'];
          if (needUpdate) {
            Common.showSystemErrorLoginDialog(
                context, "ban can update phien ban moi", () {});
          }
        } else {}
      },
      onError: (error) {
        Get.back();
        // isSuccess(false);
        Common.showMessageError(error: error, context: context);
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
