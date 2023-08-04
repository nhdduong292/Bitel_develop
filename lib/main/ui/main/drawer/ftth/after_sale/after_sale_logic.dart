import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/values.dart';
import '../../utilitis/info_bussiness.dart';

class AfterSaleLogic extends GetxController {
  BuildContext context;
  AfterSaleLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  bool isShowChangePlan() {
    var listPermission = InfoBusiness.getInstance()!.getUser().functions;
    if (listPermission.contains(UserPermission.CHANGE_PLAN)) {
      return true;
    } else {
      return false;
    }
  }

  bool isShowTransferService() {
    var listPermission = InfoBusiness.getInstance()!.getUser().functions;
    if (listPermission.contains(UserPermission.TRANSFER_SERVICE)) {
      return true;
    } else {
      return false;
    }
  }

  bool isShowCancelService() {
    var listPermission = InfoBusiness.getInstance()!.getUser().functions;
    if (listPermission.contains(UserPermission.CANCEL_SERVICE)) {
      return true;
    } else {
      return false;
    }
  }
}
