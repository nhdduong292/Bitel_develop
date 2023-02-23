// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../utils/common_widgets.dart';
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
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 30),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                controller.checkOption1.value =
                                    !controller.checkOption1.value;
                              },
                              splashColor: Colors.black38,
                              child: Obx(() => controller.checkOption1.value
                                  ? iconChecked()
                                  : iconUnchecked())),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: width * 0.75,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'Acepto y autorizo de forma expresa e inequivoca el ',
                                style: TextStyle(
                                  color: AppColors.colorContent,
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'ratamiento de mis datos sensibles',
                                    style: TextStyle(
                                        color: AppColors.colorContent,
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: 'con la recopilación de los mismos.',
                                    style: TextStyle(
                                      color: AppColors.colorContent,
                                      fontFamily: 'Roboto',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 30),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                controller.checkOption2.value =
                                    !controller.checkOption2.value;
                              },
                              splashColor: Colors.black38,
                              child: Obx(() => controller.checkOption2.value
                                  ? iconChecked()
                                  : iconUnchecked())),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: width * 0.75,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'Acepto y autorizo a BITEL para que realice el ',
                                style: TextStyle(
                                  color: AppColors.colorContent,
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'ratamiento de mis datos personales y sensibles.',
                                    style: TextStyle(
                                        color: AppColors.colorContent,
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
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
                            text: 'Type of document ',
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
                    'Next, scan its vover',
                    style: AppStyles.r3,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SvgPicture.asset(AppImages.imgIdentity),
                  SizedBox(
                    height: 23,
                  ),
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
                    callback();
                  },
                  child: Center(
                      child: Text(
                    'SCAN',
                    style: AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                  )),
                ),
              )
            ]),
          );
        });
  }
}
