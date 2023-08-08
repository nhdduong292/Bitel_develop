import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:bitel_ventas/main/networks/model/clear_debt_model.dart';
import 'package:bitel_ventas/main/networks/model/search_clear_debt_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../networks/api_end_point.dart';
import '../../../../../../networks/api_util.dart';
import '../../../../../../networks/model/captcha_model.dart';
import '../../../../../../services/connection_service.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';

class SearchClearDebtLogic extends GetxController {
  late BuildContext context;
  var balance = (0.0).obs;

  final FocusScopeNode focusScopeNode = FocusScopeNode();
  ClearDebtLogic clearDebtLogic = Get.find();

  SearchClearDebtLogic({required this.context});

  bool isActive = true;
  List<String> listIdentity = ["DNI", "CE", "PP"];
  String currentStatus = "";
  String currentIdentityType = "";
  String currentPhone = "";
  String currentAccount = "";
  String currentIdNumber = "";
  TextEditingController textFieldEnter = TextEditingController();
  TextEditingController textCapchaControl = TextEditingController();
  String currentEnter = "";
  String currentCapcha = "";
  CaptchaModel captchaModel = CaptchaModel();
  SearchClearDebtModel searchClearDebtModel = SearchClearDebtModel();
  List<ClearDebtModel> listClearDebt = [];

  bool isGetCaptchaDone = false;
  String generatedCaptcha = '';
  String searchType = '';
  List<String> getListStatus() {
    return [
      AppLocalizations.of(context)!.textIdentityNumber,
      AppLocalizations.of(context)!.textFTTHAccount,
      AppLocalizations.of(context)!.textPhoneNumber,
      AppLocalizations.of(context)!.textServiceNumber
    ];
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    currentStatus = getListStatus()[0];
    currentIdentityType = listIdentity[0];
    getWallet();
    getCaptcha();
    update();
  }

  void setStatus(String value) {
    reset();
    currentStatus = value;
    update();
  }

  void setIdentity(String value) {
    currentIdentityType = value;
    update();
  }

  void setActiveButton(bool value) {
    isActive = value;
    update();
  }

  void setEnter(String value) {
    currentEnter = value;
    if (currentStatus == getListStatus()[0]) {
      currentIdNumber = value;
    } else if (currentStatus == getListStatus()[1]) {
      currentAccount = value;
    } else {
      currentPhone = value;
    }
    if (currentEnter.isNotEmpty && currentCapcha.isNotEmpty) {
      setActiveButton(false);
    } else {
      setActiveButton(true);
    }
    if ((currentIdNumber.length < 8 && currentIdentityType == "DNI") ||
        (currentIdNumber.length < 9 && currentIdentityType == "CE") ||
        (currentIdNumber.length < 6 && currentIdentityType == "PP")) {
      setActiveButton(true);
    }
    update();
  }

  void setCapcha(String value) {
    currentCapcha = value;
    if (currentEnter.isNotEmpty && currentCapcha.isNotEmpty) {
      setActiveButton(false);
    } else {
      setActiveButton(true);
    }
    if ((currentIdNumber.length < 8 && currentIdentityType == "DNI") ||
        (currentIdNumber.length < 9 && currentIdentityType == "CE") ||
        (currentIdNumber.length < 6 && currentIdentityType == "PP")) {
      setActiveButton(true);
    }
    update();
  }

  void getWallet() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_WALLET,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          balance.value = response.data['data'] as double;
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        Common.showMessageError(error: error, context: context);
        Get.back();
      },
    );
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

  int getMaxLengthIdNumber(String value) {
    if (value == listIdentity[0]) {
      return 8;
    } else if (value == listIdentity[2]) {
      return 15;
    } else {
      return 9;
    }
  }

  void reset() {
    currentAccount = '';
    currentIdNumber = '';
    currentPhone = '';
  }

  void getCaptcha() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isGetCaptchaDone = true;
      update();
      return;
    }
    isGetCaptchaDone = false;
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_GET_CAPTCHA,
      params: {'action': 'CLEAR_DEBT'},
      onSuccess: (response) {
        if (response.isSuccess) {
          captchaModel = CaptchaModel.fromJson(response.data['data']);
          isGetCaptchaDone = true;
          update();
        } else {}
      },
      onError: (error) {
        // Common.showMessageError(error: error, context: context);
        isGetCaptchaDone = true;
        generatedCaptcha = generateCaptchaString();
        update();
      },
    );
  }

  Uint8List convertImageCaptcha() {
    try {
      var data = captchaModel.base64Img!.split(',');
      return base64Decode(data[1]);
    } catch (e) {
      return base64Decode(captchaModel.base64Img!);
    }
  }

  bool isStatusIdentity() {
    if (currentStatus == getListStatus()[0]) {
      return true;
    }
    return false;
  }

  void searchClearDebt({required var isSuccess}) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_SEARCH_CLEAR_DEBT,
      params: {
        'type': getSearchType(),
        'idType': isStatusIdentity() ? currentIdentityType : '',
        'value': currentEnter.trim(),
        'captcha': currentCapcha,
      },
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          listClearDebt = (response.data["data"] as List)
              .map((postJson) => ClearDebtModel.fromJson(postJson))
              .toList();

          isSuccess(true);
        } else {
          isSuccess(false);
        }
      },
      onError: (error) {
        Get.back();
        isSuccess(false);
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  String generateCaptchaString() {
    String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    String captcha = '';

    for (int i = 0; i < 4; i++) {
      int index = random.nextInt(chars.length);
      captcha += chars[index];
    }

    return captcha;
  }

  String getSearchType() {
    if (currentStatus == AppLocalizations.of(context)!.textIdentityNumber) {
      searchType = ClearDebtSearchType.ID_NUMBER;
    } else if (currentStatus == AppLocalizations.of(context)!.textFTTHAccount) {
      searchType = ClearDebtSearchType.ACCOUNT;
    } else if (currentStatus == AppLocalizations.of(context)!.textPhoneNumber) {
      searchType = ClearDebtSearchType.PHONE_NUMBER;
    } else if (currentStatus ==
        AppLocalizations.of(context)!.textServiceNumber) {
      searchType = ClearDebtSearchType.SERVICE_CODE;
    }
    return searchType;
  }
}
