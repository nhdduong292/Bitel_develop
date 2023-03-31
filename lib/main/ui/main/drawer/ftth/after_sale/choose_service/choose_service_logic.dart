import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_logic.dart';
import 'package:get/get.dart';

class ChooseServiceLogic extends GetxController {
  AfterSaleSearchLogic afterSaleSearchLogic = Get.find();
  bool isActive = true;
  var valueService = (-1).obs;
  void setActive(bool value) {
    isActive = value;
    update();
  }
}
