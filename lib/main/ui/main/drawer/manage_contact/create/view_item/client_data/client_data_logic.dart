import 'dart:io';
import 'dart:math';

import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';
import '../../../../../../../utils/values.dart';

class ClientDataLogic extends GetxController {
  late BuildContext context;
  String textPathScan = "";
  CustomerModel customer = CustomerModel();
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  CustomerModel customerModel = CustomerModel();
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onListenerMethod();
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

  void createCustomer(Function(bool isSuccess) callBack) {
    var rng = Random();
    int random = rng.nextInt(99) + 10;
    String idNumber = "123126$random";
    Map<String, dynamic> body = {
      "type": "DNI",
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
      "image": "string"
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_CREATE_CUSTOMER,
      body: body,
      onSuccess: (response) {
        if (response.isSuccess) {
          customer = CustomerModel.fromJson(response.data);
          callBack.call(true);
        } else {
          print("error: ${response.status}");
          callBack.call(false);
        }
      },
      onError: (error) {
        callBack.call(false);
      },
    );
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
