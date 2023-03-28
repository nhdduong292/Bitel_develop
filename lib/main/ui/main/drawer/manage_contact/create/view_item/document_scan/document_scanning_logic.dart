import 'dart:io';
import 'dart:math';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/networks/request/google_detect_request.dart';
import 'package:bitel_ventas/main/networks/request/google_detect_request.dart';
import 'package:bitel_ventas/main/networks/request/google_detect_request.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/create_contact_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/cretate_contact_page_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/client_data/client_data_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/scan_model/customer_dni_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/scan_model/customer_ce_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/scan_model/customer_scan_model.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../networks/request/google_detect_request.dart';
import '../client_data/customer_detect_mode.dart';

class DocumentScanningLogic extends GetxController {
  late BuildContext context;
  var checkOption1 = false.obs;
  var checkOption2 = false.obs;

  String textPathScan = "";
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  CustomerDetectModel customerDetectModel = CustomerDetectModel();
  CustomerModel customerModel = CustomerModel();
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  String currentIdentity = "DNI";
  List<String> listIdentityNumber = ["DNI", "CE", "PP", "PTP"];
  CustomerScanModel customerScanModel = CustomerScanModel();

  CreateContactPageLogic logicCreateContact = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onListenerMethod();
    currentIdentity = logicCreateContact.typeCustomer;
  }

  void setIdentity(String value) {
    currentIdentity = value;
    update();
  }

  bool isDNI() {
    if (currentIdentity == 'DNI') {
      return true;
    }
    return false;
  }

  String getImageIdentity() {
    if (currentIdentity == listIdentityNumber[0]) {
      return AppImages.imgDNI;
    } else if (currentIdentity == listIdentityNumber[1]) {
      return AppImages.imgCE;
    } else if (currentIdentity == listIdentityNumber[2]) {
      return AppImages.imgPP;
    } else if (currentIdentity == listIdentityNumber[3]) {
      return AppImages.imgPTP;
    }
    return AppImages.imgDNI;
  }

  void onListenerMethod() {
    NativeUtil.platformScan2.setMethodCallHandler((call) async {
      if (call.method == NativeUtil.nameScan2) {
        String link = call.arguments;
        textPathScan = link;
        update();
      }
    });
  }

  Future<void> getScan() async {
    String result = "";
    try {
      final String value =
          await NativeUtil.platformScan2.invokeMethod(NativeUtil.nameScan2);
      result = value;
    } on PlatformException catch (e) {
      e.printInfo();
    }
    print(result);
  }

  void setPathScan(String value) {
    textPathScan = value;
    update();
  }

  void detectID(BuildContext context) async {
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
        Common.showMessageError(error, context);
      },
    );
  }

  void reset() {
    customerScanModel = CustomerScanModel();
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

  Future<void> processImage(InputImage inputImage) async {
    final recognizedText = await _textRecognizer.processImage(inputImage);

    for (final textBlock in recognizedText.blocks) {
      for (final line in textBlock.lines) {
        print(line.text);
        if (customerScanModel
                .getCustomerScan(currentIdentity)
                .getInformationCus(line.text) !=
            null) {
          for (final element in line.elements) {
            if (customerScanModel
                    .getCustomerScan(currentIdentity)
                    .getInformationCus(element.text) !=
                null) {
              customerScanModel
                  .getCustomerScan(currentIdentity)
                  .getInformationCus((element.text))!
                  .rect = element.boundingBox;
            } else {
              customerScanModel
                  .getCustomerScan(currentIdentity)
                  .findInfo(element.boundingBox, element.text);
            }
          }
        } else {
          customerScanModel
              .getCustomerScan(currentIdentity)
              .findInfo(line.boundingBox, line.text);
        }
      }
    }
    update();
  }
}
