import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/document_scanning_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateContactPageLogic extends GetxController {
  late BuildContext context;
  var checkItem2 = false.obs;
  var checkItem3 = false.obs;
  var checkItem4 = false.obs;
  String typeCustomer = '';
  int productId = 0;
  int reasonId = 0;
  bool isForcedTerm = false;
  RequestDetailModel requestModel = RequestDetailModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    requestModel = data[0];
    productId = data[1];
    reasonId = data[2];
    isForcedTerm = data[3];
    typeCustomer = requestModel.customerModel.type;
  }

  void changeTypeCustomer(String type) {
    typeCustomer = type;
    update();
  }
}
