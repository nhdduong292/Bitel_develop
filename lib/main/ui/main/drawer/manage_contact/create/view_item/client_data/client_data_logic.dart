import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ClientDataLogic extends GetxController {
  late BuildContext context;
  String textPathScan = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onListenerMethod();
  }

  void onListenerMethod(){
    NativeUtil.platformScan2.setMethodCallHandler((call) async{
      if(call.method == NativeUtil.nameScan2){
        String link = call.arguments;
        print("Linkkkkkkkkkkkkkkkkkkk222: $link");
        textPathScan = link;
        update();
      }
    });
  }

  Future<void> getScan() async {
    String result = "";
    try {
      final String value =
      await NativeUtil.platformScan2.invokeMethod(NativeUtil.nameScan2);
      result = value;
    } on PlatformException catch (e) {
      e.printInfo();
    }
    print(result);
  }
}
