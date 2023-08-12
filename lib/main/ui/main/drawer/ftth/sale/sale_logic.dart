import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/home_sale_model.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../services/connection_service.dart';
import '../../../../../utils/common.dart';
import '../../utilitis/info_bussiness.dart';

class SaleLogic extends GetxController {
  HomeSaleModel homeSaleModel = HomeSaleModel();
  int indexSelect = -1;
  bool isLoading = false;
  BuildContext context;

  DateTime now = DateTime.now();

  String fromDate = '';
  String toDate = '';

  List<String> getMonthFilterItems() {
    return [
      AppLocalizations.of(context)!.textThisMonth,
      AppLocalizations.of(context)!.textLastMonth,
      AppLocalizations.of(context)!.textLast3Month
    ];
  }

  RxString selectedMonthFilter = "".obs;

  SaleLogic({required this.context});

  void setIndexSelect(int value) {
    indexSelect = value;
    update();
  }

  List<OptionSale> getListOptionSale(BuildContext context) {
    return [
      OptionSale(AppImages.icSaleCreateRequest,
          AppLocalizations.of(context)!.textCreateRequest, "", "", 0),
      OptionSale(AppImages.icSaleConnectSubscriber,
          AppLocalizations.of(context)!.textConnectSubscriber, "", "", 0),
      OptionSale(AppImages.icSaleSearchRequest,
          AppLocalizations.of(context)!.textSearchRequest, "", "", 0),
      OptionSale(AppImages.icSaleRechargeAnypay,
          AppLocalizations.of(context)!.textRechargeAnypay, "", "", 0),
      OptionSale(AppImages.icSaleClearDebt,
          AppLocalizations.of(context)!.textClearDebt, "", "", 0),
      // OptionSale(AppImages.icSaleCreateContact,
      //     AppLocalizations.of(context)!.textCreateContact, "", "", 0),
    ];
  }

  List<OptionSale> getListOptionSaleWithPermission() {
    var list = getListOptionSale(context);
    var listPermission = InfoBusiness.getInstance()!.getUser().functions;
    if (!listPermission.contains(UserPermission.CONTRACTING)) {
      list.removeWhere((element) =>
          element.title == AppLocalizations.of(context)!.textConnectSubscriber);
    }
    if (!listPermission.contains(UserPermission.CREATE_REQUEST)) {
      list.removeWhere((element) =>
          element.title == AppLocalizations.of(context)!.textCreateRequest);
    }
    if (!listPermission.contains(UserPermission.BUY_ANYPAY)) {
      list.removeWhere((element) =>
          element.title == AppLocalizations.of(context)!.textRechargeAnypay);
    }
    if (!listPermission.contains(UserPermission.CLEAR_DEBT)) {
      list.removeWhere((element) =>
          element.title == AppLocalizations.of(context)!.textClearDebt);
    }
    return list;
  }

  void setDate(String month) {
    if (month == AppLocalizations.of(context)!.textThisMonth) {
      fromDate = DateTime(now.year, now.month, 1).toIso8601String();
      toDate = now.toIso8601String();
    } else if (month == AppLocalizations.of(context)!.textLastMonth) {
      final int numberOfDaysInCurrentMonth =
          DateTime(now.year, now.month, 0).day;
      fromDate = DateTime(now.year, now.month - 1, 1).toIso8601String();
      toDate = DateTime(now.year, now.month - 1, numberOfDaysInCurrentMonth)
          .toIso8601String();
    } else if (month == AppLocalizations.of(context)!.textLast3Month) {
      final int numberOfDaysInCurrentMonth =
          DateTime(now.year, now.month, 0).day;
      fromDate = DateTime(now.year, now.month - 3, 1).toIso8601String();
      toDate = DateTime(now.year, now.month - 1, numberOfDaysInCurrentMonth)
          .toIso8601String();
    }
    isLoading = false;
    update();
    getHomeSale();
  }

  List<OptionSale> getListRequestManagement(BuildContext context) {
    return [
      OptionSale("", AppLocalizations.of(context)!.textWaitingSurvey,
          "${homeSaleModel.waitingOfflineSurvey}", "", 1),
      OptionSale("", AppLocalizations.of(context)!.textWaitingConnect,
          "${homeSaleModel.waitingConnection}", "", 2),
      OptionSale("", AppLocalizations.of(context)!.textWaitingDeployment,
          "${homeSaleModel.waitingDeployment}", "", 3),
      OptionSale("", AppLocalizations.of(context)!.textWaitingInstallation,
          "${homeSaleModel.completeInstallation}", "", 4),
      OptionSale("", AppLocalizations.of(context)!.textCancelled,
          "${homeSaleModel.cancelled}", "", 5),
      OptionSale("", AppLocalizations.of(context)!.textWaittingRecovery,
          "${homeSaleModel.waitingRecovery}", "", 6),
      OptionSale("", AppLocalizations.of(context)!.textWaitingChangePlan,
          "${homeSaleModel.waitingChangePlan}", "", 7),
      OptionSale("", AppLocalizations.of(context)!.textWaitingTransfer,
          "${homeSaleModel.waitingTransfer}", "", 8),
    ];
  }

  List<OptionSale> getListKPICommission(BuildContext context) {
    return [
      OptionSale(
          "",
          AppLocalizations.of(context)!.textKPI,
          "${homeSaleModel.kpi}",
          AppLocalizations.of(context)!.textContractMonth,
          9),
      OptionSale(
          "",
          AppLocalizations.of(context)!.textPerformance,
          "${homeSaleModel.performance}",
          AppLocalizations.of(context)!.textSubscriber,
          10),
      OptionSale("", AppLocalizations.of(context)!.textCommission,
          "${homeSaleModel.commission}", "S", 11),
    ];
  }

  List<OptionSale> getListWalletControl(BuildContext context) {
    return [
      OptionSale("", AppLocalizations.of(context)!.textAnyPay,
          "${homeSaleModel.anyPayBalance}", "S", 10),
    ];
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    toDate = now.toIso8601String();
    fromDate = fromDate = DateTime(now.year, now.month, 1).toIso8601String();
    getHomeSale();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    selectedMonthFilter.value = AppLocalizations.of(context)!.textThisMonth;
  }

  void viewWillAppear() {
    isLoading = false;
    update();
    getHomeSale();
  }

  double getPerformanceKPI() {
    if (homeSaleModel.performance == 0 || homeSaleModel.kpi == 0) {
      return 0;
    }
    return double.parse(((homeSaleModel.performance / homeSaleModel.kpi) * 100)
        .toStringAsFixed(1));
  }

  void getHomeSale() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isLoading = true;
      update();
      return;
    }
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_HOME_SALE,
      params: {
        "fromDate": fromDate.substring(0, 10),
        "toDate": toDate.substring(0, 10),
        // "version": Common.getVersionApp()
      },
      onSuccess: (response) {
        // Get.back();
        if (response.isSuccess) {
          print("success");
          homeSaleModel = HomeSaleModel.fromJson(response.data['data']);
        } else {
          print("error: ${response.status}");
        }
        isLoading = true;
        update();
      },
      onError: (error) {
        isLoading = true;
        update();
        Common.showMessageError(error: error, context: context);
      },
    );
  }
}

class OptionSale {
  String icon;

  String title;

  String content;

  String unit;

  int index;

  OptionSale(this.icon, this.title, this.content, this.unit, this.index);
}
