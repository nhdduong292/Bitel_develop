import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';

class ClientDataLogic extends GetxController {
  late BuildContext context;
  String textPathScan = "";
  CustomerModel customer = CustomerModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onListenerMethod();
  }

  void onListenerMethod() {
    NativeUtil.platformScan2.setMethodCallHandler((call) async {
      if (call.method == NativeUtil.nameScan2) {
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

  void createCustomer() {
    Map<String, dynamic> body = {
      "type": "",
      "idNumber": "",
      "lastName": "",
      "firstName": "",
      "nationality": "",
      "sex": "",
      "dateOfBirth": "",
      "expiredDate": "",
      "image": "Email",
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_CREATE_CUSTOMER,
      body: body,
      onSuccess: (response) {
        if (response.isSuccess) {
          customer = CustomerModel.fromJson(response.data);
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }
}
