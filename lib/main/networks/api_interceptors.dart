import 'dart:convert';
import 'dart:io';
import 'package:bitel_ventas/main/utils/shared_preference.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:path_provider/path_provider.dart';

import '../utils/logger.dart';

class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final method = options.method;
    final uri = options.uri;
    final data = options.data;
    // final authRepository = Get.find<AuthRepository>(tag: (AuthRepository).toString());

    apiLogger.log(
        "\n\n--------------------------------------------------------------------------------------------------------");
    if (method == 'GET') {
      apiLogger.log(
          "✈️ REQUEST[$method] => PATH: $uri \n Token: ${options.headers}",
          printFullText: true);
      writeLogToFile("✈️ REQUEST[$method] => PATH: $uri}");
    } else {
      try {
        apiLogger.log(
            "✈️ REQUEST[$method] => PATH: $uri \n DATA: ${jsonEncode(data)}",
            printFullText: true);
        writeLogToFile(
            "✈️ REQUEST[$method] => PATH: $uri \n DATA: ${jsonEncode(data)}");
      } catch (e) {
        apiLogger.log("✈️ REQUEST[$method] => PATH: $uri \n DATA: $data",
            printFullText: true);
        writeLogToFile("✈️ REQUEST[$method] => PATH: $uri \n DATA: $data");
      }
    }

    super.onRequest(options, handler);
  }

  void writeLogToFile(String log) async {
    final directory = Platform.isAndroid
        ? Directory("/storage/emulated/0/Documents") //FOR ANDROID
        : await getApplicationDocumentsDirectory(); //FOR iOS
    final file = File('${directory.path}/logBitel.txt');
    await file.writeAsString('$log\n', mode: FileMode.append);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    final uri = response.requestOptions.uri;
    final data = jsonEncode(response.data);
    apiLogger.log("✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data");
    writeLogToFile("✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data");
    //Handle section expired
    if (response.statusCode == 401) {
      // final authRepository = Get.find<AuthRepository>(tag: (AuthRepository).toString());
      // authRepository.signOut();
      // Get.off(SignInPage());
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final uri = err.requestOptions.path;
    var data = "";
    try {
      data = jsonEncode(err.response?.data);
    } catch (e) {}
    apiLogger.log("⚠️ ERROR[$statusCode] => PATH: $uri\n DATA: $data");
    writeLogToFile("⚠️ ERROR[$statusCode] => PATH: $uri\n DATA: $data");
    super.onError(err, handler);
  }
}
