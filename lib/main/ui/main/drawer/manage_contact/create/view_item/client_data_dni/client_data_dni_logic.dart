import 'dart:math';

import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../../../../../../utils/common.dart';
import '../../cretate_contact_page_logic.dart';

class ClientDataDNILogic extends GetxController {
  late BuildContext context;

  TextEditingController tfLastName = TextEditingController();
  TextEditingController tfName = TextEditingController();
  TextEditingController tfNationality = TextEditingController();
  TextEditingController tfAddress = TextEditingController();

  FocusNode focusLastName = FocusNode();
  CustomerModel customerModel = CustomerModel();

  String sexValue = 'M';
  List<String> sexs = ['M', 'F'];

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
  String idNumber = '';
  bool isForcedTerm = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestId = logicCreateContact.requestId;
    productId = logicCreateContact.productId;
    reasonId = logicCreateContact.reasonId;
    idNumber = logicCreateContact.idNumber;
    isForcedTerm = logicCreateContact.isForcedTerm;
  }

  void setDefaultDob() {
    String birthDateString = '01/01/1990';
    selectDate = DateFormat('dd/MM/yyyy').parse(birthDateString);
  }

  void setDateNow() {
    selectDate = DateTime.now();
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
    Map<String, dynamic> body = {
      "type": logicCreateContact.typeCustomer,
      "idNumber": idNumber,
      "name": tfName.text,
      "fullName": tfLastName.text,
      "nationality": tfNationality.text,
      "sex": sexValue,
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

// so sanh date of birth voi expried date
  bool compareToDate() {
    DateFormat formatter = DateFormat("dd/MM/yyyy");

    DateTime date1 = formatter.parse(dob);
    DateTime date2 = formatter.parse(exd);

    int result = date1.compareTo(date2);

    if (result < 0) {
      return false;
    } else if (result > 0) {
      return true;
    } else {
      return true;
    }
  }

  // so sanh date of birth voi ngay hien tai
  bool compareToDateNow() {
    DateFormat formatter = DateFormat("dd/MM/yyyy");
    DateTime date1 = formatter.parse(dob);
    DateTime date2 = DateTime.now();

    int result = date1.compareTo(date2);

    if (result < 0) {
      return false;
    } else if (result > 0) {
      return true;
    } else {
      return true;
    }
  }

  bool checkValidate() {
    if (!tfLastName.text.isNotEmpty) {
      Common.showToastCenter("Bạn phải nhập hết thông tin");
      return false;
    } else if (!tfName.text.isNotEmpty) {
      Common.showToastCenter("Bạn phải nhập hết thông tin");
      return false;
    } else if (!tfNationality.text.isNotEmpty) {
      Common.showToastCenter("Bạn phải nhập hết thông tin");
      return false;
    } else if (!dob.isNotEmpty) {
      Common.showToastCenter("Bạn phải nhập hết thông tin");
      return false;
    } else if (!exd.isNotEmpty) {
      Common.showToastCenter("Bạn phải nhập hết thông tin");
      return false;
    } else if (compareToDateNow()) {
      Common.showToastCenter("Ngày sinh không được lớn hơn ngày hiện tại");
      return false;
    } else if (compareToDate()) {
      Common.showToastCenter("Ngày sinh phải nhỏ hơn ngày hết hạn");
      return false;
    }
    return true;
  }
}
