import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';

class ContractInformationLogic extends GetxController {
  late BuildContext context;
  var checkOption1 = false.obs;
  var checkOption2 = false.obs;
  var checkOption3 = false.obs;
  var checkOption4 = false.obs;

  DateTime now = DateTime.now();

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
      "requestId": 0,
      "productId": 0,
      "reasonId": 0,
      "promotionId": 0,
      "contractType": "UNDETERMINED",
      "numOfSubscriber": 0,
      "signDate": "2023-03-03T03:35:05.273Z",
      "billCycle": "CYCLE6",
      "changeNotification": "string",
      "printBill": "string",
      "currency": "string",
      "language": "ASHANINKA",
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
      onSuccess: (response) {
        if (response.isSuccess) {
          update();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }
}