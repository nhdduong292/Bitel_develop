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

  String currentIdentity = "DNI";
  List<String> listIdentityNumber = ["DNI", "CE", "PP", "PTP"];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
