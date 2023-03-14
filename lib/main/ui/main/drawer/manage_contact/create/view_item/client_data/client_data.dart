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
                        'Información del cliente',
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
                                  text: 'DNI: ',
                                  style: AppStyles.r3,
                                  children: [
                                    TextSpan(
                                      text: '001573053',
                                      style: AppStyles.r1,
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
                                lable: 'Last name', content: "Pham"),
                          ),
                          Expanded(
                            flex: 1,
                            child: infoClientView(
                                lable: 'Name', content: "Quoc Nam"),
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
                                lable: 'Nationality', content: "VIETNAMITA"),
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
                                lable: 'Date of birth', content: "22 MAY 1996"),
                          ),
                          Expanded(
                            flex: 1,
                            child: infoClientView(
                                lable: 'Expired date', content: "22 MAR 2026"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
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
                                  child:
                                      Text('Photo of identity card (front)')),
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
                  onTap: () {
                    // if(controller.textPathScan.isEmpty){
                    //   Common.showToastCenter("Bạn chưa chụp ảnh thẻ");
                    // } else {
                    //   callback();
                    // }
                    _onLoading(context);
                    controller.createCustomer(
                      (isSuccess) {
                        if (isSuccess) {
                          Get.back();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessDialog(
                                height: 344,
                                isSuccess: true,
                                onCancel: () {
                                  Get.back();
                                },
                                onOK: () {
                                  Get.back();
                                  callback();
                                },
                              );
                            },
                          );
                        } else {
                          Get.back();
                          Common.showToastCenter(
                              AppLocalizations.of(context)!.textErrorAPI);
                        }
                      },
                    );
                  },
                  child: Center(
                      child: Text(
                    'Registrar',
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
                fontFamily: AppFonts.Roboto,
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
                  fontFamily: AppFonts.Roboto,
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
    _cropImage(pickedFile, context, controller);
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

class SuccessDialog extends Dialog {
  final double height;
  final bool isSuccess;
  var onOK;
  var onCancel;

  SuccessDialog(
      {super.key,
      required this.height,
      required this.isSuccess,
      required this.onCancel,
      required this.onOK});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: 330,
        height: height,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SvgPicture.asset(
                isSuccess ? AppImages.imgCongratulations : AppImages.imgNotify),
            SizedBox(
              height: 24,
            ),
            Text(
              '¡Felicidades!',
              style: isSuccess ? AppStyles.r14 : AppStyles.r16,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'El cliente se registró exitosamente',
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 28,
            ),
            const DottedLine(
              dashColor: Color(0xFFE3EAF2),
              dashGapLength: 3,
              dashLength: 4,
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                '¿Deseas registrar tu huella para lafirma digital?',
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: bottomButtonV2(text: 'No', onTap: onCancel)),
                Expanded(
                    child: bottomButton(text: 'Si, Continuar', onTap: onOK))
              ],
            ),
            // Container(
            //   width: double.infinity,
            //   margin: const EdgeInsets.only(top: 27, left: 38, right: 38),
            //   padding: const EdgeInsets.symmetric(vertical: 14),
            //   decoration: BoxDecoration(
            //     color: AppColors.colorButton,
            //     borderRadius: BorderRadius.circular(24),
            //   ),
            //   child: InkWell(
            //     onTap: () {
            //       onOK();
            //     },
            //     child: Center(
            //         child: Text(
            //       '¡Muchas Gracias!'.toUpperCase(),
            //       style: AppStyles.r5,
            //     )),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
