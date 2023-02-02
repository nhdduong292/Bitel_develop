import 'package:bitel_ventas/main/ui/main/activate_prepaid_pages/town_center_publicity_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'customer_info_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActivatePrepaidLogic extends GetxController {
  late BuildContext context;
  void gotoNextStep({required int step}) {
    switch (step) {
      case 2:
        Get.to(() => CustomerInfoPage());
        break;
      case 3:
        Get.to(() => TownCenterPublicityPage());
        break;
      case 4:
      case 5:
      case 6:
      case 7:
    }
  }

  RxList<Step1Choices> choices = RxList<Step1Choices>();
  var step1Choice1Checked = false.obs;
  var step1Choice2Checked = false.obs;
  var step3Choice1Checked = false.obs;
  var step3Choice2Checked = false.obs;
  var step3Choice3Checked = false.obs;
  var step3Choice4Checked = false.obs;
  var step3Choice5Checked = false.obs;

  void addChoicesStep1(Step1Choices choice) {
    if (choices.contains(choice)) {
      choices.remove(choice);
    } else {
      choices.add(choice);
    }
  }

  Rx<String> groupSendDocumentValue = "Email".obs;
  final sendDocumentValues = ['Email', "SMS"];
  var chosenTownCenterModel = Rxn<TownCenter>();
  final listTownCenters = [
    TownCenter(name: 'TC1', coverage: true),
    TownCenter(name: 'TC2', coverage: false),
    TownCenter(name: 'TC3', coverage: false),
  ];

}

class TownCenter {
  String name;
  bool coverage;

  TownCenter({required this.name, required this.coverage});
}

enum Step1Choices { checkBox1, checkbox2 }


