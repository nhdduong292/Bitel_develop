import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;

import 'package:bitel_ventas/res/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Common {
  static const int DAY = 86400000;
  static DateTime? parserDate(String? date, {String? format}) {
    try {
      if (format == null) {
        return DateTime.parse(date!);
      }
      return DateFormat(format).parse(date!);
    } catch (e) {
      return null;
    }
  }

  static String fromDate(DateTime date, format) {
    try {
      String dateString = DateFormat(format).format(date);
      return dateString;
    } catch (e) {
      return "";
    }
  }

  static int strToInt(String data, {int defaultValue = 0}) {
    try {
      if (data.isEmpty) return defaultValue;
      return int.parse(data);
    } catch (e) {
      return defaultValue ?? -1;
    }
  }

  static num? doubleWithoutDecimalToInt(double? val) {
    if (val == null) {
      return null;
    }
    return val % 1 == 0 ? val.toInt() : val;
  }

  static double strToDouble(String data, {double? defaultValue}) {
    try {
      if (data.isEmpty) return 0;
      return double.parse(data);
    } catch (e) {
      return defaultValue ?? -Math.e;
    }
  }

  static String formatPrice(price, {bool showPrefix = true}) {
    if (price == null) {
      return "";
    }
    try {
      final numberFormat = NumberFormat("#,###");
      return numberFormat.format(double.parse(price.toString()).round()) +
          "${showPrefix ? " đ" : ""}";
    } catch (e) {
      return price?.toString() ?? "";
    }
  }

  static bool validateEmail(String text) {
    RegExp regex = RegExp(r'^[\w-\.]+@(gmail\.com|hotmail\.com)$');
    return regex.hasMatch(text);
  }

  static bool validatePhone(String text) {
    RegExp regex = RegExp(r'^[0-9]{9,11}$');
    return regex.hasMatch(text);
  }

  static bool validateAccount(String text) {
    RegExp regex = RegExp("^[A-Z0-9a-z]*\$");
    return regex.hasMatch(text);
  }

  static bool validateName(String text) {
    RegExp regex = RegExp("^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*\$");
    return regex.hasMatch(text);
  }

  static String getStringDateToday() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    return formatter.format(now);
  }

  static String getStringTimeToday() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy hh:mm');
    return formatter.format(now);
  }

  static String getStringDateFirstDayOfMonth() {
    var now = new DateTime.now();
    var date = DateTime(now.year, now.month, 1);
    var formatter = new DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  static String getStringDateLastDayOfMonth() {
    var now = new DateTime.now();
    var date = DateTime(now.year, now.month + 1, 0);
    var formatter = new DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  static String datetimeToSting(DateTime date) {
    var formatter = new DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  // static shareContent(String content) {
  //   Share.share(content);
  // }

  static void showToastCenter(String content) {
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: AppColors.colorBackground1,
        textColor: AppColors.colorText1,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5);
  }

  static String convertImageFileToBase64(File file) {
    var bytes = file.readAsBytesSync();
    var base64img = base64Encode(bytes);
    // try {
    //   byte[] bytes = new byte[(int) file.length()];
    // FileInputStream fis = null;
    // try {
    // fis = new FileInputStream(file);
    // //read file into bytes[]
    // fis.read(bytes);
    // } finally {
    // if (fis != null) {
    // fis.close();
    // }
    // }
    // return Base64.encodeToString(bytes, Base64.NO_WRAP);
    // } catch (Exception e) {
    return base64img;
  }

  static void showMessageError(var error, BuildContext context) {
    try {
      if (error != null) {
        if (error is! DioError) {
          Common.showToastCenter(AppLocalizations.of(context)!.textErrorAPI);
          return;
        }
      } else {
        Common.showToastCenter(AppLocalizations.of(context)!.textErrorAPI);
        return;
      }
      if (error.response!.data['errorCode'] == null) {
        Common.showToastCenter(AppLocalizations.of(context)!.textErrorAPI);
        return;
      }
      String errorCode = error.response!.data['errorCode'];
      if (errorCode == 'E000') {
        showToastCenter(AppLocalizations.of(context)!.textE000);
      } else if (errorCode == 'E001') {
        showToastCenter(AppLocalizations.of(context)!.textE001);
      } else if (errorCode == 'E002') {
        showToastCenter(AppLocalizations.of(context)!.textE002);
      } else if (errorCode == 'E003') {
        showToastCenter(AppLocalizations.of(context)!.textE003);
      } else if (errorCode == 'E004') {
        showToastCenter(AppLocalizations.of(context)!.textE004);
      } else if (errorCode == 'E005') {
        showToastCenter(AppLocalizations.of(context)!.textE005);
      } else if (errorCode == 'E006') {
        showToastCenter(AppLocalizations.of(context)!.textE006);
      } else if (errorCode == 'E007') {
        showToastCenter(AppLocalizations.of(context)!.textE007);
      } else if (errorCode == 'E008') {
        showToastCenter(AppLocalizations.of(context)!.textE008);
      } else if (errorCode == 'E009') {
        showToastCenter(AppLocalizations.of(context)!.textE009);
      } else if (errorCode == 'E010') {
        showToastCenter(AppLocalizations.of(context)!.textE010);
      } else if (errorCode == 'E011') {
        showToastCenter(AppLocalizations.of(context)!.textE011);
      } else if (errorCode == 'E012') {
        showToastCenter(AppLocalizations.of(context)!.textE012);
      } else if (errorCode == 'E013') {
        showToastCenter(AppLocalizations.of(context)!.textE013);
      } else if (errorCode == 'E014') {
        showToastCenter(AppLocalizations.of(context)!.textE014);
      } else if (errorCode == 'E015') {
        showToastCenter(AppLocalizations.of(context)!.textE015);
      } else if (errorCode == 'E016') {
        showToastCenter(AppLocalizations.of(context)!.textE016);
      } else if (errorCode == 'E017') {
        showToastCenter(AppLocalizations.of(context)!.textE017);
      } else if (errorCode == 'E018') {
        showToastCenter(AppLocalizations.of(context)!.textE018);
      } else if (errorCode == 'E019') {
        showToastCenter(AppLocalizations.of(context)!.textE019);
      } else if (errorCode == 'E020') {
        showToastCenter(AppLocalizations.of(context)!.textE020);
      } else if (errorCode == 'E021') {
        showToastCenter(AppLocalizations.of(context)!.textE021);
      } else if (errorCode == 'E022') {
        showToastCenter(AppLocalizations.of(context)!.textE022);
      } else if (errorCode == 'E023') {
        showToastCenter(AppLocalizations.of(context)!.textE023);
      } else if (errorCode == 'E024') {
        showToastCenter(AppLocalizations.of(context)!.textE024);
      } else if (errorCode == 'E025') {
        showToastCenter(AppLocalizations.of(context)!.textE025);
      } else if (errorCode == 'E026') {
        showToastCenter(AppLocalizations.of(context)!.textE026);
      } else if (errorCode == 'E027') {
        showToastCenter(AppLocalizations.of(context)!.textE027);
      } else if (errorCode == 'E028') {
        showToastCenter(AppLocalizations.of(context)!.textE028);
      } else if (errorCode == 'E029') {
        showToastCenter(AppLocalizations.of(context)!.textE029);
      } else if (errorCode == 'E030') {
        showToastCenter(AppLocalizations.of(context)!.textE030);
      } else if (errorCode == 'E031') {
        showToastCenter(AppLocalizations.of(context)!.textE031);
      } else if (errorCode == 'E032') {
        showToastCenter(AppLocalizations.of(context)!.textE032);
      } else if (errorCode == 'E033') {
        showToastCenter(AppLocalizations.of(context)!.textE033);
      } else if (errorCode == 'E034') {
        showToastCenter(AppLocalizations.of(context)!.textE034);
      } else if (errorCode == 'E035') {
        showToastCenter(AppLocalizations.of(context)!.textE035);
      } else if (errorCode == 'E036') {
        showToastCenter(AppLocalizations.of(context)!.textE036);
      } else if (errorCode == 'E037') {
        showToastCenter(AppLocalizations.of(context)!.textE037);
      } else if (errorCode == 'E038') {
        showToastCenter(AppLocalizations.of(context)!.textE038);
      } else if (errorCode == 'E039') {
        showToastCenter(AppLocalizations.of(context)!.textE039);
      }
    } catch (e) {
      Common.showToastCenter(e.toString());
    }
  }

  static String formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
