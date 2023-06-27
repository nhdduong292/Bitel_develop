import 'dart:async';
import 'dart:convert';

import 'package:bitel_ventas/main/networks/model/best_finger_model.dart';
import 'package:bitel_ventas/main/networks/model/cancel_service_infor_model.dart';
import 'package:bitel_ventas/main/networks/model/change_plan_infor_model.dart';
import 'package:bitel_ventas/main/networks/model/transfer_service_infor_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/transfer_service/bill_transfer_service_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../res/app_images.dart';
import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../router/route_config.dart';
import '../../../../../services/connection_service.dart';
import '../../../../../services/settings_service.dart';
import '../../../../../utils/shared_preference.dart';
import '../../../../../utils/values.dart';
import '../../ftth/after_sale/change_plan/information/infor_change_plan_logic.dart';
import '../../ftth/after_sale/date_cancel_service/date_cancel_service_logic.dart';
import '../../utilitis/info_bussiness.dart';

class ValidateFingerprintLogic extends GetxController {
  late BuildContext context;
  String textCapture = "";
  String type = '';
  int cusId = 0;
  int contractId = 0;
  int subId = 0;
  String typeCustomer = '';
  String idNumber = '';
  BestFingerModel bestFinger = BestFingerModel();
  CancelServiceInforModel cancelServiceInforModel = CancelServiceInforModel();
  var pathFinger = ''.obs;
  List<String> listFinger = [];

  bool isGetFingerSuccess = false;
  bool isGetFingerFail = false;
  String pk = "";

  String cancelDate = '';
  String note = '';
  String newPlan = '';
  int fingerId = 0;
  List<int> listIdPromotion = [];

  int requestId = 0;
  ChangePlanInforModel changePlanInforModel = ChangePlanInforModel();
  TransferServiceInforModel transferServiceInforModel =
      TransferServiceInforModel();

  ValidateFingerprintLogic(this.context);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    type = data[0];
    // type empty TH validate cancel service
    // type là Main hoặc Lending validate đăng kí hợp đồng
    // type là staff valiate của nhân viên
    if (type == ValidateFingerStatus.CUSTOMER_CANCEL_SERVICE) {
      cusId = data[1];
      typeCustomer = data[2];
      idNumber = data[3];
      subId = data[4];
      bool isExit = Get.isRegistered<DateCancelServiceLogic>();
      if (isExit) {
        DateCancelServiceLogic dateCancelServiceLogic = Get.find();
        cancelDate = dateCancelServiceLogic.datePicker!
            .toIso8601String()
            .substring(0, 10);
        note = dateCancelServiceLogic.reasonCancel.trim();
        fingerId = dateCancelServiceLogic.fingerId;
      }
    } else if (type == ValidateFingerStatus.CUSTOMER_CHANGE_PLAN) {
      cusId = data[1];
      typeCustomer = data[2];
      idNumber = data[3];
      bool isExit = Get.isRegistered<InforChangePlanLogic>();
      if (isExit) {
        InforChangePlanLogic inforChangePlanLogic = Get.find();
        subId = inforChangePlanLogic.subId;
        newPlan = inforChangePlanLogic.newPlan.productCode ?? "";
        fingerId = inforChangePlanLogic.fingerId;
        listIdPromotion = inforChangePlanLogic.listIdPromotion;
      }
    } else if (type == ValidateFingerStatus.MAIN ||
        type == ValidateFingerStatus.LENDING) {
      cusId = data[1];
      typeCustomer = data[2];
      idNumber = data[3];
      contractId = data[4];
    } else if (type == ValidateFingerStatus.STAFF_CHANGE_PLAN) {
    } else if (type == ValidateFingerStatus.STAFF_TRANSFER_SERVICE) {
    } else if (type == ValidateFingerStatus.CUSTOMER_TRANSFER_SERVICE) {
      cusId = data[1];
      typeCustomer = data[2];
      idNumber = data[3];
      requestId = data[4];
      bool isExit = Get.isRegistered<BillTransferServiceLogic>();
      if (isExit) {
        BillTransferServiceLogic billTransferServiceLogic = Get.find();
        fingerId = billTransferServiceLogic.fingerId;
      }
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if (isStaff()) {
      getBestFingerStaff();
    } else {
      getBestFinger();
    }
  }

