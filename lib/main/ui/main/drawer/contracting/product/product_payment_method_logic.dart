import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/response/product_response.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../networks/model/method_model.dart';
import '../../../../../networks/model/product_model.dart';

class ProductPaymentMethodLogic extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProduts();
  }

  final ItemScrollController scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  var isOnMethodPage = true.obs;
  var isOnInvoicePage = false.obs;
  var isSelectedMethod = false.obs;
  var isSelectedProduct = false.obs;

  var valueProduct = (-1).obs;
  var valueMethod = (-1).obs;

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

  List<ProductModel> listProduct = [];

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

  void getProduts() {
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_LIST_PRODUCT}/54',
      onSuccess: (response) {
        if (response.isSuccess) {
          listProduct = (response.data['data'] as List)
              .map((postJson) => ProductModel.fromJson(postJson))
              .toList();
          update();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }
}
