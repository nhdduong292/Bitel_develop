// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';
import '../client_data/client_data_logic.dart';
import 'document_scanning_logic.dart';

typedef void TouchScan();

class DocumentScanningWidget extends GetView<DocumentScanningLogic> {
  final TouchScan callback;
  DocumentScanningWidget({required this.callback});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: DocumentScanningLogic(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFFE3EAF2),
                        width: 1.0,
                      ),
                      boxShadow: [
                        const BoxShadow(
                          color: Color.fromRGBO(185, 212, 220, 0.2),
                          offset: Offset(0, 2),
                          blurRadius: 7.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 30,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.textElegirDocumento,
                            style: AppStyles.r00A5B1_13_500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      DottedLine(
                        dashColor: Color(0xFFE3EAF2),
                        dashGapLength: 3,
                        dashLength: 4,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 30),
                        child: InkWell(
                          onTap: () {
                            controller.checkOption1.value =
                                !controller.checkOption1.value;
                          },
                          splashColor: Colors.black38,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => controller.checkOption1.value
                                    ? iconChecked()
                                    : iconUnchecked()),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: width * 0.75,
                                  child: RichText(
                                    text: TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .textAceptoYAutorizo,
                                      style: AppStyles.r6C8AA1_13_400,
                                      children: [
                                        TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .textTratamientoDe,
                                          style: AppStyles.rU00A5B1_13_500,
                                        ),
                                        TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .textConLa,
                                          style: AppStyles.r6C8AA1_13_400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 30),
                        child: InkWell(
                          onTap: () {
                            controller.checkOption2.value =
                                !controller.checkOption2.value;
                          },
                          splashColor: Colors.black38,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => controller.checkOption2.value
                                    ? iconChecked()
                                    : iconUnchecked()),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: width * 0.75,
                                  child: RichText(
                                    text: TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .textAceptoYAutorizoABitel,
                                      style: TextStyle(
                                        color: AppColors.colorContent,
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              AppLocalizations.of(context)!.textTratamientoDeMisDatos,
                                          style: TextStyle(
                                              color: AppColors.colorContent,
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: AppLocalizations.of(context)!.textTypeOfDocument,
                                style: TextStyle(
                                  color: AppColors.colorContent,
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: spinnerFormV2(
                            context: context,
                            hint: '',
                            required: true,
                            dropValue: controller.currentIdentity,
                            function: (value) {
                              controller.setIdentity(value);
                            },
                            listDrop: controller.listIdentityNumber),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      DottedLine(
                        dashColor: Color(0xFFE3EAF2),
                        dashGapLength: 3,
                        dashLength: 4,
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Text(
                        AppLocalizations.of(context)!.textNextScan,
                        style: AppStyles.r3,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      controller.textPathScan.isNotEmpty
                          ? Image.file(
                              File(controller.textPathScan),
                            )
                          : Image.asset(controller.getImageIdentity()),
                      SizedBox(
                        height: 23,
                      ),
                    ]),
                  ),
                  Obx(
                    () => SizedBox(
                      width: width,
                      child: bottomButton(
                          text: AppLocalizations.of(context)!.textScan,
                          onTap: () {
                            if (controller.checkOption1.value &&
                                controller.checkOption2.value) {
                              // callback();
                              if (controller.textPathScan.isNotEmpty) {
                                callback();
                              } else {
                                if (controller.textPathScan.isEmpty) {
                                  // controller.getScan();
                                  // _getFromGallery(context, controller);
                                } else {
                                  // callback();
                                  // controller.detectID(context);
                                }
                                _getFromGallery(context, controller);
                              }
                            } else {
                              Common.showToastCenter(
                                  AppLocalizations.of(context)!.textAcceptTheRules);
                            }
                          },
                          color: !(controller.checkOption1.value &&
                                  controller.checkOption2.value)
                              ? const Color(0xFF415263).withOpacity(0.2)
                              : null),
                    ),
                  ),
                ]),
          );
        });
  }

  _getFromGallery(
      BuildContext context, DocumentScanningLogic controller) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile, context, controller);
  }

  /// Crop Image
  _cropImage(
      filePath, BuildContext context, DocumentScanningLogic controller) async {
    if (filePath != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: filePath.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: AppLocalizations.of(context)!.textCropper,
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: AppLocalizations.of(context)!.textCropper,
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                 CroppieViewPort(width: 480, height: 480, type: AppLocalizations.of(context)!.textCircle),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        controller.setPathScan(croppedFile.path);
      }
    }
  }
}
