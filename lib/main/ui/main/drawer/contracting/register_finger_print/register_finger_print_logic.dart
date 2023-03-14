import 'dart:async';

import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/client_data/client_data_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import '../../../../../utils/common_widgets.dart';
import '../../manage_contact/create/cretate_contact_page_logic.dart';
import '../../manage_contact/create/view_item/client_data/id_card_scanner_logic.dart';

class RegisterFingerPrintLogic extends GetxController {
  late BuildContext context;

  RegisterFingerPrintLogic({required this.context});

  var handValue = (1).obs;
  var fingerValue = (1).obs;
  var pathFinger = AppImages.imgFingerLeft1.obs;
  int indexLeft = 0;
  List<String> listImageLeft = [];
  int indexRight = 0;
  var countFinger = 3.obs;
  List<String> listImageRight = [];
  CustomerModel customerModel = CustomerModel();
  String testFinger = '';
  CreateContactPageLogic logicCreateContact = Get.find();
  int requestId = 0;
  int productId = 0;
  int reasonId = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestId = logicCreateContact.requestId;
    productId = logicCreateContact.productId;
    reasonId = logicCreateContact.reasonId;
  }

  String findPathFinger() {
    if (handValue.value == 1) {
      //todo trai
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
    } else {
      //todo phai
      indexLeft = 0;
      if (fingerValue.value == 1) {
        indexRight = 1;
        return AppImages.imgFingerRight1;
      } else if (fingerValue.value == 2) {
        indexRight = 2;
        return AppImages.imgFingerRight2;
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

  void setupCustomer() {
    ClientDataLogic clientDataLogic = Get.find();
    customerModel = clientDataLogic.customer;
  }

  Future<bool> registerFinger() async {
    _onLoading(context);
    Completer<bool> completer = Completer();
    Map<String, dynamic> body = {
      "left": indexLeft,
      "leftImage": listImageLeft,
      "right": indexRight,
      "rightImage": listImageRight
    };

    ApiUtil.getInstance()!.put(
      url: ApiEndPoints.API_REGISTER_FINGER
          .replaceAll('id', customerModel.custId.toString()),
      body: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          completer.complete(true);
        } else {
          completer.complete(false);
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        Get.back();
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
    if (result.isNotEmpty) {
      if (indexLeft > 0) {
        listImageLeft.add(result);
        countFinger.value--;
        Common.showToastCenter(
            "Bạn đã lấy thành công lần ${listImageLeft.length}");
      } else {
        listImageRight.add(result);
        countFinger.value--;
        Common.showToastCenter(
            "Bạn đã lấy thành công lần ${listImageRight.length}");
      }
    } else {
      Common.showToastCenter("Lấy vân tay không thành công");
    }

    update();
  }

  void setIndexLeft(int value) {
    indexLeft = value;
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
