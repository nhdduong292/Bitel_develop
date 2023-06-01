import 'package:bitel_ventas/main/networks/model/cancel_service_infor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../networks/model/change_plan_infor_model.dart';

class ChangePlanSuccessLogic extends GetxController {
  late BuildContext context;

  ChangePlanSuccessLogic({required this.context});

  ChangePlanInforModel model = ChangePlanInforModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    model = data[0];
  }

  String getTextBillCycle() {
    if (model.billCycle == 'CYCLE6') {
      return '${AppLocalizations.of(context)!.textCiclo} 6';
    } else if (model.billCycle == 'CYCLE16') {
      return '${AppLocalizations.of(context)!.textCiclo} 16';
    } else {
      return '${AppLocalizations.of(context)!.textCiclo} 26';
    }
  }
}
