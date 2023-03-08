import 'dart:async';
import 'dart:ffi';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/response/product_response.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../networks/model/customer_model.dart';
import '../../../../../networks/model/method_model.dart';
import '../../../../../networks/model/plan_reason_model.dart';
import '../../../../../networks/model/product_model.dart';

class ProductPaymentMethodLogic extends GetxController {
  int requestId = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestId = Get.arguments;
    getProduts(requestId);
  }

  final ItemScrollController scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  var isOnMethodPage = true.obs;
  var isOnInvoicePage = false.obs;
  var balance = (0.0).obs; // so du trong vi
  var valueProduct = (-1).obs; // index cua product
  var valueMethod = (-1).obs; // index cua reason
  var totalPayment = 0; // tong tien phai thanh toan

  CustomerModel customer = CustomerModel();

  List<PlanReasonModel> listPlanReason = [];

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

  void getProduts(int requestId) {
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_LIST_PRODUCT}/$requestId',
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

  ProductModel getProduct() {
    if (valueProduct.value > -1) {
      return listProduct[valueProduct.value];
    }
    return ProductModel();
  }

  PlanReasonModel getPlanReason() {
    if (valueMethod.value > -1) {
      return listPlanReason[valueMethod.value];
    }
    return PlanReasonModel();
  }

  void resetPlanReason() {
    listPlanReason.clear();
    valueMethod.value = -1;
  }

  void getPlanReasons(int id) {
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_PLAN_REASON}/$id',
      onSuccess: (response) {
        if (response.isSuccess) {
          listPlanReason = (response.data['data'] as List)
              .map((postJson) => PlanReasonModel.fromJson(postJson))
              .toList();
          update();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }

  void getWallet() {
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_WALLET,
      onSuccess: (response) {
        if (response.isSuccess) {
          balance.value = response.data['data'] as double;
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {},
    );
  }

  Future<bool> checkRegisterCustomer() async {
    Completer<bool> completer = Completer();
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_CUSTOMER}/$requestId/',
      onSuccess: (response) {
        if (response.isSuccess) {
          customer = CustomerModel.fromJson(response.data['data']);
          completer.complete(true);
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        completer.complete(false);
      },
    );
    return completer.future;
  }
}
