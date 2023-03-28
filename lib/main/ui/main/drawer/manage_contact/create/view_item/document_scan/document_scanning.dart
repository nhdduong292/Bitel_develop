// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';
import 'document_scanning_logic.dart';

typedef void TouchScan(bool isDNI);

class DocumentScanningWidget extends GetView<DocumentScanningLogic> {
  final TouchScan callback;
  DocumentScanningWidget({required this.callback(value)});
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
                                      style: AppStyles.r6C8AA1_13_400,
                                      children: [
                                        TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .textTratamientoDeMisDatos,
                                          style: AppStyles.rU00A5B1_13_500,
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
                                text: AppLocalizations.of(context)!
                                    .textTypeOfDocument,
                                style: TextStyle(
                                  color: AppColors.colorContent,
                                  fontFamily: 'Barlow',
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'Barlow',
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
                              controller.logicCreateContact
                                  .changeTypeCustomer(value);
                            },
                            listDrop: controller.listIdentityNumber),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Visibility(
                        visible: !controller.isDNI(),
                        child: Column(
                          children: [
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
                            InkWell(
                              onTap: () {
                                // controller.reset();
                                uploadImage(context, controller);
                              },
                              child: controller.textPathScan.isNotEmpty
                                  ? Image.file(
                                      File(controller.textPathScan),
                                    )
                                  : Image.asset(controller.getImageIdentity()),
                            ),
                            SizedBox(
                              height: 23,
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Obx(
                    () => SizedBox(
                      width: width,
                      child: bottomButton(
                          text: controller.isDNI()
                              ? AppLocalizations.of(context)!.textContinue
                              : AppLocalizations.of(context)!.textScan,
                          onTap: () {
                            if (controller.checkOption1.value &&
                                controller.checkOption2.value) {
                              if (controller.textPathScan.isNotEmpty) {
                                controller.reset();
                                callback(false);
                              } else {
                                if (controller.textPathScan.isEmpty) {
                                  // controller.getScan();
                                  // _getFromGallery(context, controller);
                                } else {
                                  // callback();
                                  // controller.detectID(context);
                                }

                                // uploadImage(context, controller);
                                // _getFromGallery(context, controller);
                              }
                              if (controller.isDNI()) {
                                controller.reset();
                                callback(true);
                              } else {
                                if (controller.textPathScan.isNotEmpty) {
                                  controller.reset();
                                  controller
                                      .processImage(InputImage.fromFilePath(
                                          File(controller.textPathScan).path))
                                      .then((value) => {callback(false)});
                                } else {
                                  if (controller.textPathScan.isEmpty) {
                                    // controller.getScan();
                                    // _getFromGallery(context, controller);
                                  } else {
                                    // callback();
                                    // controller.detectID(context);
                                  }

                                  uploadImage(context, controller);
                                  // _getFromGallery(context, controller);
                                }
                              }
                            } else {
                              Common.showToastCenter(
                                  AppLocalizations.of(context)!
                                      .textAcceptTheRules);
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

  uploadImage(BuildContext context, DocumentScanningLogic controller) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // ignore: use_build_context_synchronously
      _cropImage(pickedFile, context, controller);
    }
  }

  _getFromGallery(
      BuildContext context, DocumentScanningLogic controller) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    // ignore: use_build_context_synchronously
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
        controller.setPathScan(croppedFile.path);
      }
    }
  }
}
