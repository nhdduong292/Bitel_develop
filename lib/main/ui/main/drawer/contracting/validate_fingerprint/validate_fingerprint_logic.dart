import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ValidateFingerprintLogic extends GetxController {
  late BuildContext context;
  String textCapture = "";

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
}
