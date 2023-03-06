import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class DocumentScanningLogic extends GetxController {
  late BuildContext context;
  var checkOption1 = true.obs;
  var checkOption2 = true.obs;

  String currentIdentity = "DNI";
  List<String> listIdentityNumber = ["DNI", "CE", "PP", "PTP"];
}
