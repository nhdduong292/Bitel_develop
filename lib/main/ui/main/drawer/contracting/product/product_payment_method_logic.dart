import 'dart:async';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/bill_model.dart';
import 'package:bitel_ventas/main/networks/model/promotion_model.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/response/product_response.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../networks/model/customer_model.dart';
import '../../../../../networks/model/method_model.dart';
import '../../../../../networks/model/plan_reason_model.dart';
import '../../../../../networks/model/product_model.dart';
import '../../../../../utils/common.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductPaymentMethodLogic extends GetxController {
  bool isLoadingProduct = true;
  BuildContext context;
  bool isLoadingReason = true;
  bool isLoadingPromotion = true;
  bool isLoadingWallet = true;
  bool isLoadingBill = true;

  // String province = '';
  // String district = '';
  // String precinct = '';

  RequestDetailModel requestModel = RequestDetailModel();

  String status = 'CREATE';
  int currentProduct = 2;
  int currentReason = 2;
  bool isChanged = false;

  ProductPaymentMethodLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    requestModel = data[0];
    status = data[1];
    getProduts(requestModel.id);
  }

  final ItemScrollController? scrollController = ItemScrollController();
  final ItemPositionsListener? itemPositionsListener =
      ItemPositionsListener.create();

  var isOnMethodPage = true.obs;
  var isOnInvoicePage = false.obs;
  var balance = (0.0).obs; // so du trong vi
  var valueProduct = (-1).obs; // index cua product
  var valueMethod = (-1).obs; // index cua reason
  var valuePromotion = (-1).obs; //index cua promotion
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
  List<PromotionModel> listPromotion = [];
  List<int> listIdPromotion = [];
  BillModel billModel = BillModel();

  double getTotal() {
    if (getPlanReason().fee == null ||
        getPlanReason().feeInstallation == null) {
      return 0.0;
    }
    return getPlanReason().fee! + getPlanReason().feeInstallation!;
  }

  void getProduts(int requestId) {
    requestId = 20735;
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_LIST_PRODUCT}/$requestId',
      onSuccess: (response) {
        if (response.isSuccess) {
          listProduct = (response.data['data'] as List)
              .map((postJson) => ProductModel.fromJson(postJson))
              .toList();
          if (status == 'CHANGE') {
            valueProduct.value = currentProduct;
            getPlanReasons(listProduct[currentProduct].productId!, context);
          }
        } else {
          print("error: ${response.status}");
        }
        isLoadingProduct = false;
        update();
      },
      onError: (error) {
        isLoadingProduct = false;
        update();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void checkLoading() {
    if (!isLoadingReason && !isLoadingPromotion) {
      Get.back();
    } else if (isLoadingReason && isLoadingPromotion) {
      _onLoading(context);
    }
  }

  void checkLoadingBill() {
    if (!isLoadingBill && !isLoadingWallet) {
      Get.back();
    } else if (isLoadingBill && isLoadingWallet) {
      _onLoading(context);
    }
  }

  void getPromotions(int idProduct) {
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_LIST_PROMOTION,
      params: {'productId': idProduct},
      onSuccess: (response) {
        isLoadingPromotion = false;
        checkLoading();
        if (response.isSuccess) {
          listPromotion = (response.data['data'] as List)
              .map((postJson) => PromotionModel.fromJson(postJson))
              .toList();
          getListIdPromotion();
        } else {
          print("error: ${response.status}");
        }
        update();
      },
      onError: (error) {
        isLoadingPromotion = false;
        checkLoading();
        update();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void getListIdPromotion() {
    listIdPromotion.clear();
    for (var promotion in listPromotion) {
      listIdPromotion.add(promotion.proId ?? 0);
    }
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

  PromotionModel getPromotion() {
    if (valuePromotion.value > -1) {
      return listPromotion[valuePromotion.value];
    }
    return PromotionModel();
  }

  void resetPlanReason() {
    listPlanReason.clear();
    valueMethod.value = -1;
  }

  void resetPromotions() {
    listPromotion.clear();
    valuePromotion.value = -1;
  }

  bool isForcedTerm() {
    if (getPlanReason().feeInstallation != null &&
        getPlanReason().feeInstallation! > 0.0) {
      return false;
    }
    return true;
  }

  void getPlanReasons(int id, BuildContext context) {
    try {
      ApiUtil.getInstance()!.get(
        url: '${ApiEndPoints.API_PLAN_REASON}/$id',
        onSuccess: (response) {
          isLoadingReason = false;
          checkLoading();
          if (response.isSuccess) {
            listPlanReason = (response.data['data'] as List)
                .map((postJson) => PlanReasonModel.fromJson(postJson))
                .toList();
            if (valueProduct.value == currentProduct && !isChanged) {
              valueMethod.value = currentReason;
            }
            update();
          } else {
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          isLoadingReason = false;
          checkLoading();
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString());
    }
  }

  void getWallet(BuildContext context) {
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_WALLET,
      onSuccess: (response) {
        isLoadingWallet = false;
        checkLoadingBill();
        if (response.isSuccess) {
          balance.value = response.data['data'] as double;
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        isLoadingWallet = false;
        checkLoadingBill();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  Future<bool> checkRegisterCustomer(BuildContext context) async {
    _onLoading(context);
    Completer<bool> completer = Completer();
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_CUSTOMER}/${requestModel.id}/',
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          customer = CustomerModel.fromJson(response.data['data']);
          completer.complete(true);
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        Get.back();

        try {
          if (error != null) {
            if (error is DioError &&
                error.response!.data['errorCode'] != null) {
              //neu tra ve code E012 la chua dang ky khach hang
              if (error.response!.data['errorCode'] == 'E012') {
                completer.complete(false);
              } else {
                Common.showMessageError(error: error, context: context);
              }
            } else {
              Common.showToastCenter(
                  AppLocalizations.of(context)!.textErrorAPI);
            }
          }
        } catch (e) {
          Common.showToastCenter(AppLocalizations.of(context)!.textErrorAPI);
        }
      },
    );
    return completer.future;
  }

  bool checkChangePackage() {
    if ((valueProduct.value == currentProduct) &&
        (valueMethod.value == currentReason)) {
      return false;
    }
    return true;
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: LoadingCirculApi(),
        );
      },
    );
  }

  Future<bool> onWillPop() async {
    if (isLoadingProduct) {
      Get.back();
      return false;
    }
    if (itemPositionsListener?.itemPositions.value.elementAt(0).index == 0) {
      Get.back();
    } else {
      isOnInvoicePage.value = false;
      isOnMethodPage.value = true;
      scrollController?.scrollTo(
        index: 0,
        duration: const Duration(milliseconds: 200),
      );
    }
    return false; //<-- SEE HERE
  }

  void postContractInformation() {
    Map<String, dynamic> body = {
      "requestId": requestModel.id,
      "productId": getProduct().productId,
      "reasonId": getPlanReason().id,
      "packageId": getPlanReason().packageId,
      "promotionId": listIdPromotion,
      "contractType": isForcedTerm() ? "FORCED_TERM" : "UNDETERMINED",
      "numOfSubscriber": 1,
      "signDate": null,
      "billCycle": "CYCLE6",
      "changeNotification": "Email",
      "printBill": "Email",
      "currency": "SOL",
      "language": null,
      "province": null,
      "district": null,
      "precinct": null,
      "address": null,
      "phone": null,
      "email": null,
      "protectionFilter": null,
      "receiveInfoByMail": null,
      "receiveFromThirdParty": null,
      "receiveFromBitel": null
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_POST_CONTRACT_INFORMATION,
      body: body,
      onSuccess: (response) {
        isLoadingBill = false;
        checkLoadingBill();
        if (response.isSuccess) {
          billModel = BillModel.fromJson(response.data['data']);
          update();
          print(response.data['data']);
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        isLoadingBill = false;
        checkLoadingBill();
        Common.showMessageError(error: error, context: context);
      },
    );
  }
}
