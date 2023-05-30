import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../networks/model/work_order_model.dart';
import '../../../../../utils/common.dart';

class RequestDetailLogic extends GetxController {
  RequestDetailModel requestModel = RequestDetailModel();
  bool isLoading = true;
  String currentId = "";
  String status = "";
  List<String> listArgument = [];
  bool isShowBtnCancelTransfer = false;
  bool isShowBtnConnect = false;
  String textConnect = "";

  BuildContext context;

  RequestDetailLogic(this.context);

  @override
  void onInit() {
    // TODO: implement onInit
    listArgument = Get.arguments;
    currentId = listArgument[0];
    // status = listArgument[1];
    print("id: $currentId status: $status");
    super.onInit();
    getRequestDetail(currentId);
    // isShowBtnConnect = checkShowBtnConnect(status);
    // isShowBtnCancelTransfer = checkShowBtnCancelTransfer(status);
  }

  void getRequestDetail(String id) async {
    Future.delayed(Duration(seconds: 1));
    ApiUtil.getInstance()!.get(
        url: "${ApiEndPoints.API_REQUEST_DETAIL}/$id",
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            requestModel = RequestDetailModel.fromJson(response.data['data']);
            isShowBtnConnect = checkShowBtnConnect(requestModel.status);
            isShowBtnCancelTransfer =
                checkShowBtnCancelTransfer(requestModel.status);
          } else {
            print("error: ${response.status}");
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          isLoading = false;
          update();
          Common.showMessageError(error: error, context: context);
        });
  }

  bool checkShowBtnConnect(String status) {
    if (status == RequestStatus.CREATE_REQUEST) {
      return false;
    } else if (status == RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY) {
      textConnect = AppLocalizations.of(context)!.textConnect;
      return true;
    } else if (status == RequestStatus.SURVEY_OFFLINE_SUCCESSFULLY) {
      textConnect = AppLocalizations.of(context)!.textConnect;
      return true;
    } else if (status == RequestStatus.CONNECTED) {
      textConnect = AppLocalizations.of(context)!.textConnect;
      return true;
    } else if (status == RequestStatus.DEPLOYING) {
      textConnect = AppLocalizations.of(context)!.textClose;
      return true;
    } else if (status == RequestStatus.COMPLETE) {
      textConnect = AppLocalizations.of(context)!.textClose;
      return true;
    } else if (status == RequestStatus.CANCEL) {
      textConnect = AppLocalizations.of(context)!.textClose;
      return true;
    }
    textConnect = AppLocalizations.of(context)!.textConnect;
    return false;
  }

  bool checkShowBtnCancelTransfer(String status) {
    if (status == RequestStatus.CREATE_REQUEST) {
      return true;
    } else if (status == RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY) {
      return true;
    } else if (status == RequestStatus.SURVEY_OFFLINE_SUCCESSFULLY) {
      return true;
    } else if (status == RequestStatus.CONNECTED) {
      return false;
    } else if (status == RequestStatus.DEPLOYING) {
      return false;
    } else if (status == RequestStatus.COMPLETE) {
      return false;
    } else if (status == RequestStatus.CANCEL) {
      return false;
    }
    return false;
  }

  void onClickBtnConnect() {
    if (status == RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY ||
        status == RequestStatus.SURVEY_OFFLINE_SUCCESSFULLY) {
      Get.toNamed(RouteConfig.productPayment);
    } else if (status == RequestStatus.CONNECTED) {
      //todo show dialog cancel
    } else if (status == RequestStatus.DEPLOYING ||
        status == RequestStatus.COMPLETE ||
        status == RequestStatus.CANCEL) {
      Get.back();
    }
  }

  String getStatusContract() {
    if (requestModel.status != RequestStatus.CONNECTED &&
        requestModel.status != RequestStatus.DEPLOYING &&
        requestModel.status != RequestStatus.COMPLETE) {
      return '---';
    }
    if (requestModel.contractModel.status == 0) {
      return AppLocalizations.of(context)!.textStatusContractDelete;
    } else if (requestModel.contractModel.status == 1) {
      return AppLocalizations.of(context)!.textStatusContractNonActive;
    } else if (requestModel.contractModel.status == 2) {
      return AppLocalizations.of(context)!.textStatusContractActive;
    } else if (requestModel.contractModel.status == 3) {
      return AppLocalizations.of(context)!.textStatusContractCancel;
    } else if (requestModel.contractModel.status == 4) {
      return AppLocalizations.of(context)!.textStatusContractTerminat;
    }
    return '---';
  }

  String getTeamName(WorkOrderModel model) {
    if (model.teamCode.isEmpty && model.teamName.isEmpty) {
      return '---';
    } else {
      if (model.teamName.isNotEmpty) {
        return model.teamName;
      } else {
        return model.teamCode;
      }
    }
  }

  String getBillCycle(String billCycle) {
    if (billCycle == 'CYCLE6') {
      return '${AppLocalizations.of(context)!.textCircle} 6';
    } else if (billCycle == 'CYCLE16') {
      return '${AppLocalizations.of(context)!.textCircle} 16';
    } else if (billCycle == 'CYCLE26') {
      return '${AppLocalizations.of(context)!.textCircle} 26';
    }
    return '---';
  }

  String getStaffName(WorkOrderModel model) {
    if (model.staffName.isEmpty && model.staffCode.isEmpty) {
      return '---';
    } else {
      if (model.staffName.isNotEmpty) {
        return model.staffName;
      } else {
        return model.staffCode;
      }
    }
  }
}
