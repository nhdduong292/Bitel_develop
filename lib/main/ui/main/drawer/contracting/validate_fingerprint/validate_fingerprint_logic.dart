import 'dart:async';

import 'package:bitel_ventas/main/networks/model/best_finger_model.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';

class ValidateFingerprintLogic extends GetxController {
  late BuildContext context;
  String textCapture = "";
  String type = '';
  int cusId = -1;
  String typeCustomer = '';
  String idNumber = '';
  BestFingerModel bestFinger = BestFingerModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    type = data[0];
    cusId = data[1];
    typeCustomer = data[2];
    idNumber = data[3];
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
      url: ApiEndPoints.API_CUSTOMER.replaceAll('id', cusId.toString()),
      onSuccess: (response) {
        if (response.isSuccess) {
          bestFinger = BestFingerModel.fromJson(response.data['data']);
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }

  Future<bool> signContract() async {
    Completer<bool> completer = Completer();
    Map<String, dynamic> body = {
      "finger": bestFinger.right ?? bestFinger.left,
      "listImage": []
    };
    Map<String, dynamic> params = {"type": type};
    ApiUtil.getInstance()!.put(
      url: ApiEndPoints.API_SIGN_CONTRACT.replaceAll('id', cusId.toString()),
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
