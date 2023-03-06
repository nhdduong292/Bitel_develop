import 'package:flutter/services.dart';

class NativeUtil {
  static const platform = MethodChannel('bitel.com/demo');
  static const platformFinger = MethodChannel('bitel.com/finger');
  static const nameFinger = "getFinger";
}
