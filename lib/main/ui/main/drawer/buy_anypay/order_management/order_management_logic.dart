import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/common.dart';

class OrderManagementLogic extends GetxController {
  BuildContext context;
  var from = "".obs;
  var to = "".obs;
  DateTime selectDate = DateTime.now();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  String currentStatus = '';

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

    setFromDate(fromDate.subtract(const Duration(days: 30)));
    setToDate(toDate);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    currentStatus = AppLocalizations.of(context)!.textAll;
    update();
  }

  void setStatus(String value) {
    currentStatus = value;
    update();
  }

  void setToDate(DateTime picked) {
    // print("Date: "+picked.toString());
    toDate = picked;
    to.value = "${picked.day}/${picked.month}/${picked.year}";
    // searchRequest.toDate = picked.toIso8601String();
    if (!compareToDate()) {
      to.value = '';
      Common.showToastCenter(AppLocalizations.of(context)!.textInvalidDate);
    }
    update();
  }

  void setFromDate(DateTime picked) {
    // print("Date: "+picked.toString());
    // print("Date: "+picked.toIso8601String());
    fromDate = picked;
    from.value = "${picked.day}/${picked.month}/${picked.year}";
    if (!compareToDate()) {
      from.value = '';
      Common.showToastCenter(AppLocalizations.of(context)!.textInvalidDate);
    }
    // searchRequest.fromDate = picked.toIso8601String();
    // DateTime pi = DateTime.parse(picked.toIso8601String());
    update();
  }

  // so sanh date of birth voi expried date
  bool compareToDate() {
    if (to.value.isEmpty || from.value.isEmpty) {
      return true;
    }
    DateFormat formatter = DateFormat("dd/MM/yyyy");

    DateTime date1 = formatter.parse(from.value);
    DateTime date2 = formatter.parse(to.value);

    int result = date1.compareTo(date2);

    if (result < 0) {
      return true;
    } else if (result > 0) {
      return false;
    } else {
      return false;
    }
  }
}

class AcountBankModel {
  String bankNumber = '00105182879881';
  String amount = 'S/ 2,775 (3,000 ANYPAY)';
  String date = '12/01/2021 10:50';
  String status = 'New';
}
