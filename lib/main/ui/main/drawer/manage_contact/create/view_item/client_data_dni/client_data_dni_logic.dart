import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/document_scanning_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/scan_model/customer_dni_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../../../../../../networks/model/address_model.dart';
import '../../../../../../../utils/common.dart';
import '../../cretate_contact_page_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClientDataDNILogic extends GetxController {
  late BuildContext context;

  TextEditingController tfLastName = TextEditingController();
  TextEditingController tfMidelName = TextEditingController();
  TextEditingController tfName = TextEditingController();
  TextEditingController tfFullName = TextEditingController();
  TextEditingController tfNationality = TextEditingController();
  TextEditingController tfIdNumber = TextEditingController();

  FocusNode focusLastName = FocusNode();
  FocusNode fcIdNumber = FocusNode();
  CustomerModel customerModel = CustomerModel();
  // CustomerDNIModel customerDNIModel = CustomerDNIModel();

  ClientDataDNILogic({required this.context});

  String sexValue = 'M';
  List<String> sexs = ['M', 'F'];

  var fromDate = "".obs;
  var toDate = "".obs;
  int typeDate = 0;
  DateTime selectDate = DateTime.now();
  String dob = '';
  String exd = '';
  CreateContactPageLogic logicCreateContact = Get.find();
  RequestDetailModel requestModel = RequestDetailModel();
  int productId = 0;
  int reasonId = 0;
  String idNumberRequest = '';
  String idNumber = '';
  String province = '';
  String district = '';
  String precinct = '';
  bool isForcedTerm = false;
  Map<String, dynamic> body = {};

  AddressModel currentProvince = AddressModel();
  List<AddressModel> listProvince = [];
  AddressModel currentDistrict = AddressModel();
  List<AddressModel> listDistrict = [];
  AddressModel currentPrecinct = AddressModel();
  List<AddressModel> listPrecinct = [];

  String currentAddress = "";

  String address = '';

  TextEditingController textFieldProvince = TextEditingController();
  TextEditingController textFieldDistrict = TextEditingController();
  TextEditingController textFieldPrecinct = TextEditingController();
  TextEditingController textFieldAddress = TextEditingController();

  FocusNode focusProvince = FocusNode();
  FocusNode focusDistrict = FocusNode();
  FocusNode focusPrecinct = FocusNode();
  FocusNode focusAddress = FocusNode();

  final FocusScopeNode focusScopeNode = FocusScopeNode();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestModel = logicCreateContact.requestModel;
    productId = logicCreateContact.productId;
    reasonId = logicCreateContact.reasonId;
    idNumberRequest = logicCreateContact.requestModel.customerModel.idNumber;
    isForcedTerm = logicCreateContact.isForcedTerm;
    province = logicCreateContact.requestModel.province;
    district = logicCreateContact.requestModel.district;
    precinct = logicCreateContact.requestModel.precinct;
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

  void reset() {
    tfLastName.text = '';
    tfName.text = '';
    tfNationality.text = '';
    sexValue = 'M';
    dob = '';
    exd = '';
  }

  void setCustomerDNIModel() {
    DocumentScanningLogic documentScanningLogic = Get.find();
    var customerDNIModel = documentScanningLogic.customerScanModel
        .getCustomerScan(documentScanningLogic.currentIdentity);
    idNumber = customerDNIModel.number.getContent();
    tfLastName.text = customerDNIModel.lastname.getContent();
    tfMidelName.text = customerDNIModel.midelname.getContent();
    tfLastName.selection = TextSelection.fromPosition(
        TextPosition(offset: customerDNIModel.lastname.getContent().length));
    tfName.text = customerDNIModel.name.getContent();
    tfName.selection = TextSelection.fromPosition(
        TextPosition(offset: customerDNIModel.name.getContent().length));
    updateFullName();
    tfNationality.text = customerDNIModel.nationality.getContent();
    tfNationality.selection = TextSelection.fromPosition(
        TextPosition(offset: customerDNIModel.nationality.getContent().length));
    if (customerDNIModel.sex.content == 'M') {
      sexValue = 'M';
    } else if (customerDNIModel.sex.content == 'F') {
      sexValue = 'F';
    }
    final dateFormat = DateFormat('dd MM yyyy');
    try {
      final date = dateFormat.parse(customerDNIModel.dob.getContent());
      dob = Common.fromDate(date, 'dd/MM/yyyy');
    } catch (e) {
      // nếu chuỗi không đúng định dạng, phương thức parse sẽ ném ra một ngoại lệ
      dob = '';
    }
    try {
      final date = dateFormat.parse(customerDNIModel.ed.getContent());
      exd = Common.fromDate(date, 'dd/MM/yyyy');
    } catch (e) {
      // nếu chuỗi không đúng định dạng, phương thức parse sẽ ném ra một ngoại lệ
      exd = '';
    }

    tfIdNumber.text = idNumber;

    tfIdNumber.selection =
        TextSelection.fromPosition(TextPosition(offset: idNumber.length));

    update();
  }

  void createBodyCustomer() {
    body = {
      "type": logicCreateContact.typeCustomer,
      "idNumber": tfIdNumber.text,
      "name": tfName.text.trim(),
      "lastNameFather": tfLastName.text.trim(),
      "lastNameMother": tfMidelName.text.trim(),
      "fullName": '${tfLastName.text} ${tfMidelName.text} ${tfName.text}'
          .replaceAll(RegExp(r'\s+'), ' '),
      "nationality": tfNationality.text,
      "sex": sexValue,
      "dateOfBirth": isoDate(dob),
      "expiredDate": isoDate(exd),
      "address": currentAddress,
      "province": currentProvince.province,
      "district": currentDistrict.district,
      "precinct": currentPrecinct.precinct,
      "phone": logicCreateContact.requestModel.customerModel.telFax,
      "image": logicCreateContact.listImageScan,
    };
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

  void updateFullName() {
    tfFullName.text = '${tfLastName.text} ${tfMidelName.text} ${tfName.text}'
        .replaceAll(RegExp(r'\s+'), ' ');
    update();
  }

  bool checkValidate() {
    print(requestModel.customerModel.idNumber);
    if (!containsOnlyUpperCaseAndNumber(tfIdNumber.text)) {
      fcIdNumber.requestFocus();
      Common.showToastCenter(
          AppLocalizations.of(context)!.textValidateIdentityPP);
      return false;
    }
    if (tfIdNumber.text != requestModel.customerModel.idNumber) {
      fcIdNumber.requestFocus();
      Common.showToastCenter(
          AppLocalizations.of(context)!.textTheIDNumberDoseNotMatch);
      return false;
    }
    if (!tfLastName.text.isNotEmpty) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textNotEmptyLastName);
      return false;
    } else if (!tfName.text.isNotEmpty) {
      Common.showToastCenter(AppLocalizations.of(context)!.textNotEmptyName);
      return false;
    } else if (!tfNationality.text.isNotEmpty) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textNotEmptyNationality);
      return false;
    } else if (!dob.isNotEmpty) {
      Common.showToastCenter(AppLocalizations.of(context)!.textNotEmptyDob);
      return false;
    } else if (!exd.isNotEmpty) {
      Common.showToastCenter(AppLocalizations.of(context)!.textNotEmptyExd);
      return false;
    } else if (compareToDateNow()) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textToastValidateDob);
      return false;
    } else if (compareToDate()) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textToastValidateExd);
      return false;
    } else if (address.isEmpty) {
      Common.showToastCenter(AppLocalizations.of(context)!.textNotEmptyAddress);
      return false;
    }
    return true;
  }

  void getListProvince(Function(bool isSuccess) function) {
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_PROVINCES,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listProvince = (response.data['data'] as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            if (listProvince.isNotEmpty) {
              update();
            }
            function.call(true);
          } else {
            print("error: ${response.status}");
            function.call(false);
          }
        },
        onError: (error) {
          function.call(false);
          Common.showMessageError(error, context);
        });
  }

  void getListPrecincts(String areaCode, Function(bool isSuccess) function) {
    Map<String, dynamic> params = {"areaCode": areaCode};
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_PRECINCTS,
        params: params,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listPrecinct = (response.data['data'] as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            if (listPrecinct.isNotEmpty) {
              update();
            }
            function.call(true);
          } else {
            print("error: ${response.status}");
            function.call(false);
          }
        },
        onError: (error) {
          function.call(false);
          Common.showMessageError(error, context);
        });
  }

  void getListDistrict(String areaCode, Function(bool isSuccess) function) {
    Map<String, dynamic> params = {"areaCode": areaCode};
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_DISTRICTS,
        params: params,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listDistrict = (response.data['data'] as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            if (listDistrict.isNotEmpty) {
              update();
            }
            function.call(true);
          } else {
            print("error: ${response.status}");
            function.call(false);
          }
        },
        onError: (error) {
          function.call(false);
          Common.showMessageError(error, context);
        });
  }

  void setPrecinct(AddressModel value) {
    // if(value.areaCode == currentPrecinct.areaCode) return;
    currentPrecinct = value;
    textFieldPrecinct.text = value.name;
    update();
  }

  void setDistrict(AddressModel value) {
    // if(value.areaCode == currentDistrict.areaCode) return;
    currentDistrict = value;
    textFieldDistrict.text = value.name;
    textFieldPrecinct.text = "";
    listPrecinct.clear();
    update();
  }

  void setProvince(AddressModel value) {
    // if(value.areaCode == currentProvince.areaCode) return;
    currentProvince = value;
    textFieldProvince.text = value.name;
    textFieldDistrict.text = "";
    textFieldPrecinct.text = "";
    listDistrict.clear();
    listPrecinct.clear();
    update();
  }

  void setAddress(String value) {
    currentAddress = value;
    update();
  }

  bool validateAddress() {
    if (textFieldDistrict.text.isNotEmpty &&
        textFieldDistrict.text.isNotEmpty &&
        textFieldPrecinct.text.isNotEmpty &&
        textFieldAddress.text.isNotEmpty) {
      return true;
    }
    Common.showToastCenter(AppLocalizations.of(context)!.textInputInfo);
    return false;
  }

  void resetAdress() {
    textFieldProvince.text = '';
    textFieldDistrict.text = '';
    textFieldPrecinct.text = '';
    textFieldAddress.text = '';
    listProvince.clear();
    listDistrict.clear();
    listPrecinct.clear();
  }

  bool containsOnlyUpperCaseAndNumber(String text) {
    RegExp upperCaseAndNumberRegExp = RegExp(r'^[A-Z0-9]*$');
    return upperCaseAndNumberRegExp.hasMatch(text);
  }
}
