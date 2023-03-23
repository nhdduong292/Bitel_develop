import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../utils/common.dart';

class TransactionInformationLogic extends GetxController {
  BuildContext context;
  final FocusScopeNode focusScopeNode = FocusScopeNode();

  TextEditingController textAmountController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textCaptchaController = TextEditingController();

  bool isActiveButton = false;
  String? errorTextAmount;

  TransactionInformationLogic({required this.context});

  void checkValidate() {
    errorTextAmount = null;
    if (textAmountController.text.isEmpty) {
      isActiveButton = false;
      update();
      return;
    }
    var amount = textAmountController.text.replaceAll(',', '.');
    if (!(double.parse(amount) >= 100 && double.parse(amount) <= 10000)) {
      isActiveButton = false;
      errorTextAmount = 'The minimum is 100 and the maximum is 10000';
      update();
      return;
    } else if (textCaptchaController.text.isEmpty) {
      isActiveButton = false;
      update();
      return;
    }

    isActiveButton = true;
    update();
  }

  bool validateEmail() {
    if (textEmailController.text.isEmpty) {
      return true;
    }
    if (!Common.validateEmail(textEmailController.text)) {
      Common.showToastCenter(AppLocalizations.of(context)!.textValidateEmail);
      return false;
    }
    return true;
  }
}
