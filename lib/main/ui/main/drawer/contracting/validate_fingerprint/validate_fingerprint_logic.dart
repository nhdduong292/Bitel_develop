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
  int cusId = 0;
  int contractId = 0;
  String typeCustomer = '';
  String idNumber = '';
  BestFingerModel bestFinger = BestFingerModel();
  List<String> imageBase64 = [];

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
  }

  void setCapture(String value) {
    textCapture = value;
    print("text Capture: $textCapture");
    update();
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
    if(imageBase64.isNotEmpty) {
      imageBase64.clear();
    }
    imageBase64.add(result);
    update();
    // setCapture(result);
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

  void signContract(Function(bool) isSuccess) {
    Completer<bool> completer = Completer();
    Map<String, dynamic> body = {
      "finger": bestFinger.right ?? bestFinger.left,
      "listImage": imageBase64
    };
    Map<String, dynamic> params = {"type": type};
    ApiUtil.getInstance()!.put(
      url: ApiEndPoints.API_SIGN_CONTRACT
          .replaceAll('id', contractId.toString()),
      body: body,
      params: params,
      onSuccess: (response) {
        if (response.isSuccess) {
          isSuccess.call(true);
        } else {
          isSuccess.call(false);
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        isSuccess.call(false);
      },
    );
    // return completer.future;
  }
}
