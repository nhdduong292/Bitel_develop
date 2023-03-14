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
import 'document_scanning_dni_logic.dart';

typedef void TouchScan();

class DocumentScanningDNIWidget extends GetView<DocumentScanningDNILogic> {
  final TouchScan callback;
  DocumentScanningDNIWidget({required this.callback});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: DocumentScanningDNILogic(),
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
                                              'ratamiento de mis datos personales y sensibles.',
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
                            function: (value) {
                              controller.setIdentity(value);
                            },
                            listDrop: controller.listIdentityNumber),
                      ),
                      SizedBox(
                        height: 39,
                      ),
                    ]),
                  ),
                  Obx(
                    () => SizedBox(
                      width: width,
                      child: bottomButton(
                          text: 'CONTINUE',
                          onTap: () {
                            callback();
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
}
