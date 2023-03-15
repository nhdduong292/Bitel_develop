import 'dart:async';
import 'dart:io';

import 'package:bitel_ventas/main/networks/model/contract_model.dart';
import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum BillCycle { c1, c2, c3 }

class CustomerInformationLogic extends GetxController {
  late BuildContext context;
  var checkItem1 = true.obs;
  var checkItem2 = false.obs;
  var checkItem3 = false.obs;
  var titleScreen = 'Customer information'.obs;
  var isUpdate = false.obs;
  var signDate = ''.obs;
  var path = ''.obs;
  var checkOption = false.obs;
  var checkMainContract = true.obs;
  var checkLendingContract = false.obs;
  var billCycle = ''.obs;
  int requestId = 0;
  int productId = 0;
  int reasonId = 0;
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
  TextEditingController addressController = TextEditingController();
  TextEditingController billAddressController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    customer = data[0];
    requestId = data[1];
    productId = data[2];
    reasonId = data[3];
    isForcedTerm = data[4];
    phone = customer.telFax;
    email = customer.email;
    address = customer.address;

    phoneController.text = phone;
    phoneController.selection =
        TextSelection.fromPosition(TextPosition(offset: phone.length));

    emailController.text = email;
    emailController.selection =
        TextSelection.fromPosition(TextPosition(offset: email.length));

    addressController.text = address;
    addressController.selection =
        TextSelection.fromPosition(TextPosition(offset: address.length));

    billAddressController.text = address;
    billAddressController.selection =
        TextSelection.fromPosition(TextPosition(offset: billAddress.length));
  }

  void getCurrentTime() {
    DateTime now = DateTime.now();
    if (now.day >= 6 && now.day < 16) {
      billCycle.value = 'Ciclo 6';
    } else if (now.day >= 16 && now.day < 26) {
      billCycle.value = 'Ciclo 16';
    } else {
      billCycle.value = 'Ciclo 26';
    }
    signDate.value = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
    update();
  }

  String getBillCycle(String billCycle) {
    if (billCycle == 'Ciclo 6') {
      return 'CYCLE6';
    } else if (billCycle == 'Ciclo 16') {
      return 'CYCLE16';
    } else {
      return 'CYCLE26';
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

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
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
      "requestId": requestId,
      "productId": productId,
      "reasonId": reasonId,
      "promotionId": 0,
      "contractType": isForcedTerm ? "FORCED_TERM" : "UNDETERMINED",
      "numOfSubscriber": 1,
      "signDate": signDate.value.trim(),
      "billCycle": getBillCycle(billCycle.value),
      "changeNotification": "Email",
      "printBill": "Email",
      "currency": "SOL",
      "language": contractLanguagetValue.value.toUpperCase(),
      "province": customer.province,
      "district": customer.district,
      "precinct": customer.precinct,
      "address": billAddress.trim(),
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
        isSuccess.call(false);
        Get.back();
      },
    );
  }

  void contractPreview(String type) {
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CONTRACT_PREVIEW.replaceAll("id", "54"),
      params: {"type": type},
      onSuccess: (response) {
        if (response.isSuccess) {
          print('bxloc get success');
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }

  bool checkValidateAddInfo() {
    if (phone.isEmpty || email.isEmpty || address.isEmpty) {
      Common.showToastCenter(AppLocalizations.of(context)!.textInputInfo);
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
    if (phone.length < 9) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textValidatePhoneNumber);
      return false;
    } else if (!Common.validatePhone(phone)) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textValidatePhoneNumber);
      return false;
    } else if (!Common.validateEmail(email)) {
      Common.showToastCenter(AppLocalizations.of(context)!.textValidateEmail);
      return false;
    }
    return true;
  }
}
