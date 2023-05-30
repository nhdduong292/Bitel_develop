import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ReSignContractLogic extends GetxController {
  late BuildContext context;

  var checkMainContract = true.obs;
  var checkLendingContract = false.obs;
  var checkOption = true.obs;

  RequestDetailLogic requestDetailLogic = Get.find();

  ReSignContractLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
