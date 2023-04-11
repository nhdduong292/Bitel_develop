import 'dart:async';
import 'dart:io';

import 'package:bitel_ventas/main/networks/model/contract_model.dart';
import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../networks/model/address_model.dart';

class CustomerInformationLogic extends GetxController {
  late BuildContext context;
  var checkItem1 = true.obs;
  var checkItem2 = false.obs;
  var checkItem3 = false.obs;
  var titleScreen = ''.obs;
  var isUpdate = false.obs;
  var signDate = ''.obs;
  var path = ''.obs;
  var checkOption = true.obs;
  var checkMainContract = true.obs;
  var checkLendingContract = false.obs;
  var billCycle = '';
  int productId = 0;
  int reasonId = 0;
  int promotionId = 0;
  bool isForcedTerm = false;
  String phone = '';
  String email = '';
  String address = '';
  String billAddress = '';
  CustomerModel customer = CustomerModel();
  ContractModel contract = ContractModel();
  CustomerInformationLogic({required this.context});

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  AddressModel currentProvince = AddressModel();
  List<AddressModel> listProvince = [];
  AddressModel currentDistrict = AddressModel();
  List<AddressModel> listDistrict = [];
  AddressModel currentPrecinct = AddressModel();
  List<AddressModel> listPrecinct = [];

  AddressModel billProvince = AddressModel();
  AddressModel billDistrict = AddressModel();
  AddressModel billPrecinct = AddressModel();
  String billAddressSelect = "";

  String currentAddress = "";
  bool isAddContact = true;

  TextEditingController textFieldProvince = TextEditingController();
  TextEditingController textFieldDistrict = TextEditingController();
  TextEditingController textFieldPrecinct = TextEditingController();
  TextEditingController textFieldAddress = TextEditingController();

  FocusNode focusProvince = FocusNode();
  FocusNode focusDistrict = FocusNode();
  FocusNode focusPrecinct = FocusNode();
  FocusNode focusAddress = FocusNode();

  bool isValidateAddress = false;
  bool isActiveUpdate = true;
  bool isActiveContinue = false;

  RequestDetailModel requestModel = RequestDetailModel();

  final ItemScrollController scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final FocusScopeNode focusScopeNode = FocusScopeNode();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    customer = data[0];
    requestModel = data[1];
    productId = data[2];
    reasonId = data[3];
    isForcedTerm = data[4];
    promotionId = data[5];
    phone = customer.telFax;
    email = customer.email;
    if (customer.address.isNotEmpty ||
        customer.province.isNotEmpty ||
        customer.district.isNotEmpty ||
        customer.precinct.isNotEmpty) {
      address = customer.getInstalAddress();
    } else {
      address = requestModel.getInstalAddress();
    }

    billAddress = requestModel.getInstalAddress();

    phoneController.text = phone;
    phoneController.selection =
        TextSelection.fromPosition(TextPosition(offset: phone.length));

    emailController.text = email;
    emailController.selection =
        TextSelection.fromPosition(TextPosition(offset: email.length));

