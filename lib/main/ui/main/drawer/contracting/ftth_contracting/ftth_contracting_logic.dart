import 'package:bitel_ventas/main/networks/model/contract_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';

class FTTHContractingLogic extends GetxController {
  late BuildContext context;

  ContractModel contractModel = ContractModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getContract();
  }

  void getContract() {
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_CREATE_CONTRACT}/54',
      onSuccess: (response) {
        if (response.isSuccess) {
          contractModel = ContractModel.fromJson(response.data);
          update();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }
}
