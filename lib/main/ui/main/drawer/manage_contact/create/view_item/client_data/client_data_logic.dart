import 'dart:io';
import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/client_data/customer_detect_mode.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/document_scanning_logic.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';
import '../../../../../../../utils/values.dart';
import '../../cretate_contact_page_logic.dart';

class ClientDataLogic extends GetxController {
  DocumentScanningLogic logic = Get.find();
  late BuildContext context;
  String textPathScan = "";
  CustomerModel customer = CustomerModel();
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  CustomerDetectModel customerDetectModel = CustomerDetectModel();
  String? _text;
  CustomerModel customerModel = CustomerModel();
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  CreateContactPageLogic logicCreateContact = Get.find();
  String idNumber = '';
  Map<String, dynamic> body = {};

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // onListenerMethod();
    idNumber = logicCreateContact.idNumber;
  }

  void onListenerMethod() {
    NativeUtil.platformScan2.setMethodCallHandler((call) async {
      if (call.method == NativeUtil.nameScan2) {
        String link = call.arguments;
        print("Linkkkkkkkkkkkkkkkkkkk222: $link");
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

  void createBodyCustomer() {
    body = {
      "type": logicCreateContact.typeCustomer,
      "idNumber": idNumber,
      "name": "Duong",
      "fullName": "Tran",
      "nationality": "Peru",
      "sex": "M",
      "dateOfBirth": "2000-03-09",
      "expiredDate": "2025-03-09",
      "address": "string",
      "province": "03",
      "district": "04",
      "precinct": "04",
      "image": "string",
      "left": null,
      "leftImage": null,
      "right": null,
      "rightImage": null
    };
  }

  void setPathScan(String value) {
    textPathScan = value;
    processImage(InputImage.fromFilePath(File(value).path))
        .then((value) => {print('da xong')});
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
        if (error != null) {
          if (error['errorCode'] != null) {
            Common.showMessageError(error['errorCode'], context);
          }
        }
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

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    final recognizedText = await _textRecognizer.processImage(inputImage);
    for (var text in recognizedText.blocks) {
      print(text.text);
    }
    recognizedText.blocks.map((value) {
      if (value.text.contains('Apellidos')) {
        customerDetectModel.lastName =
            getTextDetect(recognizedText, value, 'Apellidos');
      } else if (value.text.contains('Nacionalidad')) {
        customerDetectModel.nationality =
            getTextDetect(recognizedText, value, 'Nacionalidad');
      } else if (value.text.contains('Emisi')) {
        customerDetectModel.dateOfBirth =
            getTextDetect(recognizedText, value, 'Emisi');
      } else if (value.text.contains('Sexo')) {
        customerDetectModel.sex = getTextDetect(recognizedText, value, 'Sexo');
      } else if (value.text.contains('Nombres')) {
        customerDetectModel.name =
            getTextDetect(recognizedText, value, 'Nombres');
      } else if (value.text.contains('Caduc')) {
        customerDetectModel.expiredDate =
            getTextDetect(recognizedText, value, 'Caduc');
      }
    }).toList();
    update();
  }

  String? getTextDetect(
      RecognizedText recognizedText, TextBlock value, String title) {
    var index = recognizedText.blocks.indexOf(value);
    if (index == recognizedText.blocks.length) {
      return null;
    } else {
      if (value.lines.length > 1) {
        int indexLine =
            value.lines.indexWhere((element) => element.text.contains(title));
        if (indexLine < value.lines.length - 1) {
          return value.lines[indexLine + 1].text;
        } else {
          return null;
        }
      } else {
        return recognizedText.blocks[index + 1].text;
      }
    }
  }
}
