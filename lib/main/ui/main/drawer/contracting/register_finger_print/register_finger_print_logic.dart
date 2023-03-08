import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterFingerPrintLogic extends GetxController {
  late BuildContext context;

  var handValue = (0).obs;
  var fingerValue = (0).obs;
  var pathFinger = AppImages.imgFingerLeft1.obs;

  String findPathFinger() {
    if (handValue.value == 0) {
      if (fingerValue.value == 0) {
        return AppImages.imgFingerLeft1;
      } else if (fingerValue.value == 1) {
        return AppImages.imgFingerLeft2;
      } else if (fingerValue.value == 2) {
        return AppImages.imgFingerLeft3;
      } else if (fingerValue.value == 3) {
        return AppImages.imgFingerLeft4;
      } else {
        return AppImages.imgFingerLeft5;
      }
    } else {
      if (fingerValue.value == 0) {
        return AppImages.imgFingerRight1;
      } else if (fingerValue.value == 1) {
        return AppImages.imgFingerRight2;
      } else if (fingerValue.value == 2) {
        return AppImages.imgFingerRight3;
      } else if (fingerValue.value == 3) {
        return AppImages.imgFingerRight4;
      } else {
        return AppImages.imgFingerRight5;
      }
    }
  }
}
