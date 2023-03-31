// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../../res/app_images.dart';
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
        init: DocumentScanningLogic(context: context),
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
                        child: Container(
                            height: 45,
                            width: width,
                            padding: EdgeInsets.only(left: 18, right: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                    color: Color(0xFFE3EAF2), width: 1)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      controller.currentIdentity,
                                      style: AppStyles.r2B3A4A_12_500.copyWith(
                                          fontSize: 14,
                                          color: AppColors.color_2B3A4A
                                              .withOpacity(0.85)),
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(AppImages.icArrowDownLockedBox)
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Column(
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
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return TakeImageDialog(
                                      onCamera: () {
                                        Get.back();
                                        controller.getFromGallery(
                                            context, controller, true);
                                      },
                                      onGellary: () {
                                        Get.back();
                                        controller.uploadImage(
                                            context, controller, true);
                                      },
                                    );
                                  });
                            },
                            child: controller.textPathScan.isNotEmpty
                                ? Image.file(
                                    File(controller.textPathScan),
                                  )
                                : Image.asset(controller.getImageIdentity()),
                          ),
                          Visibility(
                            visible:
                                controller.logicCreateContact.typeCustomer ==
                                    'CE',
                            child: Column(
                              children: [
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
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return TakeImageDialog(
                                            onCamera: () {
                                              Get.back();
                                              controller.getFromGallery(
                                                  context, controller, false);
                                            },
                                            onGellary: () {
                                              Get.back();
                                              controller.uploadImage(
                                                  context, controller, false);
                                            },
                                          );
                                        });
                                  },
                                  child: controller.textPathScanBack.isNotEmpty
                                      ? Image.file(
                                          File(controller.textPathScanBack),
                                        )
                                      : Image.asset(
                                          controller.getImageIdentity()),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 23,
                          )
                        ],
                      )
                    ]),
                  ),
                  Obx(
                    () => SizedBox(
                      width: width,
                      child: bottomButton(
                          text: ((controller.textPathScan.isNotEmpty &&
                                      controller.textPathScanBack.isNotEmpty &&
                                      controller.currentIdentity == 'CE') ||
                                  (controller.textPathScan.isNotEmpty &&
                                      controller.currentIdentity != 'CE'))
                              ? AppLocalizations.of(context)!.textContinue
                              : AppLocalizations.of(context)!.textScan,
                          onTap: () {
                            if (controller.checkOption1.value &&
                                controller.checkOption2.value) {
                              if ((controller.textPathScan.isNotEmpty &&
                                      controller.textPathScanBack.isNotEmpty &&
                                      controller.currentIdentity == 'CE') ||
                                  (controller.textPathScan.isNotEmpty &&
                                      controller.currentIdentity != 'CE')) {
                                _onLoading(context);

                                if (controller.currentIdentity == 'CE') {
                                  controller.uploadFile(
                                      controller.textPathScan, 'image_font',
                                      (isSuccess, path) {
                                    if (isSuccess) {
                                      controller.pathImageFont = path;
                                      controller.uploadFile(
                                          controller.textPathScanBack,
                                          'image_back', (isSuccess, path) {
                                        if (isSuccess) {
                                          Get.back();
                                          controller.pathImageBack = path;
                                          controller.reset();
                                          controller
                                              .logicCreateContact.listImageScan
                                              .add(controller.pathImageFont);
                                          controller
                                              .logicCreateContact.listImageScan
                                              .add(controller.pathImageBack);
                                          controller
                                              .processImage(
                                                  InputImage.fromFilePath(File(
                                                          controller
                                                              .textPathScan)
                                                      .path))
                                              .then(
                                                  (value) => {callback(false)});
                                        } else {
                                          Get.back();
                                        }
                                      });
                                    } else {
                                      Get.back();
                                    }
                                  });
                                } else {
                                  controller.uploadFile(
                                      controller.textPathScan, 'image_font',
                                      (isSuccess, path) {
                                    if (isSuccess) {
                                      Get.back();
                                      controller.pathImageFont = path;
                                      controller.reset();
                                      controller
                                          .processImage(InputImage.fromFilePath(
                                              File(controller.textPathScan)
                                                  .path))
                                          .then((value) => {callback(false)});
                                    } else {
                                      Get.back();
                                    }
                                  });
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return TakeImageDialog(
                                        onCamera: () {
                                          Get.back();
                                          controller.getFromGallery(
                                              context,
                                              controller,
                                              controller.textPathScan.isEmpty);
                                        },
                                        onGellary: () {
                                          Get.back();
                                          controller.uploadImage(
                                              context,
                                              controller,
                                              controller.textPathScan.isEmpty);
                                        },
                                      );
                                    });
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
}

class TakeImageDialog extends Dialog {
  Function onCamera;
  Function onGellary;
  TakeImageDialog({required this.onCamera, required this.onGellary});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Wrap(children: [
        Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            // SvgPicture.asset(AppImages.imgNotify),
            // const SizedBox(
            //   height: 15,
            // ),
            Text(
              AppLocalizations.of(context)!.textTakePicturesFrom,
              style: AppStyles.r16,
            ),
            const SizedBox(
              height: 8,
            ),
            const DottedLine(
              dashColor: AppColors.colorLineDash,
              dashGapLength: 3,
              dashLength: 4,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textCamera,
                        onTap: () {
                          onCamera();
                        })),
                Expanded(
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textGallery,
                        onTap: () {
                          onGellary();
                        }))
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ]),
    );
  }
}
