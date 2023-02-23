import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
class ProductPaymentMethodLogic extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  final ItemScrollController scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();

  var isOnMethodPage = false.obs;
  var isOnInvoicePage = false.obs;
}