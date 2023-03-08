import 'dart:async';
import 'dart:io';

import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/view_item/contract_preview/contract_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  var path = '';
  var checkOption = false.obs;

  CustomerModel customer = CustomerModel();
  CustomerInformationLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCustomer();
    fromAsset('assets/demo-link.pdf', 'demo.pdf')
        .then((value) => {path = value.path});
  }

  void getCurrentTime() {
    DateTime now = DateTime.now();
    signDate.value = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
  }

  void getCustomer() {
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_CUSTOMER}/54/',
      onSuccess: (response) {
        if (response.isSuccess) {
          customer = CustomerModel.fromJson(response.data['data']);
          update();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }

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
      "requestId": 54,
      "productId": 0,
      "reasonId": 0,
      "promotionId": 0,
      "contractType": "UNDETERMINED",
      "numOfSubscriber": 0,
      "signDate": signDate.value,
      "billCycle": "CYCLE6",
      "changeNotification": "string",
      "printBill": "string",
      "currency": "string",
      "language": contractLanguagetValue.value.toUpperCase(),
      "province": "string",
      "district": "string",
      "precinct": "string",
      "address": "string",
      "phone": "string",
      "email": "string",
      "protectionFilter": true,
      "receiveInfoByMail": true,
      "receiveFromThirdParty": true,
      "receiveFromBitel": true
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

  void contractPreview() {
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CONTRACT_PREVIEW.replaceAll("id", "54"),
      params: {"type": "MAIN"},
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

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }
}
