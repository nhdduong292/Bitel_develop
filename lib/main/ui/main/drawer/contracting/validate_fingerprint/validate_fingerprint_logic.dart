import 'dart:async';
import 'dart:convert';

import 'package:bitel_ventas/main/networks/model/best_finger_model.dart';
import 'package:bitel_ventas/main/networks/model/cancel_service_infor_model.dart';
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

import '../../../../../services/settings_service.dart';
import '../../../../../utils/shared_preference.dart';
import '../../../../../utils/values.dart';
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
  String pk = "";

  String cancelDate = '';
  String note = '';

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
    if (type == ValidateFingerStatus.STAFF_CANCEL_SERVICE || type.isEmpty) {
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
      }
    } else if (type == ValidateFingerStatus.MAIN ||
        type == ValidateFingerStatus.LENDING) {
      cusId = data[1];
      typeCustomer = data[2];
      idNumber = data[3];
      contractId = data[4];
    } else if (type == ValidateFingerStatus.STAFF_CHANGE_PLAN) {}
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if (type == ValidateFingerStatus.STAFF_CANCEL_SERVICE ||
        type == ValidateFingerStatus.STAFF_CHANGE_PLAN) {
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
            AppLocalizations.of(context)!.textCaptureFingerprintSuccessfully);
      } else {
        Common.showToastCenter(
            AppLocalizations.of(context)!.textNotifyFingerFail);
      }
    } catch (e) {
      Common.showToastCenter(e.toString());
    }
  }

  void getBestFinger() {
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
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void getBestFingerStaff() {
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_BEST_FINGER_STAFF,
      params: {"staffCode": InfoBusiness.getInstance()!.getUser().staffCode},
      onSuccess: (response) {
        if (response.isSuccess) {
          bestFinger = BestFingerModel.fromJson(response.data['data']);
          if (bestFinger.left == 0 && bestFinger.right == 0) {
            Common.showSystemErrorDialog(
                context, AppLocalizations.of(context)!.textBestFingerNotExit);
            return;
          }
          isGetFingerSuccess = true;
          update();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
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

  void signContract(Function(bool) isSuccess) {
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
      Common.showToastCenter(e.toString());
    }
  }

  void signCancelService(Function(bool) isSuccess) {
    try {
      _onLoading(context);
      Map<String, dynamic> body = {
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
      Common.showToastCenter(e.toString());
    }
  }

  void validateStaffFinger(Function(bool) isSuccess) {
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
      Common.showToastCenter(e.toString());
    }
  }

  void validateStaffFingerChangePlan(Function(bool) isSuccess) {
    try {
      _onLoading(context);
      Map<String, dynamic> body = {
        "isBypass": true,
        "isUploadContractLate": true,
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
      Common.showToastCenter(e.toString());
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
        type == ValidateFingerStatus.STAFF_CHANGE_PLAN) {
      return true;
    } else {
      return false;
    }
  }
}
