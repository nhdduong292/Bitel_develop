import 'package:flutter/services.dart';

class NativeUtil {
  static const platform = MethodChannel('bitel.com/demo');
  static const platformFinger = MethodChannel('bitel.com/finger');
  static const platformFingerPK = MethodChannel('bitel.com/fingerPK');
  static const platformScan1 = MethodChannel('bitel.com/scan1');
  static const platformScan2 = MethodChannel('bitel.com/scan2');

  static const nameFinger = "getFinger";
  static const nameFingerPK = "getFingerPK";
  static const nameScan1 = "getScan1";
  static const nameScan2 = "getScan2";
}
