import 'dart:async';

import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';

class RegisterFingerPrintLogic extends GetxController {
  late BuildContext context;

  var handValue = (1).obs;
  var fingerValue = (1).obs;
  var pathFinger = AppImages.imgFingerLeft1.obs;
  int customerId = 0;
  int indexLeft = 0;
  List<String> listImageLeft= [];
  int indexRight = 0;
  List<String> listImageRight = [];

  String findPathFinger() {
    if (handValue.value == 1) { //todo trai
      indexRight = 0;
      if (fingerValue.value == 1) {
        indexLeft = 6;
        return AppImages.imgFingerLeft1;
      } else if (fingerValue.value == 2) {
        indexLeft = 7;
        return AppImages.imgFingerLeft2;
      } else if (fingerValue.value == 3) {
        indexLeft = 8;
        return AppImages.imgFingerLeft3;
      } else if (fingerValue.value == 4) {
        indexLeft = 9;
        return AppImages.imgFingerLeft4;
      } else {
        indexLeft = 10;
        return AppImages.imgFingerLeft5;
      }

    } else { //todo phai
      indexLeft = 0;
     if (fingerValue.value == 1) {
        indexRight = 1;
        return AppImages.imgFingerRight2;
      } else if (fingerValue.value == 2) {
        indexRight = 2;
        return AppImages.imgFingerRight3;
      } else if (fingerValue.value == 3) {
        indexRight = 3;
        return AppImages.imgFingerRight3;
      } else if (fingerValue.value == 4) {
        indexRight = 4;
        return AppImages.imgFingerRight4;
      } else {
        indexRight = 5;
        return AppImages.imgFingerRight5;
      }
    }
  }

  Future<bool> registerFinger() async {
    Completer<bool> completer = Completer();
    Map<String, dynamic> body = {
      "left": indexLeft,
      "leftImage": listImageLeft,
      "right": indexRight,
      "rightImage": listImageRight
    };

    ApiUtil.getInstance()!.put(
      url: ApiEndPoints.API_REGISTER_FINGER
          .replaceAll('id', customerId.toString()),
      body: body,
      onSuccess: (response) {
        if (response.isSuccess) {
          completer.complete(true);
        } else {
          completer.complete(false);
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        completer.complete(false);
      },
    );
    return completer.future;
  }

  Future<void> getCapture() async {
    String result = "";
    try {
      final value =
      await NativeUtil.platformFinger.invokeMethod(NativeUtil.nameFinger);
      result = value;
    } on PlatformException catch (e) {
      e.printInfo();
    }

    if(indexLeft > 0) {
      listImageLeft.add(result);
      Common.showToastCenter("Bạn đã lấy thành công lần ${listImageLeft.length}");
    }
    else {
      listImageRight.add(result);
      Common.showToastCenter("Bạn đã lấy thành công lần ${listImageRight.length}");
    }
    update();
  }

  void setIndexLeft(int value){
    indexLeft = value;
  }
}
