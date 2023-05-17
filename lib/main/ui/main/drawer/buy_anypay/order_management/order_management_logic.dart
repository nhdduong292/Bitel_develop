import 'package:bitel_ventas/main/networks/model/buy_anypay_comfirm_model.dart';
import 'package:bitel_ventas/main/networks/model/buy_anypay_create_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import '../../../../../networks/model/buy_anypay_search_model.dart';
import '../../../../../utils/common.dart';
import '../../../../../utils/common_widgets.dart';

class OrderManagementLogic extends GetxController {
  BuildContext context;
  var from = "".obs;
  var to = "".obs;
  DateTime selectDate = DateTime.now();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  String currentStatus = '';
  String textBankCode = '';

  bool isSearched = false;
  bool isLoading = true;

  List<BuyAnyPaySearchModel> listBuyAnyPay = [];

  OrderManagementLogic({required this.context});

  List<String> getListStatus() {
    return [
      AppLocalizations.of(context)!.textAll,
      AppLocalizations.of(context)!.textNew,
      AppLocalizations.of(context)!.textPaid,
      AppLocalizations.of(context)!.textSold,
      AppLocalizations.of(context)!.textCanceled
    ];
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    currentStatus = AppLocalizations.of(context)!.textAll;
    setFromDate(fromDate.subtract(const Duration(days: 30)));
    setToDate(toDate);
    update();
  }

  void setStatus(String value) {
    currentStatus = value;
    update();
  }

  void setToDate(DateTime picked) {
    // print("Date: "+picked.toString());
    toDate = picked;
    var date = "${picked.day}/${picked.month}/${picked.year}";
    // searchRequest.toDate = picked.toIso8601String();
    if (!compareToDate(to: date)) {
      Common.showToastCenter(AppLocalizations.of(context)!.textInvalidDate);
      return;
    }
    to.value = date;
    update();
  }

  void setFromDate(DateTime picked) {
    // print("Date: "+picked.toString());
    // print("Date: "+picked.toIso8601String());
    fromDate = picked;
    var date = "${picked.day}/${picked.month}/${picked.year}";
    if (!compareToDate(from: date)) {
      Common.showToastCenter(AppLocalizations.of(context)!.textInvalidDate);
      return;
    } else {}
    // searchRequest.fromDate = picked.toIso8601String();
    // DateTime pi = DateTime.parse(picked.toIso8601String());
    from.value = date;
    update();
  }

  // so sanh date of birth voi expried date
  bool compareToDate({String? from, String? to}) {
    if (this.to.value.isEmpty || this.from.value.isEmpty) {
      return true;
    }
    from = from ?? this.from.value;
    to = to ?? this.to.value;
    DateFormat formatter = DateFormat("dd/MM/yyyy");

    DateTime date1 = formatter.parse(from);
    DateTime date2 = formatter.parse(to);

    int result = date1.compareTo(date2);

    if (result < 0) {
      return true;
    } else if (result > 0) {
      return false;
    } else {
      return false;
    }
  }

  String? getCodeStatus(String status) {
    if (status == getListStatus()[0]) {
      return null;
    } else if (status == getListStatus()[1]) {
      return 'NEW';
    } else if (status == getListStatus()[2]) {
      return 'PAID';
    } else if (status == getListStatus()[3]) {
      return 'SOLD';
    } else if (status == getListStatus()[4]) {
      return 'CANCELED';
    }
    return null;
  }

  void searchBuyAnyPay(
      {String? bankCode,
      required status,
      required String from,
      required String to}) {
    isLoading = true;
    update();
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_SEARCH_BUY_ANYPAY,
      params: {
        'bankCode': bankCode,
        'status': getCodeStatus(status),
        'from': formatDateIso(from),
        'to': formatDateIso(to),
        'page': 0,
        'pageSize': 10,
        'sort': 'createdDate'
      },
      onSuccess: (response) {
        isLoading = false;
        if (response.isSuccess) {
          listBuyAnyPay = (response.data['data'] as List)
              .map((postJson) => BuyAnyPaySearchModel.fromJson(postJson))
              .toList();
          update();
        } else {}
      },
      onError: (error) {
        isLoading = false;
        update();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void deleteBuyAnyPay({required String saleOrderId, required var isSuccess}) {
    _onLoading(context);
    ApiUtil.getInstance()!.delete(
      url: ApiEndPoints.API_DELETE_BUY_ANYPAY
          .replaceAll('saleOrderId', saleOrderId),
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

  String formatDateIso(String date) {
    DateTime dateTime = DateFormat('dd/MM/yyyy').parse(date);
    String isoString = dateTime.toIso8601String();
    return isoString;
  }

  String getTextStatus(String status) {
    if (status == 'NEW') {
      return AppLocalizations.of(context)!.textNew;
    } else if (status == 'PAID') {
      return AppLocalizations.of(context)!.textPaid;
    } else if (status == 'SOLD') {
      return AppLocalizations.of(context)!.textSold;
    } else {
      return AppLocalizations.of(context)!.textCanceled;
    }
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
