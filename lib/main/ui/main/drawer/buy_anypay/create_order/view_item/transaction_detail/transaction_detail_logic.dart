import 'package:bitel_ventas/main/networks/model/buy_anypay_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/buy_anypay/create_order/create_order_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';

class TransactionDetailLogic extends GetxController {
  BuildContext context;

  bool isCheckBox = false;
  CreateOrderLogic createOrderLogic = Get.find();

  BuyAnyPayModel buyAnyPayModel = BuyAnyPayModel();

  TransactionDetailLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    buyAnyPayModel = createOrderLogic.buyAnyPayModel;
  }

  void postConfirmBuyAnyPay({var isSuccess}) {
    _onLoading(context);
    Map<String, dynamic> body = {
      "saleOrderId": buyAnyPayModel.saleOrderId,
      "code": buyAnyPayModel.code,
      "idNumber": buyAnyPayModel.idNumber,
      "name": buyAnyPayModel.name,
      "amount": buyAnyPayModel.amount,
      "discount": buyAnyPayModel.discount,
      "total": buyAnyPayModel.total,
      "email": null,
      "captcha": null
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_CONFIRM_POST_BUY_ANYPAY,
      body: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          buyAnyPayModel = BuyAnyPayModel.fromJson(response.data['data']);
          isSuccess(true);
        } else {
          isSuccess(false);
        }
      },
      onError: (error) {
        Get.back();
        isSuccess(false);
        Common.showMessageError(error, context);
      },
    );
  }

  void setBuyAnyPayModel() {
    createOrderLogic.buyAnyPayModel = buyAnyPayModel;
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
