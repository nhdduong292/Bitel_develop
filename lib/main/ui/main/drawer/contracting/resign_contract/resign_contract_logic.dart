import 'dart:io';
import 'dart:typed_data';

import 'package:bitel_ventas/main/ui/main/drawer/contracting/resign_contract/review_order_information_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import '../../../../../services/connection_service.dart';
import '../../../../../utils/common.dart';
import '../../../../../utils/common_widgets.dart';
import '../../../../../utils/values.dart';
import '../product/product_payment_method_logic.dart';
import 'package:permission_handler/permission_handler.dart';

class ReSignContractLogic extends GetxController {
  late BuildContext context;

  var checkMainContract = true.obs;
  var checkLendingContract = false.obs;
  var checkOption = true.obs;

  String paymentMethod = "";
  bool isVoiceContract = false;
  String voiceContractCallId = "";
  int contractId = 0;

  RxDouble progessValue = 0.0.obs;
  Uint8List? bytesPDF;

  String cusFullName = "";
  RequestDetailLogic requestDetailLogic = Get.find();

  ReSignContractLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    contractId = requestDetailLogic.requestModel.contractModel.contractId;
    paymentMethod = requestDetailLogic.requestModel.paymentMethod;
    isVoiceContract = requestDetailLogic.requestModel.isVoiceContract;
    voiceContractCallId = requestDetailLogic.requestModel.callId.toString();
    if (isVoiceContract) {
      paymentMethod = PaymentType.BANK_CODE;
    }

    bool isExit = Get.isRegistered<RequestDetailLogic>();
    if (isExit) {
      RequestDetailLogic requestDetailLogic = Get.find();
      cusFullName = requestDetailLogic.requestModel.customerModel.fullName;
    }
    bool isExitReviewOrderInfo =
        Get.isRegistered<ReviewOrderInformationLogic>();
    if (isExitReviewOrderInfo) {
      ReviewOrderInformationLogic reviewOrderInformationLogic = Get.find();
      paymentMethod = reviewOrderInformationLogic.isPayBankCode
          ? PaymentType.BANK_CODE
          : PaymentType.CASH;
    }
  }

  void signContract(String type, Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    try {
      _onLoading(context);
      Map<String, dynamic> body = {
        "paymentMethod": paymentMethod,
        "isVoiceContract": isVoiceContract,
        "voiceContractCallId": voiceContractCallId
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

  void _onLoadingDownload(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var height = MediaQuery.of(context).size.height;
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Column(
            children: [
              const Expanded(child: SizedBox()),
              LoadingCirculApi(),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Text(
                    "${progessValue.value.toInt()}%",
                    style: const TextStyle(color: Colors.yellow),
                  )),
              const Expanded(child: SizedBox()),
            ],
          ),
        );
      },
    );
  }

  downloadPDF(var onSuccess) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt < 30) {
      PermissionStatus statusStorage = await Permission.storage.request();
      // Kiểm tra xem quyền đã được cấp hay chưa
      if (statusStorage.isGranted) {
        // Quyền đã được cấp, bạn có thể thực hiện các hành động liên quan đến bộ nhớ ngoài ở đây
        print('Quyền truy cập bộ nhớ ngoài đã được cấp!');
      } else {
        // Quyền không được cấp, bạn có thể hiển thị thông báo hoặc xử lý trường hợp khi không có quyền truy cập
        print('Quyền truy cập bộ nhớ ngoài không được cấp!');
        onSuccess(false);
        return;
      }
    } else {
      PermissionStatus status =
          await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        // Quyền đã được cấp, bạn có thể thực hiện các hành động liên quan đến bộ nhớ ngoài ở đây
        print('Quyền truy cập bộ nhớ ngoài đã được cấp!');
      } else {
        // Quyền không được cấp, bạn có thể hiển thị thông báo hoặc xử lý trường hợp khi không có quyền truy cập
        print('Quyền truy cập bộ nhớ ngoài không được cấp!');
        onSuccess(false);
        return;
      }
    }

    String type = "";
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    if (checkMainContract.value) {
      type = PDFType.MAIN;
    } else {
      type = PDFType.LENDING;
    }
    _onLoadingDownload(context);
    progessValue.value = 0;
    try {
      ApiUtil.getInstance()!.downloadPDF(
        url: ApiEndPoints.API_CONTRACT_PREVIEW
            .replaceAll("id", contractId.toString()),
        params: {"type": type},
        onProgress: (value) {
          progessValue.value = value * 100;
        },
        onSuccess: (response) async {
          Get.back();
          bytesPDF = response.data;
          writeLogToFile(bytesPDF!, (isSuccess) {
            if (isSuccess) {
              onSuccess(true);
            }
          });
        },
        onError: (error) {
          onSuccess(false);
          Get.back();
        },
      );
    } catch (e) {
      Get.back();
      onSuccess(false);
      throw Exception('Error parsing asset file!');
    }
  }

  void writeLogToFile(Uint8List bytes, var onSuccess) async {
    String type = "";
    if (checkMainContract.value) {
      type = PDFType.MAIN;
    } else {
      type = PDFType.LENDING;
    }
    final directory = Platform.isAndroid
        ? Directory("/storage/emulated/0/Download") //FOR ANDROID
        : await getApplicationDocumentsDirectory(); //FOR iOS
    final file = File(
        '${directory.path}/${type == PDFType.MAIN ? AppLocalizations.of(context)!.textMainContract : AppLocalizations.of(context)!.textLendingContract}_$cusFullName.pdf');
    await file.writeAsBytes(bytes.toList());
    // ignore: use_build_context_synchronously
    onSuccess(true);
  }
}
