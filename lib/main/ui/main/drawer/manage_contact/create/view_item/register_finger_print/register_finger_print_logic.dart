import 'dart:async';
import 'dart:convert';

import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/client_data/client_data_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../../../../../../services/connection_service.dart';
import '../../../../../../../services/settings_service.dart';
import '../../../../../../../utils/common_widgets.dart';
import '../../cretate_contact_page_logic.dart';
import '../client_data/id_card_scanner_logic.dart';
import '../client_data_dni/client_data_dni_logic.dart';

class RegisterFingerPrintLogic extends GetxController {
  late BuildContext context;

  RegisterFingerPrintLogic({required this.context});

  var handValue = (1).obs;
  var fingerValue = (1).obs;
  var pathFinger = AppImages.imgFingerLeftThumb.obs;
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
  List<int> listPromotionId = [];
  int packageId = 0;
  bool isForcedTerm = false;
  Map<String, dynamic> body = {};

  String textCapture = "";
  List<String> listPathFinger = [];
  String currentPathFinger = "";
  String currentImageFinger = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestId = logicCreateContact.requestModel.id;
    productId = logicCreateContact.productId;
    reasonId = logicCreateContact.reasonId;
    isForcedTerm = logicCreateContact.isForcedTerm;
    listPromotionId = logicCreateContact.listPromotionId;
    packageId = logicCreateContact.packageId;

    findPathFinger();
  }

  String findPathFinger() {
    if (handValue.value == 1) {
      //todo trai
      indexRight = 0;
      if (fingerValue.value == 1) {
        indexLeft = 1;
        return AppImages.imgFingerLeftThumb;
      } else if (fingerValue.value == 2) {
        indexLeft = 2;
        return AppImages.imgFingerLeftIndex;
      } else if (fingerValue.value == 3) {
        indexLeft = 3;
        return AppImages.imgFingerLeftMiddle;
      } else if (fingerValue.value == 4) {
        indexLeft = 4;
        return AppImages.imgFingerLeftRing;
      } else {
        indexLeft = 5;
        return AppImages.imgFingerLeftLittle;
      }
    } else {
      //todo phai
      indexLeft = 0;
      if (fingerValue.value == 1) {
        indexRight = 10;
        return AppImages.imgFingerRightThumb;
      } else if (fingerValue.value == 2) {
        indexRight = 9;
        return AppImages.imgFingerRightIndex;
      } else if (fingerValue.value == 3) {
        indexRight = 8;
        return AppImages.imgFingerRightMiddle;
      } else if (fingerValue.value == 4) {
        indexRight = 7;
        return AppImages.imgFingerRightRing;
      } else {
        indexRight = 6;
        return AppImages.imgFingerRightLittle;
      }
    }
  }

  void setupBodyCreateCustomer() {
    ClientDataDNILogic clientDataLogic = Get.find();
    body = clientDataLogic.body;
  }

  void registerFinger(var isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
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
          isSuccess(true);
        } else {
          isSuccess(false);
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        Get.back();
        isSuccess(false);
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  Future<void> getCapture() async {
    String language =
        Get.find<SettingService>().currentLocate.value.languageCode;
    String result = "";
    String imageBase64 = "";
    try {
      final argument = {"language": language};
      final value = await NativeUtil.platformFinger
          .invokeMethod(NativeUtil.nameFinger, argument);
      result = value;
      if (kDebugMode) {
        print("text Capture: ${result}");
      }
      final body = json.decode(result);
      textCapture = body["pathImage"];
      imageBase64 = body["imageBase64"];
    } on PlatformException catch (e) {
      e.printInfo();
      return;
    }
    if (imageBase64.isNotEmpty) {
      currentPathFinger = textCapture;
      currentImageFinger = imageBase64;
    } else {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textGetNoSuccess, context);
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

  void createCustomer(Function(bool isSuccess) callBack) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    body['left'] = indexLeft;
    body['leftImage'] = listImageLeft;
    body['right'] = indexRight;
    body['rightImage'] = listImageRight;
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_CREATE_CUSTOMER,
      body: body,
      onSuccess: (response) {
        if (response.isSuccess) {
          Get.back();
          customerModel = CustomerModel.fromJson(response.data['data']);
          print(customerModel.name);
          print('Call api register customer');
          callBack.call(true);
        } else {
          print("error: ${response.status}");
          callBack.call(false);
        }
      },
      onError: (error) {
        Get.back();
        callBack.call(false);
        Common.showMessageError(error: error, context: context);
      },
    );
  }
}
