// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/common.dart';

class ConnectionService {
  static ConnectionService? _mInstance;

  static ConnectionService? getInstance() {
    _mInstance ??= ConnectionService();
    return _mInstance;
  }

  Future<bool> checkConnect(BuildContext context) async {
    Completer<bool> completer = Completer();
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet ||
        connectivityResult == ConnectivityResult.vpn) {
      completer.complete(true);
      // Common.showSystemErrorDialog(context, 'Không có kết nối');
      // completer.complete(false);
    } else if (connectivityResult == ConnectivityResult.none) {
      Common.showConnectionErrorDialog(
          context, AppLocalizations.of(context)!.textNoInternetConnection);
      completer.complete(false);
    }
    return completer.future;
  }
}
