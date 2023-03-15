import 'dart:math';

import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../cretate_contact_page_logic.dart';

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
  CreateContactPageLogic logicCreateContact = Get.find();
  int requestId = 0;
  int productId = 0;
  int reasonId = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestId = logicCreateContact.requestId;
    productId = logicCreateContact.productId;
    reasonId = logicCreateContact.reasonId;
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

  String isoDate(String date) {
    DateTime dateTime = DateFormat('dd/MM/yyyy').parse(date);
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime.toUtc());
  }

  void createCustomer(Function(bool isSuccess) callBack) {
    var rng = Random();
    int random = rng.nextInt(899) + 100;
    String idNumber = "123126$random";
    Map<String, dynamic> body = {
      "type": "DNI",
      "idNumber": idNumber,
      "name": tfName.text,
      "fullName": tfLastName.text,
      "nationality": tfNationality.text,
      "sex": 'M',
      "dateOfBirth": isoDate(dob),
      "expiredDate": isoDate(exd),
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
          customerModel = CustomerModel.fromJson(response.data['data']);
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
