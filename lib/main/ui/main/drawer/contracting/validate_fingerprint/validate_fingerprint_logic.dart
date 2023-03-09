import 'dart:async';

import 'package:bitel_ventas/main/networks/model/best_finger_model.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../res/app_images.dart';
import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';

class ValidateFingerprintLogic extends GetxController {
  late BuildContext context;
  String textCapture = "";
  String type = '';
  int cusId = 0;
  int contractId = 0;
  String typeCustomer = '';
  String idNumber = '';
  BestFingerModel bestFinger = BestFingerModel();
  var pathFinger = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    type = data[0];
    cusId = data[1];
    typeCustomer = data[2];
    idNumber = data[3];
    contractId = data[4];
    getBestFinger();
  }

  void setCapture(String value) {
    textCapture = value;
    print("text Capture: $textCapture");
    update();
  }

  Future<void> getCapture() async {
    String result = "";
    try {
      final String value =
          await NativeUtil.platformFinger.invokeMethod(NativeUtil.nameFinger);
      result = value;
    } on PlatformException catch (e) {
      e.printInfo();
    }

    setCapture(result);
  }

  void getBestFinger() {
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_BEST_FINGER.replaceAll('id', cusId.toString()),
      onSuccess: (response) {
        if (response.isSuccess) {
          bestFinger = BestFingerModel.fromJson(response.data['data']);
          pathFinger.value = findPathFinger();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }

  String findPathFinger() {
    if (bestFinger.left != 0) {
      if (bestFinger.left == 6) {
        return AppImages.imgFingerLeft1;
      } else if (bestFinger.left == 7) {
        return AppImages.imgFingerLeft2;
      } else if (bestFinger.left == 8) {
        return AppImages.imgFingerLeft3;
      } else if (bestFinger.left == 4) {
        return AppImages.imgFingerLeft4;
      } else {
        return AppImages.imgFingerLeft5;
      }
    } else {
      if (bestFinger.right == 1) {
        return AppImages.imgFingerRight1;
      } else if (bestFinger.right == 1) {
        return AppImages.imgFingerRight2;
      } else if (bestFinger.right == 3) {
        return AppImages.imgFingerRight3;
      } else if (bestFinger.right == 4) {
        return AppImages.imgFingerRight4;
      } else {
        return AppImages.imgFingerRight5;
      }
    }
  }

  Future<bool> signContract() async {
    Completer<bool> completer = Completer();
    Map<String, dynamic> body = {
      "finger": bestFinger.right ?? bestFinger.left,
      "listImage": []
    };
    Map<String, dynamic> params = {"type": type};
    ApiUtil.getInstance()!.put(
      url: ApiEndPoints.API_SIGN_CONTRACT
          .replaceAll('id', contractId.toString()),
      body: body,
      params: params,
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
