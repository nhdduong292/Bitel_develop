import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class DocumentScanningLogic extends GetxController {
  late BuildContext context;
  var checkOption1 = true.obs;
  var checkOption2 = true.obs;
  String textPathScan = "";

  String currentIdentity = "DNI";
  List<String> listIdentityNumber = ["DNI", "CE", "PP", "PTP"];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onListenerMethod();
  }

  void onListenerMethod(){
    NativeUtil.platformScan1.setMethodCallHandler((call) async{
      if(call.method == NativeUtil.nameScan1){
        String link = call.arguments;
        print("Linkkkkkkkkkkkkkkkkkkk 1111111: $link");
        textPathScan = link;
        update();
      }
    });
  }

  Future<void> getScan() async {
    String result = "";
    try {
      final String value =
      await NativeUtil.platformScan1.invokeMethod(NativeUtil.nameScan1);
      result = value;
    } on PlatformException catch (e) {
      e.printInfo();
    }
    print(result);
  }
}
