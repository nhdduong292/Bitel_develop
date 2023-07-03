import 'dart:async';
import 'dart:convert';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/bill_model.dart';
import 'package:bitel_ventas/main/networks/model/package_model.dart';
import 'package:bitel_ventas/main/networks/model/plan_ott_model.dart';
import 'package:bitel_ventas/main/networks/model/promotion_model.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/model/request_ott_service_model.dart';
import 'package:bitel_ventas/main/networks/response/product_response.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../networks/model/customer_model.dart';
import '../../../../../networks/model/method_model.dart';
import '../../../../../networks/model/plan_reason_model.dart';
import '../../../../../networks/model/product_model.dart';
import '../../../../../networks/model/sub_ott_model.dart';
import '../../../../../services/connection_service.dart';
import '../../../../../utils/common.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductPaymentMethodLogic extends GetxController {
  bool isLoadingProduct = true;
  bool isLoadingPackage = true;
  BuildContext context;
  bool isLoadingReason = true;
  bool isLoadingPromotion = true;
  bool isLoadingOTTService = true;
  bool isLoadingWallet = true;
  bool isLoadingBill = true;

  // String province = '';
  // String district = '';
  // String precinct = '';

  RequestDetailModel requestModel = RequestDetailModel();

  String status = 'CREATE';

  List<int> listSelectOtt = [];
  List<int> listSelectCableGo = [];
  var valueCableGo = (-1).obs;
  String currentEmail = "";
  bool isCableGo = false;
  SubOTTModel currentSubOTT = SubOTTModel();

  bool isPayBankCode = false;

  ProductPaymentMethodLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    requestModel = data[0];
    status = data[1];
    getProduts(requestModel.id);
    getPackages(requestModel.id);
  }

  final ItemScrollController? scrollController = ItemScrollController();
  final ItemPositionsListener? itemPositionsListener =
      ItemPositionsListener.create();

  var isOnMethodPage = true.obs;
  var isOnInvoicePage = false.obs;
  var balance = (0.0).obs; // so du trong vi
  var valueProduct = (-1).obs; // index cua product
  var valuePackage = (-1).obs; // index cua package
  var valueMethod = (-1).obs; // index cua reason
  var valuePromotion = (-1).obs; //index cua promotion
  var valueOTT = (-1).obs; //index cua promotion
  var totalPayment = 0; // tong tien phai thanh toan

  CustomerModel customer = CustomerModel();

  List<PlanReasonModel> listPlanReason = [];

  List<PlanOttModel> listPlanOTT = [];

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
  List<PackageModel> listPackage = [];
  List<PromotionModel> listPromotion = [];
  List<int> listIdPromotion = [];
  BillModel billModel = BillModel();

  void getProduts(int requestId) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isLoadingProduct = false;
      update();
      return;
    }
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_LIST_PRODUCT}/$requestId',
      onSuccess: (response) {
        if (response.isSuccess) {
          listProduct = (response.data['data'] as List)
              .map((postJson) => ProductModel.fromJson(postJson))
              .toList();
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

  void getPackages(int requestId) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isLoadingPackage = false;
      update();
      return;
    }
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_GET_PACKAGE,
      onSuccess: (response) {
        if (response.isSuccess) {
          listPackage = (response.data['data'] as List)
              .map((postJson) => PackageModel.fromJson(postJson))
              .toList();
        } else {
          print("error: ${response.status}");
        }
        isLoadingPackage = false;
        update();
      },
      onError: (error) {
        isLoadingPackage = false;
        update();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void checkLoading() {
    if (!isLoadingReason && !isLoadingPromotion && !isLoadingOTTService) {
      // Get.back();
    } else if (isLoadingReason && isLoadingPromotion && isLoadingOTTService) {
      // _onLoading(context);
    }
  }

  void checkLoadingBill() {
    if (!isLoadingBill && !isLoadingWallet) {
      Get.back();
    } else if (isLoadingBill && isLoadingWallet) {
      _onLoading(context);
    }
  }

  void getPromotions() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isLoadingPromotion = false;
      checkLoading();
      return;
    }
    isLoadingPromotion = true;
    update();
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_LIST_PROMOTION,
      params: {
        'productId': getProduct().productId,
        'packageId': getPackage().packageId
      },
      onSuccess: (response) {
        isLoadingPromotion = false;
        update();
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

  PackageModel getPackage() {
    if (valuePackage.value > -1) {
      return listPackage[valuePackage.value];
    }
    return PackageModel();
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

  void resetPackage() {
    valuePackage.value = -1;
  }

  void resetPlanReason() {
    listPlanReason.clear();
    valueMethod.value = -1;
  }

  void resetPromotions() {
    listPromotion.clear();
    valuePromotion.value = -1;
  }

  void resetPlanOTTs() {
    listSelectOtt.clear();
    listPlanOTT.clear();
    valueOTT.value = -1;
  }

  bool isForcedTerm() {
    if (getPlanReason().feeInstallation != null &&
        getPlanReason().feeInstallation! > 0.0) {
      return false;
    }
    return true;
  }

  void getPlanReasons() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isLoadingReason = false;
      checkLoading();
      return;
    }
    isLoadingReason = true;
    update();
    try {
      ApiUtil.getInstance()!.get(
        url: '${ApiEndPoints.API_PLAN_REASON}/${getProduct().productId}',
        params: {
          "requestId": requestModel.id,
          "packageId": getPackage().packageId
        },
        onSuccess: (response) {
          isLoadingReason = false;
          update();
          checkLoading();
          if (response.isSuccess) {
            listPlanReason = (response.data['data'] as List)
                .map((postJson) => PlanReasonModel.fromJson(postJson))
                .toList();
            update();
          } else {
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          isLoadingReason = false;
          update();
          checkLoading();
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      isLoadingReason = false;
      update();
      checkLoading();
      Common.showToastCenter(e.toString(), context);
    }
  }

  void getWallet(BuildContext context) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isLoadingWallet = false;
      checkLoadingBill();
      return;
    }
    isLoadingWallet = true;
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

  void checkRegisterCustomer(BuildContext context, var isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_CUSTOMER}/${requestModel.id}/',
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          customer = CustomerModel.fromJson(response.data['data']);
          isSuccess(true);
        } else {
          print("error: ${response.status}");
          isSuccess(false);
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
                isSuccess(false);
              } else {
                Common.showMessageError(error: error, context: context);
              }
            } else {
              Common.showToastCenter(
                  AppLocalizations.of(context)!.textErrorAPI, context);
            }
          }
        } catch (e) {
          Common.showToastCenter(
              AppLocalizations.of(context)!.textErrorAPI, context);
        }
      },
    );
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

  void postContractInformation() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isLoadingBill = false;
      checkLoadingBill();
      return;
    }
    isLoadingBill = true;
    Map<String, dynamic> body = {
      "requestId": requestModel.id,
      "productId": getProduct().productId,
      "reasonId": getPlanReason().id,
      "packageId": getPackage().packageId,
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
      "receiveFromBitel": null,
      "ottServices": getJsonOTTService()
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
        // Common.showMessageError(error: error, context: context);
      },
    );
  }

  void checkBalance(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CHECK_BALANCE,
      params: {"amount": billModel.total},
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          onSuccess(true);
        } else {
          onSuccess(false);
        }
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
        try {
          String errorCode = error.response!.data['errorCode'];
          if (errorCode == 'E028') {
            onSuccess(false);
          }
          // ignore: empty_catches
        } catch (e) {}
      },
    );
  }

  void getOTTService() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isLoadingOTTService = false;
      checkLoading();
      return;
    }
    isLoadingOTTService = true;
    update();
    try {
      ApiUtil.getInstance()!.get(
        url: '${ApiEndPoints.API_GET_OTT}/${getProduct().productId}',
        params: {
          "planId": getProduct().productId,
        },
        onSuccess: (response) {
          isLoadingOTTService = false;
          update();
          checkLoading();
          if (response.isSuccess) {
            listPlanOTT = (response.data['data'] as List)
                .map((postJson) => PlanOttModel.fromJson(postJson))
                .toList();
            for (var model in listPlanOTT) {
              int index = listPlanOTT.indexOf(model);
              listSelectOtt.add(index);
            }
            update();
          } else {
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          isLoadingOTTService = false;
          update();
          checkLoading();
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      isLoadingOTTService = false;
      update();
      checkLoading();
      Common.showToastCenter(e.toString(), context);
    }
  }

  void onChangePhoneNumber(String type, String value, PlanOttModel ott) {
    isCableGo = false;
    if (value.isEmpty) {
      ott.errorText = AppLocalizations.of(context)!.textCannotBeBlank;
      ott.isSuccess = false;
    } else if (value.length < 9) {
      ott.errorText = AppLocalizations.of(context)!.textMustBeA9DigitsNumbers;
      ott.isSuccess = false;
    } else if (value.length == 9) {
      ott.errorText = null;
      checkSim(type, value, (isSuccess) {
        if (!isSuccess) {
          ott.focusNode!.requestFocus();
          ott.isSuccess = false;
          ott.errorText = AppLocalizations.of(context)!.textMustBeBitelNumber;
        } else {
          FocusScope.of(context).requestFocus(FocusNode());
          ott.errorText = null;
          ott.isSuccess = true;
          ott.isdn = value;
        }
        update();
      });
    }
    update();
  }

  void checkEmailCableGo(var onSuccess) {
    if (!isCableGo) {
      onSuccess(true);
      return;
    }
    if (Common.validateEmail(currentEmail)) {
      checkSim(OTTService.CABLE_GO, currentEmail, (isSuccess) {
        if (!isSuccess) {
          currentSubOTT.focusNode!.requestFocus();
          currentSubOTT.isSuccess = false;
          currentSubOTT.errorText =
              AppLocalizations.of(context)!.textMustBeAnEmailFormat;
          onSuccess(false);
        } else {
          currentSubOTT.errorText = null;
          currentSubOTT.isSuccess = true;
          currentSubOTT.email = currentEmail;
          onSuccess(true);
        }
        update();
      });
    }
  }

  void onChangeEmail(String value, SubOTTModel model) {
    isCableGo = true;
    currentEmail = value;
    currentSubOTT = model;
    if (value.isEmpty) {
      model.errorText = AppLocalizations.of(context)!.textCannotBeBlank;
      model.isSuccess = false;
    } else if (!Common.validateEmail(value)) {
      model.errorText = AppLocalizations.of(context)!.textMustBeAnEmailFormat;
      model.isSuccess = false;
    } else {
      model.errorText = null;
      model.isSuccess = true;
      model.email = value;
      update();
    }
    update();
  }

  void checkSim(String type, String value, var isSuccess) {
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CHECK_SIM,
      params: {
        "serviceType": type,
        "isdn": value,
      },
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          isSuccess(true);
        } else {
          isSuccess(false);
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        Get.back();
        isSuccess(false);
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  bool checkBtnContinue() {
    if (valueMethod.value > -1 &&
        valueProduct.value > -1 &&
        valuePackage.value > -1) {
      for (int value in listSelectOtt) {
        if (!listPlanOTT[value].isSuccess &&
            listPlanOTT[value].ottService != OTTService.CABLE_GO) {
          listPlanOTT[value].focusNode!.requestFocus();
          return false;
        } else if (listPlanOTT[value].ottService == OTTService.CABLE_GO) {
          if (valueCableGo.value < 0) {
            return true;
          }
          if (!listPlanOTT[value].listSubOtt[valueCableGo.value].isSuccess) {
            listPlanOTT[value]
                .listSubOtt[valueCableGo.value]
                .focusNode!
                .requestFocus();
            return false;
          }
        }
      }
      return true;
    } else {
      return false;
    }
  }

  List<RequestOTTServiceModel> getJsonOTTService() {
    List<RequestOTTServiceModel> list = [];
    for (int value in listSelectOtt) {
      if (listPlanOTT[value].ottService != OTTService.CABLE_GO) {
        list.add(RequestOTTServiceModel(
            ottService: listPlanOTT[value].ottService,
            ottCode: listPlanOTT[value].listSubOtt[0].ottCode,
            isdn: listPlanOTT[value].isdn,
            promotionIds: listPlanOTT[value].listSubOtt[0].getPromotionIds()));
      } else {
        if (valueCableGo.value > -1) {
          list.add(RequestOTTServiceModel(
              ottService: listPlanOTT[value].ottService,
              ottCode:
                  listPlanOTT[value].listSubOtt[valueCableGo.value].ottCode,
              isdn: listPlanOTT[value].listSubOtt[valueCableGo.value].email,
              promotionIds: listPlanOTT[value]
                  .listSubOtt[valueCableGo.value]
                  .getPromotionIds()));
        }
      }
    }
    return list;
  }
}
