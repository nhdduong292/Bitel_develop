import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/home_sale_model.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../utils/common.dart';

class SaleLogic extends GetxController {
  HomeSaleModel homeSaleModel = HomeSaleModel();
  int indexSelect = -1;
  bool isLoading = false;
  BuildContext context;

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
      OptionSale(AppImages.icSaleRechargeAnypay,
          AppLocalizations.of(context)!.textRechargeAnypay, "", "", 0),
      OptionSale(AppImages.icSaleSearchRequest,
          AppLocalizations.of(context)!.textSearchRequest, "", "", 0),
      OptionSale(AppImages.icSaleClearDebt,
          AppLocalizations.of(context)!.textClearDebt, "", "", 0),
      OptionSale(AppImages.icSaleCreateContact,
          AppLocalizations.of(context)!.textCreateContact, "", "", 0),
    ];
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
    ];
  }

  List<OptionSale> getListKPICommission(BuildContext context) {
    return [
      OptionSale(
          "",
          AppLocalizations.of(context)!.textKPI,
          "${homeSaleModel.kpi}",
          AppLocalizations.of(context)!.textContractMonth,
          6),
      OptionSale(
          "",
          AppLocalizations.of(context)!.textPerformance,
          "${homeSaleModel.performance}",
          AppLocalizations.of(context)!.textContract,
          7),
      OptionSale("", AppLocalizations.of(context)!.textCommission,
          "${homeSaleModel.commission}", "S", 8),
    ];
  }

  List<OptionSale> getListWalletControl(BuildContext context) {
    return [
      OptionSale("", AppLocalizations.of(context)!.textAnyPay,
          "${homeSaleModel.anyPayBalance}", "S", 9),
    ];
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHomeSale();
  }

  double getPerformanceKPI() {
    if (homeSaleModel.performance == 0 || homeSaleModel.kpi == 0) {
      return 0;
    }
    return (homeSaleModel.performance / homeSaleModel.kpi) * 100;
  }

  void getHomeSale() {
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_HOME_SALE,
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
        if (error != null) {
          if (error is DioError && error.response!.data['errorCode'] != null) {
            Common.showMessageError(error.response!.data['errorCode'], context);
          } else {
            print("Error: "+error.toString());
          }
        }
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