  void setCapture(String value) {
    textCapture = value;
    print("text Capture: $textCapture");
    update();
  }

  void getParamPK() async {
    String result = "";
    try {
      final value = await NativeUtil.platformFingerPK
          .invokeMethod(NativeUtil.nameFingerPK);
      result = value;
    } on PlatformException catch (e) {
      e.printInfo();
      return;
    }
    pk = result;
    if (kDebugMode) {
      print("pk: $pk");
    }
    // Common.showToastCenter(pk);
  }

  Future<void> getCapture(BuildContext context) async {
    String language =
        Get.find<SettingService>().currentLocate.value.languageCode;
    textCapture = "";
    String result = "";
    try {
      final argument = {"pk": "0", "language": language};
      final value = await NativeUtil.platformFinger
          .invokeMethod(NativeUtil.nameFinger, argument);
      result = value;
    } on PlatformException catch (e) {
      e.printInfo();
      return;
    }
    try {
      final body = json.decode(result);
      textCapture = body["pathImage"];
      String imageBase64 = body["imageBase64"];
      // pk = body["pk"];
      // if(kDebugMode) {
      //     print("pk: $pk");
      // }
      if (listFinger.isNotEmpty) {
        listFinger.clear();
      }
      if (imageBase64.isNotEmpty) {
        listFinger.add(imageBase64);
        getParamPK();
      }

      update();
      if (listFinger.isNotEmpty) {
        Common.showToastCenter(
            AppLocalizations.of(context)!.textCaptureFingerprintSuccessfully,
            context);
      } else {
        Common.showToastCenter(
            AppLocalizations.of(context)!.textNotifyFingerFail, context);
      }
    } catch (e) {
      Common.showToastCenter(e.toString(), context);
    }
  }

