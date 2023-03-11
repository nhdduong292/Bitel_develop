import 'package:bitel_ventas/main/networks/model/contract_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';

class FTTHContractingLogic extends GetxController {
  late BuildContext context;

  int contractId = 0;
  ContractModel contractModel = ContractModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    contractId = Get.arguments;
    getContract();
  }

  void getContract() {
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_CREATE_CONTRACT}/${contractId.toString()}',
      onSuccess: (response) {
        if (response.isSuccess) {
          contractModel = ContractModel.fromJson(response.data['data']);
          update();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }
}
