import 'dart:async';
import 'dart:convert';

import 'package:bitel_ventas/main/networks/model/best_finger_model.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../res/app_images.dart';
import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValidateFingerprintLogic extends GetxController {
  late BuildContext context;
  String textCapture = "";
  String type = '';
  int cusId = 0;
  int contractId = 0;
  String typeCustomer = '';
  String idNumber = '';
  String email = '';
  BestFingerModel bestFinger = BestFingerModel();
  var pathFinger = ''.obs;
  List<String> listFinger = [];

  bool isGetFingerSuccess = false;
  String pk = "";

  ValidateFingerprintLogic(this.context);

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
    email = data[5];
  }

  void setCapture(String value) {
    textCapture = value;
    print("text Capture: $textCapture");
    update();
  }

  Future<void> getCapture(BuildContext context) async {
    textCapture = "";
    String result = "";
    try {
      // final argument = {"pk": "0"};
      final value =
          await NativeUtil.platformFinger.invokeMethod(NativeUtil.nameFinger);
      result = value;
    } on PlatformException catch (e) {
      e.printInfo();
      return;
    }
    print("text Capture: ${result}");
    try {
      final body = json.decode(result);
      textCapture = body["pathImage"];
      String imageBase64 = body["imageBase64"];
      // pk = body["pk"];

      if (listFinger.isNotEmpty) {
        listFinger.clear();
      }
      if (imageBase64.isNotEmpty) {
        listFinger.add(imageBase64);
      }
      if (listFinger.isNotEmpty) {
        Common.showToastCenter(
            AppLocalizations.of(context)!.textCaptureFingerprintSuccessfully);
      } else {
        Common.showToastCenter(
            AppLocalizations.of(context)!.textNotifyFingerFail);
      }
      update();
    } catch (e) {
      Common.showToastCenter(e.toString());
    }
  }

  void getBestFinger() {
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_BEST_FINGER.replaceAll('id', cusId.toString()),
      onSuccess: (response) {
        if (response.isSuccess) {
          bestFinger = BestFingerModel.fromJson(response.data['data']);
          pathFinger.value = findPathFinger();
          isGetFingerSuccess = true;
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        Common.showMessageError(error, context);
      },
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
      } else if (bestFinger.left == 9) {
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

  void signContract(Function(bool) isSuccess) {
    try {
      _onLoading(context);
      Completer<bool> completer = Completer();
      Map<String, dynamic> body = {
        // "finger": bestFinger.right ?? bestFinger.left,
        "finger": 6,
        "listImage": listFinger
      };
      Map<String, dynamic> params = {"type": type};
      ApiUtil.getInstance()!.put(
        url: ApiEndPoints.API_SIGN_CONTRACT
            .replaceAll('id', contractId.toString()),
        body: body,
        params: params,
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            isSuccess.call(true);
          } else {
            isSuccess.call(false);
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          Get.back();
          isSuccess.call(false);
          Common.showMessageError(error, context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString());
    }
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
