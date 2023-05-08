// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/client_data/id_card_scanner.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/res/app_fonts.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../router/route_config.dart';
import '../../../../../../../utils/common_widgets.dart';
import 'client_data_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef void TouchUpadte();

class ClientDataWidget extends GetView<ClientDataLogic> {
  final TouchUpadte callback;
  ClientDataWidget({required this.callback});
  // final result = Get.to(IDCardScanner());
  var path = ''.obs;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: ClientDataLogic(),
        builder: (controller) {
          return SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                        AppLocalizations.of(context)!.textInformacionDel,
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
                  SizedBox(
                    height: 16,
                  ),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(26),
                    dashPattern: [2, 2],
                    strokeWidth: 1,
                    color: Color(0xFF9454C9),
                    child: SizedBox(
                      width: 197,
                      height: 39,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text:
                                      '${controller.logicCreateContact.typeCustomer}: ',
                                  style: AppStyles.r9454C9_14_500.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                  children: [
                                    TextSpan(
                                      text: controller.idNumber,
                                      style: AppStyles.r2B3A4A_12_500.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ]),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 39,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: infoClientView(
                                lable:
                                    AppLocalizations.of(context)!.textLastName,
                                content: "Pham"),
                          ),
                          Expanded(
                            flex: 1,
                            child: infoClientView(
                                lable: AppLocalizations.of(context)!.textName,
                                content: "Quoc Nam"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: infoClientView(
                                lable: AppLocalizations.of(context)!
                                    .textNationality,
                                content: "VIETNAMITA"),
                          ),
                          Expanded(
                            flex: 1,
                            child: infoClientView(lable: 'Sex:', content: "M"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: infoClientView(
                                lable: AppLocalizations.of(context)!
                                    .textDateOfBirth,
                                content: "22 MAY 1996"),
                          ),
                          Expanded(
                            flex: 1,
                            child: infoClientView(
                                lable: AppLocalizations.of(context)!
                                    .textExpiredDate,
                                content: "22 MAR 2026"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                        onTap: () {},
                        child: Container(
                          height: 48,
                          margin: EdgeInsets.only(left: 15, right: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: RadialGradient(
                              center: const Alignment(-0.3292, 0.3296),
                              radius: 1.2106,
                              colors: [
                                const Color(0xFF0FDDDB),
                                const Color(0xFF00A5B1)
                              ],
                              stops: [0, 1],
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                  child: Text(
                                AppLocalizations.of(context)!
                                    .textPhotoOfIdentity,
                                style: AppStyles.r007689_14_500
                                    .copyWith(color: Colors.white),
                              )),
                              SvgPicture.asset(AppImages.icCameraRound),
                              SizedBox(
                                width: 8,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                        onTap: () {
                          if (controller.textPathScan.isEmpty) {
                            // controller.getScan();
                            // _getFromGallery(context, controller);
                          } else {
                            // callback();
                            // controller.detectID(context);
                          }
                          _getFromGallery(context, controller);
                        },
                        child: Stack(children: [
                          Center(
                              child:
                                  SvgPicture.asset(AppImages.icBorderIdentity)),
                          Positioned(
                            top: 5,
                            right: 0,
                            left: 0,
                            child: controller.textPathScan.isNotEmpty
                                ? Center(
                                    child: Image.file(
                                      File(controller.textPathScan),
                                      width: 290,
                                      height: 160,
                                    ),
                                  )
                                : Container(),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 42,
                      )
                    ],
                  )
                ]),
              ),
              Container(
                width: 310,
                margin:
                    EdgeInsets.only(top: 30, bottom: 36, left: 16, right: 16),
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.colorButton,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                  onTap: () {
                    // if(controller.textPathScan.isEmpty){
                    //   Common.showToastCenter("Bạn chưa chụp ảnh thẻ");
                    // } else {
                    //   callback();
                    // }
                    controller.createBodyCustomer();
                    callback();
                    // _onLoading(context);
                    // controller.createCustomer(
                    //   (isSuccess) {
                    //     if (isSuccess) {
                    //       Get.back();
                    //       showDialog(
                    //         context: context,
                    //         builder: (BuildContext context) {
                    //           return SuccessDialog(
                    //             height: 344,
                    //             isSuccess: true,
                    //             onCancel: () {
                    //               Get.back();
                    //             },
                    //             onOK: () {
                    //               Get.back();
                    //               callback();
                    //             },
                    //           );
                    //         },
                    //       );
                    //     } else {
                    //       Get.back();
                    //       Common.showToastCenter(
                    //           AppLocalizations.of(context)!.textErrorAPI);
                    //     }
                    //   },
                    // );
                  },
                  child: Center(
                      child: Text(
                    AppLocalizations.of(context)!.textRegistrar,
                    style: AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                  )),
                ),
              )
            ]),
          );
        });
  }

  Widget infoClientView({required String lable, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //   width: 17,
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            lable,
            style: TextStyle(
                fontFamily: AppFonts.Barlow,
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Color(0xFF6C8AA1)),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        // SizedBox(
        //   width: 17,
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(content,
              style: TextStyle(
                  fontFamily: AppFonts.Barlow,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0xFF2B3A4A))),
        ),
      ],
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

  _getFromGallery(BuildContext context, ClientDataLogic controller) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // ignore: use_build_context_synchronously
      _cropImage(pickedFile, context, controller);
    }
  }

  /// Crop Image
  _cropImage(filePath, BuildContext context, ClientDataLogic controller) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath!.path,
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
