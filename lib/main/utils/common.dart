import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;

import 'package:bitel_ventas/main/services/settings_service.dart';
import 'package:bitel_ventas/main/utils/dialog_util.dart';
import 'package:bitel_ventas/main/utils/values.dart';
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
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

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

  static String formatDatePeru(DateTime? date) {
    if (date == null) {
      return "";
    }
    // Độ chênh lệch múi giờ giữa Peru và Việt Nam (đơn vị là giờ)
    double timeZoneOffsetPeru = -5.0; // Peru có múi giờ UTC-5

    // Áp dụng độ chênh lệch múi giờ cho thời gian hiện tại của Việt Nam
    DateTime nowInPeru =
        date.toUtc().add(Duration(hours: timeZoneOffsetPeru.toInt()));
    // Tạo đối tượng DateFormat cho định dạng mong muốn
    DateFormat outputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    return outputFormat.format(nowInPeru);
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

  static void showToastCenter(String content, BuildContext? context) {
    showToast(content,
        context: context,
        alignment: Alignment.center,
        animDuration: Duration(milliseconds: 0),
        duration: Duration(seconds: 3),
        animation: StyledToastAnimation.fade,
        backgroundColor: AppColors.colorBackground1,
        textStyle: TextStyle(color: AppColors.colorText1),
        position: StyledToastPosition(align: Alignment.center, offset: 20.0));
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
      {required var error,
      required BuildContext context,
      bool? isShow,
      String? type,
      Function? onContinue,
      bool? isDNI}) {
    isShow = isShow ?? false;
    isDNI = isDNI ?? true;
    String ottName = "";
    if (type == OTTService.BITEL_VIDEO) {
      ottName = "Bitel video";
    } else if (type == OTTService.PARAMOUNT) {
      ottName = "Paramount+";
    } else if (type == OTTService.CABLE_GO) {
      ottName = "Cable go";
    }

    try {
      if (error != null) {
        if (error is! DioError) {
          showSystemErrorDialog(
              context, AppLocalizations.of(context)!.textErrorAPI);
          return;
        }
        if (error.type == DioErrorType.connectionTimeout ||
            error.type == DioErrorType.receiveTimeout) {
          showSystemErrorDialog(
              context, AppLocalizations.of(context)!.textTheSystemIsOverloaded);
          return;
        }
      } else {
        showSystemErrorDialog(
            context, AppLocalizations.of(context)!.textErrorAPI);
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
        showSystemErrorDialog(
            context, '[E000] ${AppLocalizations.of(context)!.textE000}');
      } else if (errorCode == 'E001') {
        showSystemErrorDialog(
            context, '[E001] ${AppLocalizations.of(context)!.textE001}');
      } else if (errorCode == 'E002') {
        showSystemErrorDialog(
            context, '[E002] ${AppLocalizations.of(context)!.textE002}');
      } else if (errorCode == 'E003') {
        showSystemErrorDialog(
            context, '[E003] ${AppLocalizations.of(context)!.textE003}');
      } else if (errorCode == 'E004') {
        showSystemErrorDialog(
            context, '[E004] ${AppLocalizations.of(context)!.textE004}');
      } else if (errorCode == 'E005') {
        showSystemErrorDialog(
            context, '[E005] ${AppLocalizations.of(context)!.textE005}');
      } else if (errorCode == 'E006') {
        showSystemErrorDialog(
            context, '[E006] ${AppLocalizations.of(context)!.textE006}');
      } else if (errorCode == 'E007') {
        showSystemErrorDialog(
            context, '[E007] ${AppLocalizations.of(context)!.textE007}');
      } else if (errorCode == 'E008') {
        showSystemErrorDialog(
            context, '[E008] ${AppLocalizations.of(context)!.textE008}');
      } else if (errorCode == 'E009') {
        showSystemErrorDialog(
            context, '[E009] ${AppLocalizations.of(context)!.textE009}');
      } else if (errorCode == 'E010') {
        showSystemWarningDialog(
            context, '[E010] ${AppLocalizations.of(context)!.textE010}');
      } else if (errorCode == 'E011') {
        showSystemErrorDialog(
            context, '[E011] ${AppLocalizations.of(context)!.textE011}');
      } else if (errorCode == 'E012') {
        showSystemWarningDialog(
            context, '[E012] ${AppLocalizations.of(context)!.textE012}');
      } else if (errorCode == 'E013') {
        showSystemWarningDialog(
            context, '[E013] ${AppLocalizations.of(context)!.textE013}');
      } else if (errorCode == 'E014') {
        showSystemErrorDialog(
            context, '[E014] ${AppLocalizations.of(context)!.textE014}');
      } else if (errorCode == 'E015') {
        showSystemErrorDialog(
            context, '[E015] ${AppLocalizations.of(context)!.textE015}');
      } else if (errorCode == 'E016') {
        isDNI
            ? showSystemWarningDialog(
                context, '[E016] ${AppLocalizations.of(context)!.textE016}')
            : showSystemWarningFingerDialog(
                context, '[E016] ${AppLocalizations.of(context)!.textE016}', () {
                if (onContinue != null) {
                  onContinue();
                }
              });
      } else if (errorCode == 'E017') {
        showSystemErrorDialog(
            context, '[E017] ${AppLocalizations.of(context)!.textE017}');
      } else if (errorCode == 'E018') {
        showSystemErrorDialog(
            context, '[E018] ${AppLocalizations.of(context)!.textE018}');
      } else if (errorCode == 'E019') {
        showSystemWarningDialog(
            context, '[E019] ${AppLocalizations.of(context)!.textE019}');
      } else if (errorCode == 'E020') {
        showSystemErrorDialog(
            context, '[E020] ${AppLocalizations.of(context)!.textE020}');
      } else if (errorCode == 'E021') {
        showSystemWarningDialog(
            context, '[E021] ${AppLocalizations.of(context)!.textE021}');
      } else if (errorCode == 'E022') {
        showSystemErrorDialog(
            context, '[E022] ${AppLocalizations.of(context)!.textE022}');
      } else if (errorCode == 'E023') {
        // showSystemErrorDialog(context, AppLocalizations.of(context)!.textE023);
      } else if (errorCode == 'E024') {
        showSystemErrorDialog(
            context, '[E024] ${AppLocalizations.of(context)!.textE024}');
      } else if (errorCode == 'E025') {
        showSystemErrorDialog(
            context, '[E025] ${AppLocalizations.of(context)!.textE025}');
      } else if (errorCode == 'E026') {
        showSystemErrorDialog(
            context, '[E026] ${AppLocalizations.of(context)!.textE026}');
      } else if (errorCode == 'E027') {
        showSystemWarningDialog(
            context, '[E027] ${AppLocalizations.of(context)!.textE027}');
      } else if (errorCode == 'E028') {
        // showSystemErrorDialog(context, AppLocalizations.of(context)!.textE028);
      } else if (errorCode == 'E029') {
        showSystemWarningDialog(
            context, '[E029] ${AppLocalizations.of(context)!.textE029}');
      } else if (errorCode == 'E030') {
        showSystemErrorDialog(
            context, '[E030] ${AppLocalizations.of(context)!.textE030}');
      } else if (errorCode == 'E031') {
        showSystemErrorDialog(
            context, '[E031] ${AppLocalizations.of(context)!.textE031}');
      } else if (errorCode == 'E032') {
        showSystemErrorDialog(
            context, '[E032] ${AppLocalizations.of(context)!.textE032}');
      } else if (errorCode == 'E033') {
        showSystemErrorDialog(
            context, '[E033] ${AppLocalizations.of(context)!.textE033}');
      } else if (errorCode == 'E034') {
        showSystemErrorDialog(
            context, '[E034] ${AppLocalizations.of(context)!.textE034}');
      } else if (errorCode == 'E035') {
        showSystemErrorDialog(
            context, '[E035] ${AppLocalizations.of(context)!.textE035}');
      } else if (errorCode == 'E036') {
        showSystemErrorDialog(
            context, '[E036] ${AppLocalizations.of(context)!.textE036}');
      } else if (errorCode == 'E037') {
        isDNI
            ? showSystemWarningDialog(
                context, '[E037] ${AppLocalizations.of(context)!.textE037}')
            : showSystemWarningFingerDialog(
                context, '[E037] ${AppLocalizations.of(context)!.textE037}', () {
                if (onContinue != null) {
                  onContinue();
                }
              });
      } else if (errorCode == 'E038') {
        isDNI
            ? showSystemWarningDialog(
                context, '[E038] ${AppLocalizations.of(context)!.textE038}')
            : showSystemWarningFingerDialog(
                context, '[E038] ${AppLocalizations.of(context)!.textE038}', () {
                if (onContinue != null) {
                  onContinue();
                }
              });
      } else if (errorCode == 'E039') {
        showSystemErrorDialog(
            context, '[E039] ${AppLocalizations.of(context)!.textE039}');
      } else if (errorCode == 'E040') {
        showSystemErrorDialog(
            context, '[E040] ${AppLocalizations.of(context)!.textE040}');
      } else if (errorCode == 'E041') {
        showSystemErrorDialog(
            context, '[E041] ${AppLocalizations.of(context)!.textE041}');
      } else if (errorCode == 'E042') {
        showSystemErrorDialog(
            context, '[E042] ${AppLocalizations.of(context)!.textE042}');
      } else if (errorCode == 'E043') {
        showSystemErrorDialog(
            context, '[E043] ${AppLocalizations.of(context)!.textE043}');
      } else if (errorCode == 'E044') {
        showSystemErrorDialog(
            context, '[E044] ${AppLocalizations.of(context)!.textE044}');
      } else if (errorCode == 'E045') {
        // showSystemErrorDialog(context, AppLocalizations.of(context)!.textE045);
      } else if (errorCode == 'E046') {
        showSystemWarningDialog(
            context, '[E046] ${AppLocalizations.of(context)!.textE046}');
      } else if (errorCode == 'E047') {
        showSystemErrorDialog(
            context, '[E047] ${AppLocalizations.of(context)!.textE047}');
      } else if (errorCode == 'E048') {
        showSystemErrorDialog(
            context, '[E048] ${AppLocalizations.of(context)!.textE048}');
      } else if (errorCode == 'E049') {
        showSystemErrorDialog(
            context, '[E049] ${AppLocalizations.of(context)!.textE049}');
      } else if (errorCode == 'E050') {
        showSystemErrorDialog(
            context, '[E050] ${AppLocalizations.of(context)!.textE050}');
      } else if (errorCode == 'E051') {
        showSystemErrorDialog(
            context, '[E051] ${AppLocalizations.of(context)!.textE051}');
      } else if (errorCode == 'E052') {
        showSystemWarningDialog(
            context, '[E052] ${AppLocalizations.of(context)!.textE052}');
      } else if (errorCode == 'E053') {
        showSystemErrorDialog(
            context, '[E053] ${AppLocalizations.of(context)!.textE053}');
      } else if (errorCode == 'E054') {
        showSystemErrorDialog(
            context, '[E054] ${AppLocalizations.of(context)!.textE054}');
      } else if (errorCode == 'E055') {
        showSystemErrorDialog(
            context, '[E055] ${AppLocalizations.of(context)!.textE055}');
      } else if (errorCode == 'E056') {
        showSystemErrorDialog(
            context, '[E056] ${AppLocalizations.of(context)!.textE056}');
      } else if (errorCode == 'E057') {
        showSystemWarningDialog(
            context, '[E057] ${AppLocalizations.of(context)!.textE057}');
      } else if (errorCode == 'E058') {
        showSystemErrorDialog(
            context, '[E058] ${AppLocalizations.of(context)!.textE058}');
      } else if (errorCode == 'E059') {
        showSystemErrorDialog(
            context, '[E059] ${AppLocalizations.of(context)!.textE059}');
      } else if (errorCode == 'E060') {
        showSystemErrorDialog(
            context, '[E060] ${AppLocalizations.of(context)!.textE060}');
      } else if (errorCode == 'E061') {
        showSystemErrorDialog(
            context, '[E061] ${AppLocalizations.of(context)!.textE061}');
      } else if (errorCode == 'E062') {
        showSystemErrorDialog(
            context, '[E062] ${AppLocalizations.of(context)!.textE062}');
      } else if (errorCode == 'E063') {
        showSystemErrorDialog(
            context, '[E063] ${AppLocalizations.of(context)!.textE063}');
      } else if (errorCode == 'E064') {
        showSystemErrorDialog(
            context, '[E064] ${AppLocalizations.of(context)!.textE064}');
      } else if (errorCode == 'E065') {
        showSystemErrorDialog(
            context, '[E065] ${AppLocalizations.of(context)!.textE065}');
      } else if (errorCode == 'E066') {
        showSystemErrorDialog(
            context, '[E066] ${AppLocalizations.of(context)!.textE066}');
      } else if (errorCode == 'E067') {
        showSystemErrorDialog(
            context, '[E067] ${AppLocalizations.of(context)!.textE067}');
      } else if (errorCode == 'E068') {
        showSystemErrorDialog(
            context, '[E068] ${AppLocalizations.of(context)!.textE068}');
      } else if (errorCode == 'E069') {
        showSystemErrorDialog(
            context, '[E069] ${AppLocalizations.of(context)!.textE069}');
      } else if (errorCode == 'E070') {
        showSystemErrorDialog(
            context, '[E070] ${AppLocalizations.of(context)!.textE070}');
      } else if (errorCode == 'E071') {
        showSystemErrorDialog(
            context, '[E071] ${AppLocalizations.of(context)!.textE071}');
      } else if (errorCode == 'E072') {
        showSystemErrorDialog(
            context, '[E072] ${AppLocalizations.of(context)!.textE072}');
      } else if (errorCode == 'E074') {
        showSystemErrorDialog(
            context, '[E074] ${AppLocalizations.of(context)!.textE074}');
      } else if (errorCode == 'E075') {
        showSystemErrorDialog(
            context, '[E075] ${AppLocalizations.of(context)!.textE075}');
      } else if (errorCode == 'E076') {
        showSystemErrorDialog(
            context, '[E076] ${AppLocalizations.of(context)!.textE076}');
      } else if (errorCode == 'E077') {
        showSystemErrorDialog(
            context, '[E077] ${AppLocalizations.of(context)!.textE077}');
      } else if (errorCode == 'E078') {
        showSystemErrorDialog(
            context, '[E078] ${AppLocalizations.of(context)!.textE078}');
      } else if (errorCode == 'E079') {
        showSystemErrorDialog(
            context, '[E079] ${AppLocalizations.of(context)!.textE079}');
      } else if (errorCode == 'E080') {
        showSystemErrorDialog(
            context, '[E080] ${AppLocalizations.of(context)!.textE080}');
      } else if (errorCode == 'E081') {
        showSystemErrorDialog(
            context, '[E081] ${AppLocalizations.of(context)!.textE081}');
      } else if (errorCode == 'E082') {
        showSystemErrorDialog(
            context, '[E082] ${AppLocalizations.of(context)!.textE082}');
      } else if (errorCode == 'E083') {
        showSystemErrorDialog(
            context, '[E083] ${AppLocalizations.of(context)!.textE083(ottName)}');
      } else if (errorCode == 'E090') {
        showSystemErrorDialog(
            context, '[E090] ${AppLocalizations.of(context)!.textE090}');
      } else if (errorCode == 'E091') {
        showSystemErrorDialog(
            context, '[E091] ${AppLocalizations.of(context)!.textE091}');
      } else if (errorCode == 'E092') {
        showSystemErrorDialog(
            context, '[E092] ${AppLocalizations.of(context)!.textE092}');
      } else if (errorCode == 'E093') {
        showSystemErrorDialog(
            context, '[E093] ${AppLocalizations.of(context)!.textE093}');
      } else if (errorCode == 'E094') {
        showSystemErrorDialog(
            context, '[E094] ${AppLocalizations.of(context)!.textE094}');
      } else if (errorCode == 'E101') {
        showSystemErrorDialog(
            context, '[E101] ${AppLocalizations.of(context)!.textE101}');
      } else if (errorCode == 'E102') {
        showSystemErrorDialog(
            context, '[E102] ${AppLocalizations.of(context)!.textE102}');
      } else if (errorCode == 'E103') {
        showSystemErrorDialog(
            context, '[E103] ${AppLocalizations.of(context)!.textE103}');
      } else if (errorCode == 'E104') {
        showSystemErrorDialog(
            context, '[E104] ${AppLocalizations.of(context)!.textE104}');
      } else if (errorCode == 'E105') {
        showSystemErrorDialog(
            context, '[E105] ${AppLocalizations.of(context)!.textE105}');
      } else if (errorCode == 'E110') {
        showSystemErrorDialog(
            context, '[E110] ${AppLocalizations.of(context)!.textE110}');
      } else if (errorCode == 'E112') {
        showSystemErrorDialog(
            context, '[E112] ${AppLocalizations.of(context)!.textE112}');
      } else if (errorCode == 'E113') {
        showSystemErrorDialog(
            context, '[E113] ${AppLocalizations.of(context)!.textE113}');
      } else if (errorCode == 'E114') {
        showSystemErrorDialog(
            context, '[E114] ${AppLocalizations.of(context)!.textE114}');
      } else if (errorCode == 'E120') {
        showSystemErrorDialog(
            context, '[E120] ${AppLocalizations.of(context)!.textE120}');
      } else {
        showSystemErrorDialog(context, error.response!.data['errorMessage']);
      }
    } catch (e) {
      if (kDebugMode) {
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: AppColors.colorBackground1,
            textColor: AppColors.colorText1,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5);
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

  static void showSystemWarningFingerDialog(
      BuildContext context, String text, Function onContinue) {
    showDialog(
        context: context,
        builder: (context) {
          return SystemWarningFingerDialog(
            text: text,
            onContinue: () {
              onContinue();
            },
          );
        });
  }

  static void showSystemWarningDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) {
          return SystemWarningDialog(
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

  static void showConnectionErrorDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) {
          return ConnectionErrorDialog(
            text: text,
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

  static String numberFormat(var content) {
    var number;
    if (content is String) {
      number = double.parse(content);
    } else if (content is double) {
      number = content;
      number = double.parse(number.toStringAsFixed(1));
    } else if (content is int) {
      number = content;
    } else {
      return '---';
    }
    String formattedNumber =
        NumberFormat.decimalPattern('en_US').format(number);
    return formattedNumber;
  }
}
