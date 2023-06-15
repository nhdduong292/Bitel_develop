import 'dart:convert';
import 'dart:math';

import 'package:bitel_ventas/main/networks/model/clear_debt_model.dart';
import 'package:bitel_ventas/main/networks/model/debt_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/view_item/search/search_clear_debt_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../networks/api_end_point.dart';
import '../../../../../../networks/api_util.dart';
import '../../../../../../services/connection_service.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';

class ClearDebtDetailLogic extends GetxController {
  late BuildContext context;

  var selectService = (-1).obs;
  List<int> listSelect = [];
  double totalService = 0.0;
  bool isActiveButton = false;

  List<ClearDebtModel> listClearDebt = [];
  List<ClearDebtModel> listSelectClearDebt = [];

  ClearDebtLogic clearDebtLogic = Get.find();

  ClearDebtDetailLogic({required this.context});

  int oldSelect = -1;
  int newSelect = -1;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listClearDebt = clearDebtLogic.listClearDebt;
  }

  bool isEnoughPayment() {
    // if (clearDebtLogic.balance > totalService) {
    //   return true;
    // } else {
    //   return false;
    // }
    return Random().nextBool();
  }

  void setupListSelect() {
    listSelectClearDebt.clear();
    listSelect.map((e) {
      listSelectClearDebt.add(listClearDebt[e]);
    }).toList();
  }

  void getDebt({required int index}) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    listClearDebt[index].isLoadingListDebt = true;
    listClearDebt[index].list = [];
    update();
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_GET_DEBT}/${listClearDebt[index].isdn}',
      onSuccess: (response) {
        if (response.isSuccess) {
          listClearDebt[index].isLoadingListDebt = false;
          listClearDebt[index].list = (response.data["data"] as List)
              .map((postJson) => DebtModel.fromJson(postJson))
              .toList();
          update();
        } else {}
      },
      onError: (error) {
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void postClearDebt({required var isSuccess}) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    setupListSelect();
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_POST_CLEAR_DEBT,
      body: {'lst': json.decode(jsonEncode(listSelectClearDebt)), 'opt': ''},
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
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

  void checkBalance(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CHECK_BALANCE,
      params: {"amount": totalService},
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          onSuccess(true);
        } else {
          onSuccess(false);
        }
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
        try {
          String errorCode = error.response!.data['errorCode'];
          if (errorCode == 'E028') {
            onSuccess(false);
          }
          // ignore: empty_catches
        } catch (e) {}
      },
    );
  }

  void resendOTP(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_RESEND_OTP,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          onSuccess(true);
        } else {
          onSuccess(false);
        }
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
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
