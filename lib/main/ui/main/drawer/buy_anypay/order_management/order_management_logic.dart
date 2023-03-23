import 'package:get/get.dart';

class OrderManagementLogic extends GetxController{
  var from = "".obs;
  var to = "".obs;
  DateTime selectDate = DateTime.now();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  void setToDate(DateTime picked) {
    // print("Date: "+picked.toString());
    toDate = picked;
    to.value = "${picked.day}/${picked.month}";
    // searchRequest.toDate = picked.toIso8601String();
    update();
  }

  void setFromDate(DateTime picked) {
    // print("Date: "+picked.toString());
    // print("Date: "+picked.toIso8601String());
    fromDate = picked;
    from.value = "${picked.day}/${picked.month}";
    // searchRequest.fromDate = picked.toIso8601String();
    // DateTime pi = DateTime.parse(picked.toIso8601String());
    update();
  }
}