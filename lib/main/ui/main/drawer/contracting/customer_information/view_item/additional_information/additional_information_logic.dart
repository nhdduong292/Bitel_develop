import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../../../../../../services/connection_service.dart';

class AdditionalInformationLogic extends GetxController {
  late BuildContext context;

  var customer = CustomerModel();
  var isUpdate = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCustomer();
  }

  void getCustomer() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_CUSTOMER}/54/',
      onSuccess: (response) {
        if (response.isSuccess) {
          customer = CustomerModel.fromJson(response.data['data']);
          // update();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }
}
