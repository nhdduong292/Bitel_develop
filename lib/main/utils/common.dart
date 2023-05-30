import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;

import 'package:bitel_ventas/main/services/settings_service.dart';
import 'package:bitel_ventas/main/utils/dialog_util.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/route_config.dart';

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

  static String convertDateTime(String dateTimeString, [String? format]) {
    // Khởi tạo đối tượng DateFormat để phân tích chuỗi ngày giờ
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      Duration timeZoneOffset = DateTime.now().timeZoneOffset;
      DateTime convertedDateTime = dateTime.add(timeZoneOffset);
      DateFormat outputFormat = format != null
          ? DateFormat("dd-MM-yyyy $format")
          : DateFormat("dd-MM-yyyy HH:mm:ss");
      String formattedDateTime = outputFormat.format(convertedDateTime);

      return formattedDateTime;
    } on Exception catch (e) {
      // TODO
      return '---';
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
    RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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

  static void showMessageError(
      {required var error, required BuildContext context, bool? isShow}) {
    isShow = isShow ?? false;
    try {
      if (error != null) {
        if (error is! DioError) {
          showSystemErrorDialog(
              context, AppLocalizations.of(context)!.textErrorAPI);
          return;
        }
        if (error.type == DioErrorType.connectionTimeout) {
          showSystemErrorDialog(
              context, AppLocalizations.of(context)!.textTheSystemIsOverloaded);
          return;
        }
      } else {
        showSystemErrorDialog(
            context, AppLocalizations.of(context)!.textErrorAPI);
        return;
      }
      final statusCode = error.response?.statusCode;
      if (statusCode == 401) {
        showSystemErrorLoginDialog(
            context, AppLocalizations.of(context)!.textLoginSessionHasExpired,
            () {
          Get.until(
            (route) {
              return Get.currentRoute == RouteConfig.login;
            },
          );
          Get.toNamed(RouteConfig.login);
        });
        return;
      }
      if (error.response!.data['errorCode'] == null) {
        showSystemErrorDialog(
            context, AppLocalizations.of(context)!.textErrorAPI);
        return;
      }
      String errorCode = error.response!.data['errorCode'];
      if (errorCode == 'E000') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE000);
      } else if (errorCode == 'E001') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE001);
      } else if (errorCode == 'E002') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE002);
      } else if (errorCode == 'E003') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE003);
      } else if (errorCode == 'E004') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE004);
      } else if (errorCode == 'E005') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE005);
      } else if (errorCode == 'E006') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE006);
      } else if (errorCode == 'E007') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE007);
      } else if (errorCode == 'E008') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE008);
      } else if (errorCode == 'E009') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE009);
      } else if (errorCode == 'E010') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE010);
      } else if (errorCode == 'E011') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE011);
      } else if (errorCode == 'E012') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE012);
      } else if (errorCode == 'E013') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE013);
      } else if (errorCode == 'E014') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE014);
      } else if (errorCode == 'E015') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE015);
      } else if (errorCode == 'E016') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE016);
      } else if (errorCode == 'E017') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE017);
      } else if (errorCode == 'E018') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE018);
      } else if (errorCode == 'E019') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE019);
      } else if (errorCode == 'E020') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE020);
      } else if (errorCode == 'E021') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE021);
      } else if (errorCode == 'E022') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE022);
      } else if (errorCode == 'E023') {
        // showSystemErrorDialog(context, AppLocalizations.of(context)!.textE023);
      } else if (errorCode == 'E024') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE024);
      } else if (errorCode == 'E025') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE025);
      } else if (errorCode == 'E026') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE026);
      } else if (errorCode == 'E027') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE027);
      } else if (errorCode == 'E028') {
        // showSystemErrorDialog(context, AppLocalizations.of(context)!.textE028);
      } else if (errorCode == 'E029') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE029);
      } else if (errorCode == 'E030') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE030);
      } else if (errorCode == 'E031') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE031);
      } else if (errorCode == 'E032') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE032);
      } else if (errorCode == 'E033') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE033);
      } else if (errorCode == 'E034') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE034);
      } else if (errorCode == 'E035') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE035);
      } else if (errorCode == 'E036') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE036);
      } else if (errorCode == 'E037') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE037);
      } else if (errorCode == 'E038') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE038);
      } else if (errorCode == 'E039') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE039);
      } else if (errorCode == 'E040') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE040);
      } else if (errorCode == 'E041') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE041);
      } else if (errorCode == 'E042') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE042);
      } else if (errorCode == 'E043') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE043);
      } else if (errorCode == 'E044') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE044);
      } else if (errorCode == 'E045') {
        // showSystemErrorDialog(context, AppLocalizations.of(context)!.textE045);
      } else if (errorCode == 'E046') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE046);
      } else if (errorCode == 'E047') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE047);
      } else if (errorCode == 'E048') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE048);
      } else if (errorCode == 'E049') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE049);
      } else if (errorCode == 'E050') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE050);
      } else if (errorCode == 'E051') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE051);
      } else if (errorCode == 'E052') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE052);
      } else if (errorCode == 'E053') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE053);
      } else if (errorCode == 'E054') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE054);
      } else if (errorCode == 'E055') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE055);
      } else if (errorCode == 'E056') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE056);
      } else if (errorCode == 'E057') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE057);
      } else if (errorCode == 'E058') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE058);
      } else if (errorCode == 'E059') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE059);
      } else if (errorCode == 'E060') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE060);
      } else if (errorCode == 'E061') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE016);
      } else if (errorCode == 'E062') {
        showSystemErrorDialog(context, AppLocalizations.of(context)!.textE062);
      } else {
        showSystemErrorDialog(context, error.response!.data['errorMessage']);
      }
    } catch (e) {
      if (kDebugMode) {
        Common.showToastCenter(e.toString());
      }
    }
  }

  static String formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  static void showSystemErrorDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) {
          return SystemErrorDialog(
            text: text,
          );
        });
  }

  static void showSystemErrorLoginDialog(
      BuildContext context, String text, Function onSuccess) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SystemErrorLoginDialog(
            text: text,
            onOk: () {
              onSuccess();
            },
          );
        });
  }

  static String getIdentityType(int idType) {
    if (idType == 1) {
      return 'DNI';
    } else if (idType == 2) {
      return 'CE';
    } else if (idType == 3) {
      return 'RUC';
    } else if (idType == 4) {
      return 'PP';
    } else if (idType == 7) {
      return 'PTP';
    } else if (idType == 8) {
      return 'CPP';
    }
    return '---';
  }

  static getVersionApp() {
    SettingService settingService = Get.find();
    return settingService.version.value;
  }
}
