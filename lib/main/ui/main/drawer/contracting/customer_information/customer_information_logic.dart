import 'dart:async';
import 'dart:io';

import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';

class CustomerInformationLogic extends GetxController {
  late BuildContext context;
  var checkItem1 = true.obs;
  var checkItem2 = false.obs;
  var checkItem3 = false.obs;
  var titleScreen = 'Customer information'.obs;
  var isUpdate = false.obs;
  var signDate = ''.obs;
  var path = ''.obs;
  var checkOption = false.obs;
  var checkMainContract = true.obs;
  var checkLendingContract = false.obs;
  var billCycle = ''.obs;
  int requestId = 0;
  int productId = 0;
  int reasonId = 0;
  CustomerModel customer = CustomerModel();

  CustomerInformationLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    customer = data[0];
    requestId = data[1];
    productId = data[2];
    reasonId = data[3];
    // getCustomer();
    // fromAsset('assets/demo-link.pdf', 'demo.pdf')
    //     .then((value) => {path = value.path});
  }

  void getCurrentTime() {
    DateTime now = DateTime.now();
    if (now.day >= 6 && now.day < 16) {
      billCycle.value = 'Ciclo 6';
    } else if (now.day >= 16 && now.day < 26) {
      billCycle.value = 'Ciclo 16';
    } else {
      billCycle.value = 'Ciclo 26';
    }
    signDate.value = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
  }

  String getTypeCustomer() {
    var type = customer.type;
    if (type == 1) {
      return 'DNI';
    } else if (type == 2) {
      return 'CE';
    } else if (type == 3) {
      return 'RUC';
    } else if (type == 4) {
      return 'PP';
    } else if (type == 7) {
      return 'PTP';
    } else if (type == 8) {
      return 'CPP';
    }
    return '';
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  // void getCustomer() {
  //   ApiUtil.getInstance()!.get(
  //     url: '${ApiEndPoints.API_CUSTOMER}/54/',
  //     onSuccess: (response) {
  //       if (response.isSuccess) {
  //         customer = CustomerModel.fromJson(response.data['data']);
  //         update();
  //       } else {
  //         print("error: ${response.status}");
  //       }
  //     },
  //     onError: (error) {},
  //   );
  // }

  var checkOption1 = false.obs;
  var checkOption2 = false.obs;
  var checkOption3 = false.obs;
  var checkOption4 = false.obs;

  Rx<String> contractLanguagetValue = 'Espanol'.obs;
  final contractLanguages = [
    'Ashaninka',
    'Aymara',
    'Quechua',
    'Shipobo - konibo',
    'Espanol'
  ];

  void createContract() {
    Map<String, dynamic> body = {
      "requestId": requestId,
      "productId": productId,
      "reasonId": reasonId,
      "promotionId": 0,
      "contractType": "UNDETERMINED",
      "numOfSubscriber": 1,
      "signDate": signDate.value,
      "billCycle": billCycle,
      "changeNotification": "Email",
      "printBill": "Email",
      "currency": "SOL",
      "language": contractLanguagetValue.value.toUpperCase(),
      "province": customer.province,
      "district": customer.district,
      "precinct": customer.precinct,
      "address": customer.address,
      "phone": customer.telFax,
      "email": customer.email,
      "protectionFilter": checkOption1,
      "receiveInfoByMail": checkOption2,
      "receiveFromThirdParty": checkOption3,
      "receiveFromBitel": checkOption4
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_CREATE_CONTRACT,
      body: body,
      onSuccess: (response) {
        if (response.isSuccess) {
          print('bxloc post success');
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }

  void contractPreview(String type) {
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CONTRACT_PREVIEW.replaceAll("id", "54"),
      params: {"type": type},
      onSuccess: (response) {
        if (response.isSuccess) {
          print('bxloc get success');
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }

  // Future<File> loadPDF(String filename) async {
  //   // To open from assets, you can copy them to the app storage folder, and the access them "locally"
  //   Completer<File> completer = Completer();

  //   try {
  //     // var dir = await getApplicationDocumentsDirectory();
  //     // print("${dir.path}/$filename");
  //     // File file = File();
  //     var dir = await getApplicationDocumentsDirectory();
  //     File file = File("${dir.path}/$filename");
  //     var data = await rootBundle.load('assets/demo_link.pdf');
  //     var bytes = data.buffer.asUint8List();
  //     await file.writeAsBytes(bytes, flush: true);

  //     // ignore: use_build_context_synchronously
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => PDFScreen(
  //           path: file.path,
  //         ),
  //       ),
  //     );

  //     // ApiUtil.getInstance()!.getPDF(
  //     //   url: ApiEndPoints.API_CONTRACT_PREVIEW.replaceAll("id", "54"),
  //     //   params: {"type": "MAIN"},
  //     //   onSuccess: (response) {
  //     //     print(response.data);
  //     //     Navigator.push(
  //     //       context,
  //     //       MaterialPageRoute(
  //     //         builder: (context) => PDFScreen(
  //     //           path: 'value.path',
  //     //           data: convertStringToUint8List(response.data),
  //     //         ),
  //     //       ),
  //     //     );
  //     //     print('bxloc get success');
  //     //     //        var data = await rootBundle.load(asset);
  //     //     // // var bytes = data.buffer.asUint8List();
  //     //     // var bytes = await consolidateHttpClientResponseBytes(response.data);
  //     //     // await file.writeAsBytes(bytes, flush: true);
  //     //     // return file;
  //     //   },
  //     //   onError: (error) {},
  //     // );
  //   } catch (e) {
  //     print(e);
  //     throw Exception('Error parsing asset file!');
  //   }

  //   return completer.future;
  // }

  // void setPath() {
  //   fromAsset('assets/demo-link.pdf', 'demo.pdf')
  //       .then((value) => {path.value = value.path});
  // }

  // Future<File> fromAsset(String asset, String filename) async {
  //   // To open from assets, you can copy them to the app storage folder, and the access them "locally"
  //   Completer<File> completer = Completer();

  //   try {
  //     var dir = await getApplicationDocumentsDirectory();
  //     File file = File("${dir.path}/$filename");
  //     var data = await rootBundle.load(asset);
  //     var bytes = data.buffer.asUint8List();
  //     await file.writeAsBytes(bytes, flush: true);
  //     completer.complete(file);
  //   } catch (e) {
  //     throw Exception('Error parsing asset file!');
  //   }

  //   return completer.future;
  // }

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }
}
