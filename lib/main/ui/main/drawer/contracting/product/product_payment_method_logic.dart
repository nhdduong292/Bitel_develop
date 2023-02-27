import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../networks/model/method_model.dart';
import '../../../../../networks/model/product_model.dart';

class ProductPaymentMethodLogic extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  final ItemScrollController scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  var isOnMethodPage = true.obs;
  var isOnInvoicePage = false.obs;
  var isSelectedMethod = false.obs;
  var isSelectedProduct = false.obs;

  ProductModel selectedProduct = ProductModel();
  void setSelectedProduct(ProductModel product) {
    selectedProduct = product;
    update();
  }

  MethodModel selectedMethod = MethodModel();
  void setSelectedMethod(MethodModel method) {
    selectedMethod = method;
    update();
  }

  List<ProductModel> listProduct = [
    ProductModel(
        name: 'BITELFIBRA 100',
        desc: 'Bitelfibra 100',
        speed: '100.00 Mpbs',
        price: '89/month'),
    ProductModel(
        name: 'BITELFIBRA 100',
        desc: 'Bitelfibra 100',
        speed: '100.00 Mpbs',
        price: '89/month'),
    ProductModel(
        name: 'BITELFIBRA 100',
        desc: 'Bitelfibra 100',
        speed: '100.00 Mpbs',
        price: '89/month'),
    ProductModel(
        name: 'BITELFIBRA 100',
        desc: 'Bitelfibra 100',
        speed: '100.00 Mpbs',
        price: '89/month'),
  ];

  List<MethodModel> listMethod = [
    MethodModel(
        name: 'Pre paid 1 month 0%',
        freeInstallation: 0,
        reasonCodeName: '093020',
        price: '89/month'),
    MethodModel(
        name: 'Pre paid 2 month 0%',
        freeInstallation: 0,
        reasonCodeName: '093020',
        price: '89/month'),
    MethodModel(
        name: 'Pre paid 3 month 0%',
        freeInstallation: 0,
        reasonCodeName: '093020',
        price: '89/month'),
  ];
}
