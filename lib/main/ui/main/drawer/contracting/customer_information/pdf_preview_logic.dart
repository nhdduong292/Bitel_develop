import 'dart:async';
import 'dart:io';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/customer_information_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/change_plan/information/infor_change_plan_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/date_cancel_service/date_cancel_service_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import '../../../../../services/connection_service.dart';
import '../../../../../utils/common_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PDFPreviewLogic extends GetxController {
  BuildContext context;
  var path = '';
  Uint8List? bytesPDF;
  var loadSuccess = false.obs;
  var type = '';
  int contractId = 0;
  int subId = 0;
  String cancelDate = '';
  String note = '';
  String newPlan = '';
  int requestId = 0;
  RxDouble progessValue = 0.0.obs;
  String cusFullName = "";

  PDFPreviewLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    var data = Get.arguments;
    type = data[0];
    if (type == PDFType.TRANSFER_SERVICE) {
      requestId = data[1];
      getPDFTransfer();
      return;
    } else if (type == PDFType.MAIN || type == PDFType.LENDING) {
      contractId = data[1];
      bool isExitRequestDetailLogic = Get.isRegistered<RequestDetailLogic>();
      if (isExitRequestDetailLogic) {
        RequestDetailLogic requestDetailLogic = Get.find();
        cusFullName = requestDetailLogic.requestModel.customerModel.fullName;
      }
      bool isExitCustomerInformationLogic =
          Get.isRegistered<CustomerInformationLogic>();
      if (isExitCustomerInformationLogic) {
        CustomerInformationLogic customerInformationLogic = Get.find();
        cusFullName = customerInformationLogic.customer.fullName;
      }
      bool isExit = Get.isRegistered<InforChangePlanLogic>();
      if (isExit) {
        InforChangePlanLogic inforChangePlanLogic = Get.find();
        subId = inforChangePlanLogic.subId;
        newPlan = inforChangePlanLogic.newPlan.productCode ?? "";
        getPDFChangePlan();
      } else {
        getPDF();
      }
    } else if (type == PDFType.CANCEL_SERVICE) {
      bool isExit = Get.isRegistered<DateCancelServiceLogic>();
      if (isExit) {
        DateCancelServiceLogic dateCancelServiceLogic = Get.find();
        cancelDate = dateCancelServiceLogic.datePicker!
            .toIso8601String()
            .substring(0, 10);
        note = dateCancelServiceLogic.reasonCancel.trim();
      }
      subId = data[1];
      getPDFBySubId();
    }
  }

  Future<Uint8List> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<Uint8List> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(bytes);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  getPDF() async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      loadSuccess.value = true;
      return;
    }
    try {
      ApiUtil.getInstance()!.getPDF(
        url: ApiEndPoints.API_CONTRACT_PREVIEW
            .replaceAll("id", contractId.toString()),
        params: {"type": type},
        onSuccess: (response) async {
          bytesPDF = response.data;
          loadSuccess.value = true;
        },
        onError: (error) {
          loadSuccess.value = true;
        },
      );
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }

  downloadPDF() async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
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
          writeLogToFile(bytesPDF!);
        },
        onError: (error) {
          Get.back();
        },
      );
    } catch (e) {
      Get.back();
      throw Exception('Error parsing asset file!');
    }
  }

  getPDFBySubId() async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      loadSuccess.value = true;
      return;
    }
    try {
      ApiUtil.getInstance()!.postPDF(
        url: ApiEndPoints.API_CONTRACT_PREVIEW_ORDER_ID
            .replaceAll("subId", subId.toString()),
        params: {"subId": subId.toString()},
        body: {"cancelDate": cancelDate, "note": note},
        onSuccess: (response) async {
          bytesPDF = response.data;
          loadSuccess.value = true;
        },
        onError: (error) {
          loadSuccess.value = true;
        },
      );
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }

  getPDFChangePlan() async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      loadSuccess.value = true;
      return;
    }
    try {
      ApiUtil.getInstance()!.getPDF(
        url: ApiEndPoints.API_CHANGE_PLAN_PREVIEW,
        params: {"subId": subId.toString(), "newPlan": newPlan, "type": type},
        onSuccess: (response) async {
          bytesPDF = response.data;
          loadSuccess.value = true;
        },
        onError: (error) {
          loadSuccess.value = true;
        },
      );
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }

  getPDFTransfer() async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      loadSuccess.value = true;
      return;
    }
    try {
      ApiUtil.getInstance()!.postPDF(
        url: ApiEndPoints.API_TRANSFER_SERVICE_PDF
            .replaceAll("requestId", requestId.toString()),
        params: {"requestId": requestId.toString()},
        onSuccess: (response) async {
          bytesPDF = response.data;
          loadSuccess.value = true;
        },
        onError: (error) {
          loadSuccess.value = true;
        },
      );
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }

  String titlePDF() {
    if (type == PDFType.MAIN) {
      return AppLocalizations.of(context)!.textMainContract;
    } else if (type == PDFType.LENDING) {
      return AppLocalizations.of(context)!.textLendingContract;
    } else if (type == PDFType.TRANSFER_SERVICE) {
      return AppLocalizations.of(context)!.textTransferService;
    } else if (type == PDFType.CANCEL_SERVICE) {
      return AppLocalizations.of(context)!.textCancelService;
    }
    return AppLocalizations.of(context)!.textMainContract;
  }

  String titleFormPDF() {
    if (type == PDFType.MAIN || type == PDFType.LENDING) {
      return AppLocalizations.of(context)!.textContractPreview;
    } else if (type == PDFType.TRANSFER_SERVICE) {
      return AppLocalizations.of(context)!.textTransferServiceRequestForm;
    } else if (type == PDFType.CANCEL_SERVICE) {
      return AppLocalizations.of(context)!.textCancellationRequestForm;
    }
    return '---';
  }

  void writeLogToFile(Uint8List bytes) async {
    final directory = Platform.isAndroid
        ? Directory("/storage/emulated/0/Download") //FOR ANDROID
        : await getApplicationDocumentsDirectory(); //FOR iOS
    final file = File(
        '${directory.path}/${type == PDFType.MAIN ? AppLocalizations.of(context)!.textMainContract : AppLocalizations.of(context)!.textLendingContract}_$cusFullName.pdf');
    await file.writeAsBytes(bytes.toList());
    // ignore: use_build_context_synchronously
    Common.showToastCenter(
        AppLocalizations.of(context)!.textDownloadContractSuccessfully,
        context);
  }

  void _onLoading(BuildContext context) {
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
}
