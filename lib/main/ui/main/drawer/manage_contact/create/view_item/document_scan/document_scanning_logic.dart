import 'dart:io';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/request/google_detect_request.dart';
import 'package:bitel_ventas/main/networks/request/google_detect_request.dart';
import 'package:bitel_ventas/main/networks/request/google_detect_request.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../../networks/request/google_detect_request.dart';

class DocumentScanningLogic extends GetxController {
  late BuildContext context;
  var checkOption1 = true.obs;
  var checkOption2 = true.obs;
  String textPathScan = "";

  String currentIdentity = "DNI";
  List<String> listIdentityNumber = ["DNI", "CE", "PP", "PTP"];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onListenerMethod();
  }

  void onListenerMethod() {
    NativeUtil.platformScan1.setMethodCallHandler((call) async {
      if (call.method == NativeUtil.nameScan1) {
        String link = call.arguments;
        print("Linkkkkkkkkkkkkkkkkkkk 1111111: $link");
        textPathScan = link;
        update();
      }
    });
  }

  Future<void> getScan() async {
    String result = "";
    try {
      final String value =
          await NativeUtil.platformScan1.invokeMethod(NativeUtil.nameScan1);
      result = value;
    } on PlatformException catch (e) {
      e.printInfo();
    }
    print(result);
  }

  void setPathScan(String value){
    textPathScan = value;
    update();
  }

  void detectID(BuildContext context) async{
    _onLoading(context);
    Map<String, dynamic> body = {
      "requests": [
        {
          "image": "${Common.convertImageFileToBase64(File(textPathScan))}",
          "features": [
            {"type": "TEXT_DETECTION"}
          ]
        }
      ],
    };

    Map<String, dynamic> params = {"key": Values.KEY_GOOGLE_DETECT};
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_DETECT_ID,
      body: body,
      params: params,
      isDetect: true,
      onSuccess: (response) {
        Get.back();
      },
      onError: (error) {
        Get.back();
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
