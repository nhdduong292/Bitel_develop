import 'dart:io';
import 'dart:math';

import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/client_data/customer_detect_mode.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/document_scanning_logic.dart';
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

class ClientDataDNILogic extends GetxController {
  late BuildContext context;

  TextEditingController tfLastName = TextEditingController();
  TextEditingController tfName = TextEditingController();
  TextEditingController tfNationality = TextEditingController();
  TextEditingController tfAddress = TextEditingController();

  FocusNode focusLastName = FocusNode();
  CustomerModel customerModel = CustomerModel();

  String sexValue = 'Nam';
  List<String> sexs = ['Nam', 'Nữ', 'Khác'];

  var fromDate = "".obs;
  var toDate = "".obs;
  int typeDate = 0;
  DateTime selectDate = DateTime.now();
  String dob = '';
  String exd = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void setToDate(DateTime picked) {
    if (typeDate == 1) {
      dob = "${picked.day}/${picked.month}/${picked.year}";
    } else {
      exd = "${picked.day}/${picked.month}/${picked.year}";
    }
    update();
  }

  void setFromDate(DateTime picked) {
    fromDate.value = "${picked.day}/${picked.month}/${picked.year}";
    update();
  }

  void createCustomer(Function(bool isSuccess) callBack) {
    var rng = Random();
    int random = rng.nextInt(89) + 10;
    String idNumber = "123126$random";
    Map<String, dynamic> body = {
      "type": "DNI",
      "idNumber": idNumber,
      "name": tfName.text,
      "fullName": tfLastName.text,
      "nationality": tfNationality.text,
      "sex": sexValue,
      "dateOfBirth": dob,
      "expiredDate": exd,
      "address": tfAddress.text,
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
          customerModel = CustomerModel.fromJson(response.data);
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

  bool checkValidate() {
    if (!tfLastName.text.isNotEmpty) {
      return false;
    } else if (!tfName.text.isNotEmpty) {
      return false;
    } else if (!tfNationality.text.isNotEmpty) {
      return false;
    } else if (!dob.isNotEmpty) {
      return false;
    } else if (!exd.isNotEmpty) {
      return false;
    }
    return true;
  }
}
