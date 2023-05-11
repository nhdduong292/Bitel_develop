import 'dart:async';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/address_model.dart';
import 'package:bitel_ventas/main/networks/model/contact_model.dart';
import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/response/search_contact_response.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../utils/common_widgets.dart';

class CreateRequestLogic extends GetxController {
  BuildContext context;

  String currentService = "FTTH";
  List<String> listService = ["FTTH", "OFFICE_WAN", "LEASED_LINE"];
  String currentIdentityType = "DNI";
  String currentIdentity = "";
  List<String> listIdentity = ["DNI", "CE", "PP"];
  AddressModel currentArea = AddressModel();
  List<AddressModel> listArea = [];
  String currentAddress = "";
  bool isAddContact = true;
  ContactModel contactModel = ContactModel();
  bool isLoading = false;
  String currentName = "";
  String currentPhone = "";
  bool isCheckAgree = true;
  CustomerModel customerModel = CustomerModel();

  TextEditingController textFieldIdNumber = TextEditingController();
  TextEditingController textFieldPhone = TextEditingController();
  TextEditingController textFieldName = TextEditingController();
  TextEditingController textFieldArea = TextEditingController();
  TextEditingController textFieldAddress = TextEditingController();
  FocusNode focusIdNumber = FocusNode();
  FocusNode focusName = FocusNode();
  FocusNode focusPhone = FocusNode();
  FocusNode focusArea = FocusNode();
  FocusNode focusAddress = FocusNode();
  RequestDetailModel requestModel = RequestDetailModel();

  CreateRequestLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    focusIdNumber.addListener(() {
      if (!focusIdNumber.hasFocus) {
        // The TextField lost focus
        getCustomerExist();
      }
    });
    // getMaxLengthIdNumber(currentIdentityType);
  }

  void setIdentityType(String value) {
    currentIdentityType = value;
    update();
  }

  void setPrecinct(AddressModel value) {
    // if(value.areaCode == currentPrecinct.areaCode) return;
    currentArea = value;
    textFieldArea.text = value.name;
    update();
  }

  void setAddress(String value) {
    currentAddress = value;
    update();
  }

  void setName(String value) {
    currentName = value;
    update();
  }

  void setPhone(String value) {
    currentPhone = value;
    update();
  }

  void setService(String value) {
    currentService = value;
    update();
  }

  bool checkValidateCreate(BuildContext context) {
    if (textFieldIdNumber.value.text.isEmpty) {
      focusIdNumber.requestFocus();
      return true;
    }
    if (!containsOnlyUpperCaseAndNumber(textFieldIdNumber.text)) {
      focusIdNumber.requestFocus();
      Common.showToastCenter(
          AppLocalizations.of(context)!.textValidateIdentityPP);
      return true;
    }
    if (textFieldName.value.text.isEmpty) {
      focusName.requestFocus();
      return true;
    }
    if (textFieldPhone.value.text.isEmpty ||
        textFieldPhone.value.text.length < 9) {
      focusPhone.requestFocus();
      Common.showToastCenter(AppLocalizations.of(context)!.textPhoneMin9Number);
      return true;
    }
    if (currentArea.province.isEmpty ||
        currentArea.district.isEmpty ||
        currentArea.precinct.isEmpty) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textNotEmptyPrecinct);
      return true;
    }

    if (textFieldAddress.value.text.trim().isEmpty) {
      focusAddress.requestFocus();
      Common.showToastCenter(AppLocalizations.of(context)!.textNotEmptyAddress);
      return true;
    }

    if (!isCheckAgree) {
      Common.showToastCenter(AppLocalizations.of(context)!.textInputInfo);
      return true;
    }
    return false;
  }

  void createRequest(
      Function(bool isSuccess, RequestDetailModel model) function) {
    Map<String, dynamic> body = {
      "address": currentAddress.trim(),
      "district": currentArea.district.trim(),
      "idNumber": currentIdentity.trim(),
      "name": currentName.trim(),
      "phone": currentPhone.trim(),
      "precinct": currentArea.precinct.trim(),
      "province": currentArea.province.trim(),
      "service": currentService.trim(),
      "identityType": currentIdentityType.trim()
    };
    ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_CREATE_REQUEST,
        body: body,
        onSuccess: (response) {
          if (response.isSuccess) {
            requestModel = RequestDetailModel.fromJson(response.data['data']);
            print("success");
            function.call(true, requestModel);
          } else {
            print("error: ${response.status}");
            function.call(false, requestModel);
          }
        },
        onError: (error) {
          function.call(false, requestModel);
          Common.showMessageError(error: error, context: context);
        });
  }

  void setIdentity(String value) {
    currentIdentity = value;
    update();
  }

  void searchNumberContact(String id) {
    Map<String, dynamic> params = {
      "phone": "",
      "identityType": currentIdentityType,
      "idNumber": id,
      "page": "0",
      "pageSize": "10",
      "sort": "createdDate"
    };
    ApiUtil.getInstance()!.get(
        url: "${ApiEndPoints.API_SEARCH_CONTACT}",
        params: params,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            SearchContactResponse contactResponse =
                SearchContactResponse.fromJson(response.data['data']);
            if (contactResponse.list.isNotEmpty) {
              contactModel = contactResponse.list[0];
              print("${contactModel.toString()}");
            }
          } else {
            print("error: ${response.status}");
            isAddContact = false;
            update();
          }
        },
        onError: (error) {
          Common.showMessageError(error: error, context: context);
        });
  }

  void createSurveyOffline(Function(bool isSuccess) callBack) {
    Map<String, dynamic> body = {
      "status": RequestStatus.CREATE_REQUEST,
      "reasonId": "",
      "note": ""
    };
    ApiUtil.getInstance()!.put(
        url:
            "${ApiEndPoints.API_REQUEST_DETAIL}/${requestModel.id}${ApiEndPoints.API_CHANGE_STATUS_REQUEST}",
        body: body,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            // requestModel = RequestModel.fromJson(response.data);
            callBack.call(true);
          } else {
            print("error: ${response.status}");
            callBack.call(false);
          }
        },
        onError: (error) {
          callBack.call(false);
          Common.showMessageError(error: error, context: context);
        });
  }

  void createSurveyOnline(Function(bool isSuccess) callBack) {
    ApiUtil.getInstance()!.get(
        url:
            "${ApiEndPoints.API_SURVEY}/${requestModel.id}${ApiEndPoints.API_SURVEY_ONLINE}",
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            callBack.call(true);
          } else {
            print("error: ${response.status}");
            callBack.call(false);
          }
        },
        onError: (error) {
          callBack.call(false);
          Common.showMessageError(error: error, context: context);
        });
  }

  void getCustomerExist() {
    _onLoading(context);
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_GET_CUSTOMER_EXIST,
        params: {
          "idType": currentIdentityType,
          "idNo": textFieldIdNumber.text.trim()
        },
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            customerModel = CustomerModel.fromJson(response.data["data"]);

            textFieldName.text = customerModel.name;
            currentName = customerModel.name;
            textFieldPhone.text = customerModel.telFax;
            currentPhone = customerModel.telFax;
            textFieldAddress.text = customerModel.address;
            currentAddress = customerModel.address;
            if (customerModel.custId != 0) {
              textFieldArea.text =
                  '${customerModel.provinceName} - ${customerModel.districtName} - ${customerModel.precinctName}';
            } else {
              textFieldArea.text = '';
            }
            currentArea.province = customerModel.province;
            currentArea.district = customerModel.district;
            currentArea.precinct = customerModel.precinct;

            update();
          } else {
            print("error: ${response.status}");
          }
          Get.back();
        },
        onError: (error) {
          Get.back();
          Common.showMessageError(error: error, context: context);
        });
  }

  void setCheckAgree(bool value) {
    isCheckAgree = value;
    update();
  }

  int getMaxLengthIdNumber(String value) {
    if (value == listIdentity[0]) {
      return 8;
    } else if (value == listIdentity[2]) {
      return 9;
    } else {
      return 9;
    }
  }

  bool containsOnlyUpperCaseAndNumber(String text) {
    RegExp upperCaseAndNumberRegExp = RegExp(r'^[A-Z0-9]*$');
    return upperCaseAndNumberRegExp.hasMatch(text);
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: LoadingCirculApi(),
        );
      },
    );
  }

  Future<List<AddressModel>> getAreas(String query) {
    Completer<List<AddressModel>> completer = Completer();
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_SEARCH_AREAS,
        params: {'key': query},
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listArea = (response.data['data'] as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            completer.complete(listArea);
          } else {
            print("error: ${response.status}");
            completer.complete([]);
          }
        },
        onError: (error) {
          Get.back();
          Common.showMessageError(error: error, context: context);
          completer.complete([]);
          // callBack.call(false);
        });
    return completer.future;
  }
}
