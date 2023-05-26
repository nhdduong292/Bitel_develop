import 'dart:async';

import 'package:bitel_ventas/main/ui/main/main_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  MainLogic mainLogic = Get.find<MainLogic>();
  final controllerPage = PageController(viewportFraction: 0.9, keepPage: true);
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // initConnectivity();

    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    Common.showToastCenter('I am not connected to any network.');
  }

  void openDrawer() {
    mainLogic.openDrawer();
  }
}
