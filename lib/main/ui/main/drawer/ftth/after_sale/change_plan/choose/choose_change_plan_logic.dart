import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:bitel_ventas/main/networks/model/product_change_plan_model.dart';
import 'package:bitel_ventas/main/networks/model/reasons_cancel_service_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_logic.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../../../../../../networks/model/check_payment_change_plan_model.dart';
import '../../../../../../../networks/model/promotion_model.dart';
import '../../../../../../../services/connection_service.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';

class ChooseChangePlanLogic extends GetxController {
  BuildContext context;

  ChooseChangePlanLogic({required this.context});

  ProductChangePlanModel productChangePlanModel = ProductChangePlanModel();

  CheckPaymentChangePlanModel checkPaymentChangePlanModel =
      CheckPaymentChangePlanModel();
  var valueProduct = (-1).obs; // index cua product

  int subId = 0;
  bool isForcedTerm = false;
  int fingerId = 0;

  bool isLoadingPromotion = true;
  List<PromotionModel> listPromotion = [];
  List<int> listIdPromotion = [];

  AfterSaleSearchLogic afterSaleSearchLogic = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    var data = Get.arguments;
    subId = data[0];
    fingerId = afterSaleSearchLogic.fingerId;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getProduct();
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

  void getProduct() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_GET_PRODUCT_CHANGE_PLAN,
      params: {"subId": subId},
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          productChangePlanModel =
              ProductChangePlanModel.fromJson(response.data['data']);
          update();
          print(response.data['data']);
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void getPayment(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_GET_PAYMENT_CHANGE_PLAN,
      params: {
        "subId": subId,
        "newPlan":
            productChangePlanModel.newPlan[valueProduct.value].productCode
      },
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          checkPaymentChangePlanModel =
              CheckPaymentChangePlanModel.fromJson(response.data['data']);
          onSuccess(true);
        } else {
          onSuccess(false);
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        Get.back();
        onSuccess(false);
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  bool checkValidate() {
    if (valueProduct.value < 0) {
      return false;
    }
    return true;
  }

  bool isUndetermined(String type) {
    if (productChangePlanModel.contractType == type) {
      if (type == ContractType.FORCED_TERM) {
        isForcedTerm = true;
      } else {
        isForcedTerm = false;
      }
      return true;
    } else {
      return false;
    }
  }

  void getPromotions() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    isLoadingPromotion = true;
    update();
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_GET_PROMOTION_CHANGE_PLAN,
      params: {
        'productId':
            productChangePlanModel.newPlan[valueProduct.value].productId,
        'subId': subId
      },
      onSuccess: (response) {
        isLoadingPromotion = false;
        if (response.isSuccess) {
          listPromotion = (response.data['data'] as List)
              .map((postJson) => PromotionModel.fromJson(postJson))
              .toList();
          getListIdPromotion();
        } else {
          print("error: ${response.status}");
        }
        update();
      },
      onError: (error) {
        isLoadingPromotion = false;
        update();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void getListIdPromotion() {
    listIdPromotion.clear();
    for (var promotion in listPromotion) {
      listIdPromotion.add(promotion.proId ?? 0);
    }
  }

  void resetPromotions() {
    listPromotion.clear();
  }
}
