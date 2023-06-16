import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/networks/response/google_detect_item.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/cretate_contact_page_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/scan_model/customer_scan_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/scan_model/item_infor.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/native_util.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import '../../../../../../../networks/model/ce.dart';
import '../../../../../../../networks/model/pp.dart';
import '../../../../../../../services/connection_service.dart';
import '../client_data/customer_detect_mode.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/widgets.dart' as pw;

class DocumentScanningLogic extends GetxController {
  late BuildContext context;
  var checkOption1 = true.obs;
  var checkOption2 = true.obs;

  String textPathScan = "";
  // bool _canProcess = true;
  // bool _isBusy = false;
  CustomPaint? _customPaint;
  CustomerDetectModel customerDetectModel = CustomerDetectModel();
  CustomerModel customerModel = CustomerModel();
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  String currentIdentity = "DNI";
  // List<String> listIdentityNumber = ["DNI", "CE", "PP", "PTP"];
  CustomerScanModel customerScanModel = CustomerScanModel();

  String pathImageBack = '';

  bool onProcessImage = false;

  CreateContactPageLogic logicCreateContact = Get.find();

  List<GoogleDetectItem> listGoogleDetect = [];

  final pdf = pw.Document();
  File? pdfIdentify;

  CE ce = CE();
  PP pp = PP();

  DocumentScanningLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onListenerMethod();
    currentIdentity = logicCreateContact.typeCustomer;
  }

  void setIdentity(String value) {
    currentIdentity = value;
    update();
  }

  // bool isDNI() {
  //   if (currentIdentity == 'DNI') {
  //     return true;
  //   }
  //   return false;
  // }

  String getImageIdentity() {
    if (currentIdentity == 'CE') {
      return AppImages.imgIdentityCEFont;
    } else if (currentIdentity == 'PP') {
      return AppImages.imgPP;
    }
    return AppImages.imgIdentityCEFont;
  }

  void onListenerMethod() {
    NativeUtil.platformScan2.setMethodCallHandler((call) async {
      if (call.method == NativeUtil.nameScan2) {
        String link = call.arguments;
        textPathScan = link;
        update();
      }
    });
  }

  Future<void> getScan() async {
    String result = "";
    try {
      final String value =
          await NativeUtil.platformScan2.invokeMethod(NativeUtil.nameScan2);
      result = value;
    } on PlatformException catch (e) {
      e.printInfo();
    }
    print(result);
  }

  void setPathScan(String value, bool isScanningFont) {
    if (isScanningFont) {
      textPathScan = value;
    }
    update();
  }

  void detectID(BuildContext context) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    Map<String, dynamic> body = {
      "requests": [
        {
          "image": Common.convertImageFileToBase64(File(textPathScan)),
          "features": [
            {"type": "TEXT_DETECTION"}
          ]
        }
      ],
    };

    Map<String, dynamic> params = {"key": Values.KEY_GOOGLE_DETECT};
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_DETECT_ID,
      body: body,
      params: params,
      isDetect: true,
      onSuccess: (response) {
        Get.back();
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void reset() {
    ce = CE();
    pp = PP();
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

  void setListImageScan() {
    logicCreateContact.listImageScan.clear();
    if (logicCreateContact.typeCustomer == 'CE') {
      logicCreateContact.listImageScan.add(pathImageBack);
    } else {
      logicCreateContact.listImageScan.add(pathImageBack);
    }
  }

  void uploadFile(String path, String name,
      Function(bool isSuccess, String path) function) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_UPLOAD_IDENTITY_NEW,
        body: {
          "idType": currentIdentity,
          "idNumber": logicCreateContact.requestModel.customerModel.idNumber,
          "fileContent": Common.convertImageFileToBase64(pdfIdentify!),
        },
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            function.call(true, response.data['data']);
          } else {
            function.call(false, '');
          }
        },
        onError: (error) {
          Get.back();
          function.call(false, '');
          Common.showMessageError(error: error, context: context);
        });
  }

  uploadImage(BuildContext context, DocumentScanningLogic controller,
      bool isScanningFont) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // ignore: use_build_context_synchronously
        _cropImage(pickedFile, context, controller, isScanningFont);
      }
    } on Exception catch (e) {
      // TODO
      print(e.toString());
      Common.showToastCenter(e.toString(), context);
    }
  }

  getFromGallery(BuildContext context, DocumentScanningLogic controller,
      bool isScanningFont) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    // ignore: use_build_context_synchronously
    _cropImage(pickedFile, context, controller, isScanningFont);
  }

  /// Crop Image
  _cropImage(filePath, BuildContext context, DocumentScanningLogic controller,
      bool isScanningFont) async {
    if (filePath != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: filePath.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        controller.setPathScan(croppedFile.path, isScanningFont);
      }
    }
  }

  void onClickContinue({var onContiue, var onScan}) {
    if (checkOption1.value && checkOption2.value) {
      if (textPathScan.isNotEmpty) {
        reset();
        detectImage((value) {
          if (value) {
            if (currentIdentity == 'CE') {
              ce.getDocumentItems(listGoogleDetect[0].fullTextAnnotation!.text);
            } else {
              pp.getDocumentItems(listGoogleDetect[0].fullTextAnnotation!.text);
            }
            if (ce.checkIdentify() || pp.checkIdentify()) {
              createPDF();
              savePDF((isSuccessPDF) {
                if (isSuccessPDF) {
                  uploadFile(textPathScan, 'image_back', (isSuccess, path) {
                    if (isSuccess) {
                      pathImageBack = path;
                      onContiue();
                    }
                  });
                }
              });
            } else {
              Common.showSystemErrorDialog(context,
                  AppLocalizations.of(context)!.textCardIdentityNotValidate);
              // Common.showToastCenter(
              //     AppLocalizations.of(context)!.textCardIdentityNotValidate);
            }
          }
        });
      } else {
        onScan();
      }
    } else {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textAcceptTheRules, context);
    }
  }

  void detectImage(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    Map<String, dynamic> body = {
      "requests": [
        {
          "image": {
            "content": Common.convertImageFileToBase64(File(textPathScan))
          },
          "features": [
            {"type": "TEXT_DETECTION"}
          ]
        }
      ]
    };
    _onLoading(context);
    ApiUtil.getInstance()!.postDetectImage(
      url: ApiEndPoints.API_DETECT_ID,
      params: {"key": "AIzaSyAlf4Kr2ag8ZLpj04fuYrfv5eGWzNmhLX8"},
      body: body,
      onSuccess: (response) {
        Get.back();
        listGoogleDetect = (response.data['responses'] as List)
            .map((postJson) => GoogleDetectItem.fromJson(postJson))
            .toList();
        onSuccess(true);
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

  createPDF() async {
    final image = pw.MemoryImage(File(textPathScan).readAsBytesSync());
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context contex) {
          return pw.Center(child: pw.Image(image));
        }));
  }

  savePDF(var onSuccess) async {
    try {
      final dir = Platform.isAndroid
          ? await getExternalStorageDirectory() //FOR ANDROID
          : await getApplicationSupportDirectory(); //FOR iOS
      final file = File('${dir?.path}/identify_back.pdf');
      await file.writeAsBytes(await pdf.save());
      pdfIdentify = file;
      onSuccess(true);
    } catch (e) {
      onSuccess(true);
      print(e.toString());
    }
  }
}
