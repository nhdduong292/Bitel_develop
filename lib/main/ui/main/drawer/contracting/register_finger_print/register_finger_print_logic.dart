import 'dart:async';

import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';

class RegisterFingerPrintLogic extends GetxController {
  late BuildContext context;

  var handValue = (1).obs;
  var fingerValue = (1).obs;
  var pathFinger = AppImages.imgFingerLeft1.obs;
  int customerId = 0;

  String findPathFinger() {
    if (handValue.value == 1) {
      if (fingerValue.value == 1) {
        return AppImages.imgFingerLeft1;
      } else if (fingerValue.value == 2) {
        return AppImages.imgFingerLeft2;
      } else if (fingerValue.value == 3) {
        return AppImages.imgFingerLeft3;
      } else if (fingerValue.value == 4) {
        return AppImages.imgFingerLeft4;
      } else {
        return AppImages.imgFingerLeft5;
      }
    } else {
      if (fingerValue.value == 1) {
        return AppImages.imgFingerRight1;
      } else if (fingerValue.value == 1) {
        return AppImages.imgFingerRight2;
      } else if (fingerValue.value == 2) {
        return AppImages.imgFingerRight3;
      } else if (fingerValue.value == 3) {
        return AppImages.imgFingerRight3;
      } else if (fingerValue.value == 4) {
        return AppImages.imgFingerRight4;
      } else {
        return AppImages.imgFingerRight5;
      }
    }
  }

  Future<bool> registerFinger() async {
    Completer<bool> completer = Completer();
    Map<String, dynamic> body = {
      "left": 0,
      "leftImage": ["string"],
      "right": 0,
      "rightImage": ["string"]
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
}