    showButtonContinue();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    titleScreen.value = AppLocalizations.of(context)!.textCustomerInformation;
  }

  String getSex() {
    if (customer.sex == 'M') {
      return AppLocalizations.of(context)!.textMale;
    } else if (customer.sex == 'F') {
      return AppLocalizations.of(context)!.textFemale;
    }
    return '';
  }

  void getCurrentTime() {
    DateTime now = DateTime.now();
    if (now.day >= 6 && now.day < 16) {
      billCycle = 'CYCLE6';
    } else if (now.day >= 16 && now.day < 26) {
      billCycle = 'CYCLE16';
    } else {
      billCycle = 'CYCLE26';
    }
    signDate.value = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
    update();
  }

  String getBillCycle(String billCycle) {
    if (billCycle == 'CYCLE6') {
      return '${AppLocalizations.of(context)!.textCircle} 6';
    } else if (billCycle == 'CYCLE16') {
      return '${AppLocalizations.of(context)!.textCircle} 16';
    } else {
      return '${AppLocalizations.of(context)!.textCircle} 26';
    }
  }

  String getTypeCustomer() {
    // var type = customer.type;
    // if (type == 1) {
    //   return 'DNI';
    // } else if (type == 2) {
    //   return 'CE';
    // } else if (type == 3) {
    //   return 'RUC';
    // } else if (type == 4) {
    //   return 'PP';
    // } else if (type == 7) {
    //   return 'PTP';
    // } else if (type == 8) {
    //   return 'CPP';
    // }
    // return '';
    return customer.type;
  }

  var checkOption1 = false.obs;
  var checkOption2 = false.obs;
  var checkOption3 = false.obs;
  var checkOption4 = false.obs;

  Rx<String> contractLanguagetValue = 'SPANISH'.toUpperCase().obs;
  final contractLanguages = [
    'SHIPIBO_KONIBO',
    'ASHANINKA',
    'AYMARA',
    'SPANISH',
    'QUECHUA'
  ];

  void createContract(BuildContext context, Function(bool) isSuccess) {
    _onLoading(context);
    Map<String, dynamic> body = {
      "requestId": requestModel.id,
      "productId": productId,
      "reasonId": reasonId,
      "promotionId": promotionId,
      "contractType": isForcedTerm ? "FORCED_TERM" : "UNDETERMINED",
      "numOfSubscriber": 1,
      "signDate": signDate.value.trim(),
      "billCycle": billCycle,
      "changeNotification": "Email",
      "printBill": "Email",
      "currency": "SOL",
      "language": contractLanguagetValue.value.toUpperCase(),
      "province": billProvince.province.isNotEmpty
          ? billProvince.province
          : requestModel.province,
      "district": billDistrict.district.isNotEmpty
          ? billDistrict.district
          : requestModel.district,
      "precinct": billPrecinct.precinct.isNotEmpty
          ? billPrecinct.precinct
          : requestModel.precinct,
      "address": billAddressSelect.isNotEmpty
          ? billAddressSelect
          : requestModel.address,
      "phone": customer.telFax.trim(),
      "email": customer.email.trim(),
      "protectionFilter": checkOption1.value,
      "receiveInfoByMail": checkOption2.value,
      "receiveFromThirdParty": checkOption3.value,
      "receiveFromBitel": checkOption4.value
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_CREATE_CONTRACT,
      body: body,
      onSuccess: (response) {
        print('bxloc create contract success');
        Get.back();
        if (response.isSuccess) {
          print(response.data['data']);
          contract = ContractModel.fromJson(response.data['data']);
          isSuccess.call(true);
        } else {
          print("error: ${response.status}");
          isSuccess.call(false);
        }
      },
      onError: (error) {
        print('bxloc create contract false');
        isSuccess.call(false);
        Get.back();
        Common.showMessageError(error, context);
      },
    );
  }

  bool checkValidateAddInfo() {
    if (phone.isEmpty) {
      Common.showToastCenter(AppLocalizations.of(context)!.textNotEmptyPhone);
      return true;
    } else if (email.isEmpty) {
      Common.showToastCenter(AppLocalizations.of(context)!.textNotEmptyEmail);
      return true;
    } else if (address.isEmpty) {
      Common.showToastCenter(AppLocalizations.of(context)!.textNotEmptyAddress);
      return true;
    }
    return false;
  }

  bool checkValidateContractInfo() {
    // if(phone.isEmpty || email.isEmpty || address.isEmpty) {
    //   Common.showToastCenter("Vui lòng nhập đầy đủ thông tin!");
    //   return true;
    // }
    return false;
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

  bool checkValidate() {
    if (!Common.validatePhone(phone)) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textValidatePhoneNumber);
      return false;
    } else if (!Common.validateEmail(email)) {
      Common.showToastCenter(AppLocalizations.of(context)!.textValidateEmail);
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

  void setBillPrecinct(AddressModel value) {
    // if(value.areaCode == currentPrecinct.areaCode) return;
    billPrecinct = value;
    textFieldPrecinct.text = value.name;
    update();
  }

  void setBillDistrict(AddressModel value) {
    // if(value.areaCode == currentDistrict.areaCode) return;
    billDistrict = value;
    textFieldDistrict.text = value.name;
    textFieldPrecinct.text = "";
    listPrecinct.clear();
    update();
  }

  void setBillProvince(AddressModel value) {
    // if(value.areaCode == currentProvince.areaCode) return;
    billProvince = value;
    textFieldProvince.text = value.name;
    textFieldDistrict.text = "";
    textFieldPrecinct.text = "";
    listDistrict.clear();
    listPrecinct.clear();
    update();
  }

  void setBillAddress(String value) {
    billAddressSelect = value;
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

  bool checkChangeAdditionalInformation() {
    if (phoneController.text != customer.telFax) {
      return true;
    } else if (emailController.text != customer.email) {
      return true;
    } else if (currentProvince.province != customer.province &&
        currentProvince.province.isNotEmpty) {
      return true;
    } else if (currentDistrict.district != customer.district &&
        currentDistrict.district.isNotEmpty) {
      return true;
    } else if (currentPrecinct.precinct != customer.precinct &&
        currentPrecinct.precinct.isNotEmpty) {
      return true;
    } else if (currentAddress != customer.address &&
        currentAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
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

  void resetBillAdress() {
    textFieldProvince.text = '';
    textFieldDistrict.text = '';
    textFieldPrecinct.text = '';
    textFieldAddress.text = '';
    listProvince.clear();
    listDistrict.clear();
    listPrecinct.clear();
  }

  void updateCustomer(Function(bool isSuccess) callBack) {
    _onLoading(context);
    Map<String, dynamic> body = {
      "type": customer.type,
      "idNumber": customer.idNumber,
      "name": customer.name,
      "fullName": customer.fullName,
      "nationality": customer.nationality,
      "sex": 'M',
      "dateOfBirth": customer.birthDate,
      "expiredDate": customer.idExpireDate,
      "address": currentAddress.isEmpty
          ? (customer.address.isNotEmpty
              ? customer.address
              : requestModel.address)
          : currentAddress,
      "province": currentProvince.province.isEmpty
          ? (customer.province.isNotEmpty
              ? customer.province
              : requestModel.province)
          : currentProvince.province,
      "district": currentDistrict.district.isEmpty
          ? (customer.district.isNotEmpty
              ? customer.district
              : requestModel.district)
          : currentDistrict.district,
      "precinct": currentPrecinct.precinct.isEmpty
          ? (customer.precinct.isNotEmpty
              ? customer.precinct
              : requestModel.precinct)
          : currentPrecinct.precinct,
      "phone": phoneController.text,
      "email": emailController.text,
      "image": [],
      "left": null,
      "leftImage": null,
      "right": null,
      "rightImage": null
    };
    ApiUtil.getInstance()!.put(
      url: '${ApiEndPoints.API_CREATE_CUSTOMER}/${customer.custId}',
      body: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          customer = CustomerModel.fromJson(response.data['data']);
          callBack.call(true);
        } else {
          callBack.call(false);
        }
      },
      onError: (error) {
        Get.back();
        callBack.call(false);
        Common.showMessageError(error, context);
      },
    );
  }

  Future<bool> onWillPop() async {
    if (itemPositionsListener.itemPositions.value.elementAt(0).index == 1) {
      checkItem1.value = true;
      checkItem2.value = false;
      titleScreen.value = AppLocalizations.of(context)!.textCustomerInformation;
      scrollController.scrollTo(
        index: 0,
        duration: const Duration(milliseconds: 200),
      );
      return false;
    } else if (itemPositionsListener.itemPositions.value.elementAt(0).index ==
        2) {
      checkItem2.value = true;
      checkItem3.value = false;
      scrollController.scrollTo(
        index: 1,
        duration: const Duration(milliseconds: 200),
      );
      return false;
    }
    Get.back();
    return false; //<-- SEE HERE
  }

  void showButtonContinue() {
    if (phoneController.text.isNotEmpty && emailController.text.isNotEmpty) {
      isActiveContinue = true;
      update();
    } else {
      isActiveContinue = false;
      update();
    }
  }
}
