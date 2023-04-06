import 'package:bitel_ventas/main/networks/model/buy_anypay_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import '../../../../../utils/common.dart';

class OrderManagementLogic extends GetxController {
  BuildContext context;
  var from = "".obs;
  var to = "".obs;
  DateTime selectDate = DateTime.now();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  String currentStatus = '';

  bool isSearched = false;
  bool isLoading = true;

  List<BuyAnyPayModel> listBuyAnyPay = [];

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

  List<AcountBankModel> listBank = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listBank.add(AcountBankModel());
    listBank.add(AcountBankModel());
    listBank.add(AcountBankModel());
    listBank.add(AcountBankModel());
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

  void searchBuyAnyPay(
      {String? bankCode,
      String? status,
      required String from,
      required String to}) {
    isLoading = true;
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_SEARCH_BUY_ANYPAY,
      params: {
        'bankCode': bankCode,
        'status': status,
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
              .map((postJson) => BuyAnyPayModel.fromJson(postJson))
              .toList();
          update();
        } else {}
      },
      onError: (error) {
        isLoading = false;
        update();
        Common.showMessageError(error, context);
      },
    );
  }

  String formatDateIso(String date) {
    DateTime dateTime = DateFormat('dd/MM/yyyy').parse(date);
    String isoString = dateTime.toIso8601String();
    return isoString;
  }
}

class AcountBankModel {
  String bankNumber = '00105182879881';
  String amount = 'S/ 2,775 (3,000 ANYPAY)';
  String date = '12/01/2021 10:50';
  String status = 'New';
}
