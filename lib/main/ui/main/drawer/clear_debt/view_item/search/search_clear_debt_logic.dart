import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../networks/api_end_point.dart';
import '../../../../../../networks/api_util.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';

class SearchClearDebtLogic extends GetxController {
  late BuildContext context;
  var balance = (0.0).obs;

  final FocusScopeNode focusScopeNode = FocusScopeNode();
  ClearDebtLogic clearDebtLogic = Get.find();

  SearchClearDebtLogic({required this.context});

  bool isActive = true;
  List<String> listIdentity = ["DNI", "CE", "PP", "PTP"];
  String currentStatus = "";
  String currentIdentityType = "";
  TextEditingController textFieldEnter = TextEditingController();
  TextEditingController textCapchaControl = TextEditingController();
  String currentEnter = "";
  String currentCapcha = "";

  List<String> getListStatus() {
    return [
      AppLocalizations.of(context)!.textIdentityNumber,
      AppLocalizations.of(context)!.textFTTHAccount,
      AppLocalizations.of(context)!.textPhoneNumber
    ];
  }

  @override
  void onInit() {
    // TODO: implement onInit
    currentStatus = getListStatus()[0];
    currentIdentityType = listIdentity[0];
    update();
  }

  void setStatus(String value) {
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
    if (currentEnter.isNotEmpty && currentCapcha.isNotEmpty) {
      setActiveButton(false);
    } else {
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
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getWallet(context);
  }

  void getWallet(BuildContext context) {
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
        Common.showMessageError(error['errorCode'], context);
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
}
