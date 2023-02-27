import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ContractInformationLogic extends GetxController {
  late BuildContext context;
  var checkOption1 = false.obs;
  var checkOption2 = false.obs;
  var checkOption3 = false.obs;
  var checkOption4 = false.obs;

  Rx<String> contractLanguagetValue = 'Espanol'.obs;
  final contractLanguages = [
    'Ashaninka',
    'Aymara',
    'Quechua',
    'Shipobo - konibo',
    'Espanol'
  ];
}
