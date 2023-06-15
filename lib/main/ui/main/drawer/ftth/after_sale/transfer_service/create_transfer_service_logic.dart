import 'dart:async';

import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:bitel_ventas/main/networks/model/reasons_cancel_service_model.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../networks/api_end_point.dart';
import '../../../../../../networks/api_util.dart';
import '../../../../../../networks/model/address_model.dart';
import '../../../../../../networks/model/cancel_service_model.dart';
import '../../../../../../services/connection_service.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';

class CreateTransferServiceLogic extends GetxController {
  BuildContext context;
  FindAccountModel findAccountModel = FindAccountModel();
  bool isActive = true;
  DateTime selectDate = DateTime.now().add(const Duration(days: 7));
  DateTime? datePicker;
  var fromDate = "".obs;
  var toDate = "".obs;
  bool isCheckAgree = true;
  String cancelDate = '';
  CreateTransferServiceLogic({required this.context});
  RequestDetailModel requestModel = RequestDetailModel();
  List<ReasonCancelServiceModel> listReasons = [];
  TextEditingController tfNote = TextEditingController();
  String reasonCancel = '';
  int fingerId = 0;

  TextEditingController textFieldArea = TextEditingController();
  List<AddressModel> listArea = [];
  AddressModel currentArea = AddressModel();
  FocusNode focusAddress = FocusNode();
  TextEditingController textFieldAddress = TextEditingController();
  String currentAddress = "";
  AfterSaleSearchLogic afterSaleSearchLogic = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    findAccountModel = data[0];
    fingerId = afterSaleSearchLogic.fingerId;
    setToDate(DateTime.now());
  }

  DateTime getCurrentDate() {
    if (datePicker != null) {
      return datePicker!;
    } else {
      return DateTime.now();
    }
  }

  void setNote(String note) {
    reasonCancel = note;
    update();
  }

  void createTransfer(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    Map<String, dynamic> body = {
      'subId': findAccountModel.subId,
      "province": currentArea.province,
      "district": currentArea.district,
      "precinct": currentArea.precinct,
      "address": currentAddress,
      'operationDate': datePicker?.toIso8601String().substring(0, 10),
      'reason': reasonCancel.trim()
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_CREATE_TRANSFER,
      body: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          requestModel = RequestDetailModel.fromJson(response.data['data']);
          onSuccess(true);
        } else {
          print("error: ${response.status}");
          onSuccess(false);
        }
        update();
      },
      onError: (error) {
        Get.back();
        onSuccess(false);
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

  void setFromDate(DateTime picked) {
    fromDate.value = "${picked.day}/${picked.month}/${picked.year}";
    update();
  }

  void setToDate(DateTime picked) {
    cancelDate = "${picked.day}/${picked.month}/${picked.year}";
    datePicker = picked;
    update();
  }

  void setDateNow() {
    selectDate = DateTime.now().add(const Duration(days: 7));
  }

  void setCheckAgree(bool value) {
    isCheckAgree = value;
    update();
  }

  bool checkActiveContinue() {
    if (cancelDate.isNotEmpty &&
        isCheckAgree &&
        currentArea.province.isNotEmpty &&
        currentArea.district.isNotEmpty &&
        currentArea.precinct.isNotEmpty &&
        currentAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<AddressModel>> getAreas(String query) async {
    Completer<List<AddressModel>> completer = Completer();
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return completer.future;
    }
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_SEARCH_AREAS,
        params: {'key': query},
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listArea = (response.data['data'] as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            completer.complete(listArea);
          } else {
            print("error: ${response.status}");
            completer.complete([]);
          }
        },
        onError: (error) {
          Common.showMessageError(error: error, context: context);
          completer.complete([]);
          // callBack.call(false);
        });
    return completer.future;
  }

  void setAddress(String value) {
    currentAddress = value;
    update();
  }
}
