import 'package:bitel_ventas/main/networks/model/buy_anypay_comfirm_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/buy_anypay/create_order/create_order_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../../../../../../networks/model/buy_anypay_create_model.dart';
import '../../../../../../../services/connection_service.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';

class TransactionDetailLogic extends GetxController {
  BuildContext context;

  bool isCheckBox = false;
  CreateOrderLogic createOrderLogic = Get.find();

  BuyAnyPayCreateModel buyAnyPayCreateModel = BuyAnyPayCreateModel();

  TransactionDetailLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    buyAnyPayCreateModel = createOrderLogic.buyAnyPayCreateModel;
  }

  void postCreateBuyAnyPay({var isSuccess}) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_CONFIRM_POST_BUY_ANYPAY,
      body: createOrderLogic.bodyRequestBuyAnyPay,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          buyAnyPayCreateModel =
              BuyAnyPayCreateModel.fromJson(response.data['data']);
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

  void setBuyAnyPayModel() {
    createOrderLogic.buyAnyPayCreateModel = buyAnyPayCreateModel;
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
