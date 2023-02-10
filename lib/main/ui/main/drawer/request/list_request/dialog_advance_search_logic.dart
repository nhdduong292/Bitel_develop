import 'dart:math';

import 'package:get/get.dart';

class DialogAdvanceSearchLogic extends GetxController {
  var fromDate = "".obs;
  var toDate = "".obs;
  DateTime selectDate = DateTime.now();
  String currentReason = "";
  List<String> listReason = ["HN", "HCM", "PQ"];

  void setToDate(DateTime picked) {
    toDate.value = "${picked.day}/${picked.month}";
    update();
  }

  void setFromDate(DateTime picked) {
    fromDate.value = "${picked.day}/${picked.month}";
    update();
  }
}
