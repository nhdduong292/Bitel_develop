import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/document_scanning_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CreateContactPageLogic extends GetxController {
  late BuildContext context;
  var checkItem2 = false.obs;
  var checkItem3 = false.obs;
  var checkItem4 = false.obs;
  String typeCustomer = '';
  int productId = 0;
  int reasonId = 0;
  int promotionId = 0;
  bool isForcedTerm = false;
  List<String> listImageScan = [];
  RequestDetailModel requestModel = RequestDetailModel();

  final ItemScrollController scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    requestModel = data[0];
    productId = data[1];
    reasonId = data[2];
    isForcedTerm = data[3];
    promotionId = data[4];
    typeCustomer = requestModel.customerModel.type;
  }

  void changeTypeCustomer(String type) {
    typeCustomer = type;
    update();
  }

  Future<bool> onWillPop() async {
    if (itemPositionsListener.itemPositions.value.elementAt(0).index == 1) {
      checkItem2.value = false;
      scrollController.scrollTo(
        index: 0,
        duration: const Duration(milliseconds: 200),
      );
      return false;
    } else if (itemPositionsListener.itemPositions.value.elementAt(0).index ==
        2) {
      checkItem3.value = false;
      scrollController.scrollTo(
        index: 1,
        duration: const Duration(milliseconds: 200),
      );
      return false;
    }
    Get.back();
    return false; //<-- SEE HERE
  }
}
