import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/document_scanning_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateContactPageLogic extends GetxController {
  late BuildContext context;
  var checkItem2 = false.obs;
  var checkItem3 = false.obs;
  var checkItem4 = false.obs;
  String typeCustomer = '';
  int requestId = 0;
  int productId = 0;
  int reasonId = 0;
  String idNumber = '';
  bool isForcedTerm = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    typeCustomer = data[0];
    requestId = data[1];
    productId = data[2];
    reasonId = data[3];
    idNumber = data[4];
    isForcedTerm = data[5];
  }

  void changeTypeCustomer(String type) {
    typeCustomer = type;
    update();
  }
}
