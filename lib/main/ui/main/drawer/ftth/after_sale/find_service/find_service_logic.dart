import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FindServiceLogic extends GetxController {
  bool isActive = true;
  List<String> listIdentity = ["DNI", "CE", "PP", "PTP"];
  String currentStatus = "";
  BuildContext context;
  String currentIdentityType = "";
  TextEditingController textFieldEnter = TextEditingController();
  String currentEnter = "";


  FindServiceLogic(this.context);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    currentStatus = getListStatus()[0];
    currentIdentityType = listIdentity[0];
    update();
  }

  void setStatus(String value) {
    currentStatus = value;
    update();
  }

  void setIdentity(String value){
    currentIdentityType = value;
    update();
  }

  void setActiveButton(bool value) {
    isActive = value;
    update();
  }

  void setEnter(String value){
    currentEnter = value;
    if(currentEnter.isNotEmpty){
      setActiveButton(false);
    } else {
      setActiveButton(true);
    }
    update();
  }

  List<String> getListStatus() {
    return [
      AppLocalizations.of(context)!.textIdentityNumber,
      AppLocalizations.of(context)!.textFTTHAccount,
      AppLocalizations.of(context)!.textPhoneNumber
    ];
  }
}
