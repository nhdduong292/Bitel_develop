import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class OTPClearDebtLogic extends GetxController {
  var countDown = 120.obs;
  bool isActiveButton = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (countDown.value == 0) {
          timer.cancel();
        } else {
          countDown.value--;
        }
      },
    );
  }
}
