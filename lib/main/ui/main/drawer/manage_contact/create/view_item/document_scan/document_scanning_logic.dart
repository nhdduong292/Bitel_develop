import 'dart:io';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/networks/request/google_detect_request.dart';
import 'package:bitel_ventas/main/networks/request/google_detect_request.dart';
import 'package:bitel_ventas/main/networks/request/google_detect_request.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../../../../../networks/request/google_detect_request.dart';

class DocumentScanningLogic extends GetxController {
  late BuildContext context;
  var checkOption1 = false.obs;
  var checkOption2 = false.obs;
  String textPathScan = "";
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  CustomerModel customerModel = CustomerModel();
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  String currentIdentity = "DNI";
  List<String> listIdentityNumber = ["DNI", "CE", "PP", "PTP"];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onListenerMethod();
  }

  void onListenerMethod() {
    NativeUtil.platformScan1.setMethodCallHandler((call) async {
      if (call.method == NativeUtil.nameScan1) {
        String link = call.arguments;
        print("Linkkkkkkkkkkkkkkkkkkk 1111111: $link");
        textPathScan = link;
        update();
      }
    });
  }

  Future<void> getScan() async {
    String result = "";
    try {
      final String value =
          await NativeUtil.platformScan1.invokeMethod(NativeUtil.nameScan1);
      result = value;
    } on PlatformException catch (e) {
      e.printInfo();
    }
    print(result);
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
    var type;
    int idNumber;
    var lastName;
    var fisrtName;
    var nationality;
    var sex;
    var dateOfBirth;
    var expiredDate;
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    final recognizedText = await _textRecognizer.processImage(inputImage);
    recognizedText.blocks.map((value) {
      var index = recognizedText.blocks.indexOf(value);
      if (value.text.contains('Apellidos')) {
        if (index == recognizedText.blocks.length) {
          return;
        } else {
          lastName = recognizedText.blocks[index + 1].text;
        }
      } else if (value.text.contains('Nacionalidad')) {
        if (index == recognizedText.blocks.length) {
          return;
        } else {
          nationality = recognizedText.blocks[index + 1].text;
        }
      } else if (value.text.contains('nacimiento')) {
        if (index == recognizedText.blocks.length) {
          return;
        } else {
          dateOfBirth = recognizedText.blocks[index + 1].text;
        }
      } else if (value.text.contains('Sexo')) {
        if (index == recognizedText.blocks.length) {
          return;
        } else {
          sex = recognizedText.blocks[index + 1].text;
        }
      } else if (value.text.contains('Nombres')) {
        if (index == recognizedText.blocks.length) {
          return;
        } else {
          fisrtName = recognizedText.blocks[index + 1].text;
        }
      } else if (value.text.contains('vencimiento')) {
        if (index == recognizedText.blocks.length) {
          return;
        } else {
          expiredDate = recognizedText.blocks[index + 1].text;
        }
      }
    }).toList();

    print(fisrtName);
    print(lastName);
    print(nationality);
    print(dateOfBirth);
    print(sex);
    print(expiredDate);
  }
}
