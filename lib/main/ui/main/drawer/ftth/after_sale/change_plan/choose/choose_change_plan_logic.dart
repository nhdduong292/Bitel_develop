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
import '../../../../../../../networks/model/plan_ott_model.dart';
import '../../../../../../../networks/model/request_ott_service_model.dart';
import '../../../../../../../services/connection_service.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  List<PlanOttModel> listPlanOTT = [];
  List<int> listSelectOtt = [];
  var valueOTT = (-1).obs; //index cua promotion

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
            productChangePlanModel.newPlan[valueProduct.value].productCode,
        "ottServices": getListOTTService()
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

  void checkSim(String value, var isSuccess) {
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CHECK_SIM,
      params: {
        "isdn": value,
      },
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          isSuccess(true);
        } else {
          isSuccess(false);
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        Get.back();
        isSuccess(false);
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void getOTTService() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    try {
      ApiUtil.getInstance()!.get(
        url:
            '${ApiEndPoints.API_GET_OTT}/${productChangePlanModel.newPlan[valueProduct.value].productId}',
        params: {
          "planId":
              productChangePlanModel.newPlan[valueProduct.value].productId,
        },
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            listPlanOTT = (response.data['data'] as List)
                .map((postJson) => PlanOttModel.fromJson(postJson))
                .toList();
            for (var model in listPlanOTT) {
              int index = listPlanOTT.indexOf(model);
              listSelectOtt.add(index);
            }
            update();
          } else {
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          Get.back();
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString(), context);
    }
  }

  void onChangePhoneNumber(String value, PlanOttModel ott) {
    if (value.length == 9) {
      checkSim(value, (isSuccess) {
        if (!isSuccess) {
          ott.focusNode!.requestFocus();
          ott.isSuccess = false;
          ott.errorText = AppLocalizations.of(context)!.textISdnIsNotFromBitel;
        } else {
          FocusScope.of(context).requestFocus(FocusNode());
          ott.errorText = null;
          ott.isSuccess = true;
          ott.isdn = value;
        }
        update();
      });
    }
  }

  void resetPlanOTTs() {
    listSelectOtt.clear();
    listPlanOTT.clear();
    valueOTT.value = -1;
  }

  List<RequestOTTServiceModel> getJsonOTTService() {
    List<RequestOTTServiceModel> list = [];
    for (int value in listSelectOtt) {
      list.add(RequestOTTServiceModel(
          ottService: listPlanOTT[value].ottService,
          ottCode: listPlanOTT[value].listSubOtt[0].ottCode,
          isdn: listPlanOTT[value].isdn,
          promotionIds: []));
    }
    return list;
  }

  List<String> getListOTTService() {
    List<String> list = [];
    for (int value in listSelectOtt) {
      list.add(listPlanOTT[value].ottService);
    }
    return list;
  }
}
