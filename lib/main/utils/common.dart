import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;

import 'package:bitel_ventas/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Common {
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
    RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(text);
  }

  static bool validatePhone(String text) {
    RegExp regex = RegExp("^[0-9\-\+]{10,15}\$");
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
}
