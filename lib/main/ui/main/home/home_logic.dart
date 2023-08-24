import 'dart:async';
import 'dart:io';

import 'package:bitel_ventas/main/services/settings_service.dart';
import 'package:bitel_ventas/main/ui/main/main_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../networks/api_end_point.dart';
import '../../../networks/api_util.dart';
import '../../../services/connection_service.dart';
import '../../../utils/common_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeLogic extends GetxController {
  MainLogic mainLogic = Get.find<MainLogic>();
  SettingService settingService = Get.find();
  final controllerPage = PageController(viewportFraction: 0.9, keepPage: true);

  BuildContext context;

  HomeLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    checkVersionApp(context);
  }

  void openDrawer() {
    mainLogic.openDrawer();
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
                context, AppLocalizations.of(context)!.textUpdateVersionApp,
                () {
              LaunchReview.launch(androidAppId: "com.bitel.bss.ringme.v1");
            });
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