  void getBestFinger() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isGetFingerSuccess = true;
      update();
      return;
    }
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_BEST_FINGER.replaceAll('id', cusId.toString()),
      onSuccess: (response) {
        if (response.isSuccess) {
          bestFinger = BestFingerModel.fromJson(response.data['data']);
          if (bestFinger.left == 0 && bestFinger.right == 0) {
            Common.showSystemErrorLoginDialog(
                context, AppLocalizations.of(context)!.textBestFingerNotExit,
                () {
              Get.back();
            });
            return;
          }
          isGetFingerSuccess = true;
          update();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        isGetFingerFail = true;
        update();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void getBestFingerStaff() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isGetFingerSuccess = true;
      update();
      return;
    }
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_BEST_FINGER_STAFF,
      params: {"staffCode": InfoBusiness.getInstance()!.getUser().staffCode},
      onSuccess: (response) {
        if (response.isSuccess) {
          bestFinger = BestFingerModel.fromJson(response.data['data']);
          if (bestFinger.left == 0 && bestFinger.right == 0) {
            Common.showSystemErrorDialog(context,
                AppLocalizations.of(context)!.textStaffBestFingerNotExit);
            return;
          }
          isGetFingerSuccess = true;
          update();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        isGetFingerFail = true;
        update();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  String findPathFinger(bool isLeft) {
    if (isLeft) {
      if (bestFinger.left == 6) {
        return AppImages.imgFingerLeftThumbUpdate;
      } else if (bestFinger.left == 7) {
        return AppImages.imgFingerLeftIndexUpdate;
      } else if (bestFinger.left == 8) {
        return AppImages.imgFingerLeftMiddleUpdate;
      } else if (bestFinger.left == 9) {
        return AppImages.imgFingerLeftRingUpdate;
      } else if (bestFinger.left == 10) {
        return AppImages.imgFingerLeftLittleUpdate;
      } else {
        return AppImages.imgHandleLeftUpdate;
      }
    } else {
      if (bestFinger.right == 1) {
        return AppImages.imgFingerRightThumbUpdate;
      } else if (bestFinger.right == 2) {
        return AppImages.imgFingerRightIndexUpdate;
      } else if (bestFinger.right == 3) {
        return AppImages.imgFingerRightMiddleUpdate;
      } else if (bestFinger.right == 4) {
        return AppImages.imgFingerRightRingUpdate;
      } else if (bestFinger.right == 5) {
        return AppImages.imgFingerRightLittleUpdate;
      } else {
        return AppImages.imgHandleRightUpdate;
      }
    }
  }

  void signContract(Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    try {
      _onLoading(context);
      Map<String, dynamic> body = {
        "finger": bestFinger.left != 0 ? bestFinger.left : bestFinger.right,
        "listImage": listFinger,
        "pk": pk
      };
      Map<String, dynamic> params = {"type": type};
      ApiUtil.getInstance()!.put(
        url: ApiEndPoints.API_SIGN_CONTRACT
            .replaceAll('id', contractId.toString()),
        body: body,
        params: params,
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            isSuccess.call(true);
          } else {
            isSuccess.call(false);
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          Get.back();
          isSuccess.call(false);
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString(), context);
    }
  }

  void signCancelService(Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    try {
      _onLoading(context);
      Map<String, dynamic> body = {
        "staffFingerId": fingerId,
        "cancelDate": cancelDate,
        "note": note,
        "finger": bestFinger.right != 0 ? bestFinger.right : bestFinger.left,
        "listImage": listFinger,
        "pk": pk
      };
      ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_SIGN_CANCEL_SERVICE
            .replaceAll('subId', subId.toString()),
        params: {'subId': subId.toString()},
        body: body,
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            cancelServiceInforModel =
                CancelServiceInforModel.fromJson(response.data['data']);
            isSuccess.call(true);
          } else {
            isSuccess.call(false);
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          Get.back();
          isSuccess.call(false);
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString(), context);
    }
  }

  void signTransferService(Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    try {
      _onLoading(context);
      Map<String, dynamic> body = {
        "staffFingerId": fingerId,
        "finger": bestFinger.right != 0 ? bestFinger.right : bestFinger.left,
        "listImage": listFinger,
        "pk": pk
      };
      ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_SIGN_TRANSFER_SERVICE
            .replaceAll('requestId', requestId.toString()),
        params: {'requestId': requestId.toString()},
        body: body,
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            transferServiceInforModel =
                TransferServiceInforModel.fromJson(response.data['data']);
            isSuccess.call(true);
          } else {
            isSuccess.call(false);
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          Get.back();
          isSuccess.call(false);
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString(), context);
    }
  }

  void validateStaffFingerCancelService(Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    try {
      _onLoading(context);
      Map<String, dynamic> body = {
        "finger": bestFinger.right != 0 ? bestFinger.right : bestFinger.left,
        "listImage": listFinger,
        "pk": pk
      };
      ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_VALIDATE_STAFF_FINGER,
        params: {"staffCode": InfoBusiness.getInstance()!.getUser().staffCode},
        body: body,
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            fingerId = response.data['data']['fingerId'];
            isSuccess.call(true);
          } else {
            isSuccess.call(false);
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          Get.back();
          isSuccess.call(false);
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString(), context);
    }
  }

  void validateStaffFingerChangePlan(Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    try {
      _onLoading(context);
      Map<String, dynamic> body = {
        "finger": bestFinger.right != 0 ? bestFinger.right : bestFinger.left,
        "listImage": listFinger,
        "pk": pk
      };
      ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_VALIDATE_STAFF_FINGER_CHANGE_PLAN,
        params: {"staffCode": InfoBusiness.getInstance()!.getUser().staffCode},
        body: body,
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            fingerId = response.data['data']['fingerId'];
            isSuccess.call(true);
          } else {
            isSuccess.call(false);
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          Get.back();
          isSuccess.call(false);
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString(), context);
    }
  }

  void validateStaffFingerTransferService(Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    try {
      _onLoading(context);
      Map<String, dynamic> body = {
        "finger": bestFinger.right != 0 ? bestFinger.right : bestFinger.left,
        "listImage": listFinger,
        "pk": pk
      };
      ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_VALIDATE_STAFF_FINGER_TRANSFER_SERVICE,
        params: {"staffCode": InfoBusiness.getInstance()!.getUser().staffCode},
        body: body,
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            fingerId = response.data['data']['fingerId'];
            isSuccess.call(true);
          } else {
            isSuccess.call(false);
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          Get.back();
          isSuccess.call(false);
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString(), context);
    }
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

  bool isStaff() {
    if (type == ValidateFingerStatus.STAFF_CANCEL_SERVICE ||
        type == ValidateFingerStatus.STAFF_CHANGE_PLAN ||
        type == ValidateFingerStatus.STAFF_TRANSFER_SERVICE) {
      return true;
    } else {
      return false;
    }
  }

  void validateCustomerChangePlan(Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    try {
      _onLoading(context);
      Map<String, dynamic> body = {
        "staffFingerId": fingerId,
        "newPlan": newPlan,
        "promotionId": listIdPromotion,
        "finger": bestFinger.right != 0 ? bestFinger.right : bestFinger.left,
        "listImage": listFinger,
        "pk": pk
      };
      ApiUtil.getInstance()!.put(
        url: ApiEndPoints.API_CHANGE_PLAN_SIGN,
        params: {"subId": subId},
        body: body,
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            changePlanInforModel =
                ChangePlanInforModel.fromJson(response.data['data']);
            isSuccess.call(true);
          } else {
            isSuccess.call(false);
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          Get.back();
          isSuccess.call(false);
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString(), context);
    }
  }

  void onSign() {
    if (listFinger.isEmpty) {
      return;
    }

    if (type == ValidateFingerStatus.CUSTOMER_TRANSFER_SERVICE) {
      signTransferService(
        (isSuccess) {
          if (isSuccess) {
            Get.toNamed(RouteConfig.inforTransferService, arguments: [
              transferServiceInforModel,
            ]);
          }
        },
      );
      return;
    }

    if (type == ValidateFingerStatus.CUSTOMER_CANCEL_SERVICE) {
      signCancelService(
        (isSuccess) {
          if (isSuccess) {
            Get.toNamed(RouteConfig.cancelServiceInfor, arguments: [
              cancelServiceInforModel,
            ]);
          }
        },
      );
      return;
    }

    if (type == ValidateFingerStatus.CUSTOMER_CHANGE_PLAN) {
      validateCustomerChangePlan(
        (isSuccess) {
          if (isSuccess) {
            Get.toNamed(RouteConfig.successChangePlan,
                arguments: [changePlanInforModel]);
          }
        },
      );
      return;
    }

    if (type == ValidateFingerStatus.STAFF_CHANGE_PLAN) {
      validateStaffFingerChangePlan(
        (isSuccess) {
          if (isSuccess) {
            Get.back(result: fingerId);
          }
        },
      );
      return;
    }

    if (type == ValidateFingerStatus.STAFF_TRANSFER_SERVICE) {
      validateStaffFingerTransferService(
        (isSuccess) {
          if (isSuccess) {
            Get.back(result: fingerId);
          }
        },
      );
      return;
    }

    if (type == ValidateFingerStatus.STAFF_CANCEL_SERVICE) {
      validateStaffFingerCancelService(
        (isSuccess) {
          if (isSuccess) {
            Get.back(result: fingerId);
          }
        },
      );
      return;
    }

    if (type == ValidateFingerStatus.LENDING) {
      signContract(
        (p0) {
          if (p0) {
            Get.toNamed(RouteConfig.ftthContracting, arguments: [
              contractId,
            ]);
          }
        },
      );
    } else if (type == ValidateFingerStatus.MAIN) {
      signContract(
        (p0) {
          if (p0) {
            Get.back(result: true);
          }
        },
      );
      return;
    }
  }
}
