// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/router/route_config.dart';
import 'dart:async';
import 'dart:typed_data';

import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/customer_information_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../../../../../../res/app_colors.dart';
import 'contract_preview_logic.dart';

typedef void TouchRegister(String type);

class ContractPreviewWidget extends GetView<CustomerInformationLogic> {
  final TouchRegister callback;
  const ContractPreviewWidget({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              height: 52,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.textContractPreview,
                  style: AppStyles.r00A5B1_15d5_500,
                ),
              ),
            ),
            DottedLine(
              dashColor: Color(0xFFE3EAF2),
              dashGapLength: 3,
              dashLength: 4,
            ),
            SizedBox(
              height: 18,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteConfig.validateFingerprint);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: controller.checkMainContract.value
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF0b0b0b).withAlpha(40),
                              )
                            : null,
                        child: Text(
                          AppLocalizations.of(context)!.textMainContract,
                          style: AppStyles.rU9454C9_12_500,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteConfig.validateFingerprint);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: controller.checkLendingContract.value
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF0b0b0b).withAlpha(40),
                              )
                            : null,
                        child: Text(
                            AppLocalizations.of(context)!.textLendingContract,
                            style: AppStyles.rU9454C9_12_500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 18,
            ),
            InkWell(
              child: Image.asset(
                AppImages.imgDemoContract,
                width: 320,
                height: 372,
              ),
            ),
            customRadioMutiple(
                width: width,
                text: AppLocalizations.of(context)!.textIConfirmThat,
                check: controller.checkOption,
                changeValue: (value) {
                  controller.checkOption.value = value;
                }),
            SizedBox(
              height: 24,
            )
          ]),
        ),
        Container(
          width: width - 62,
          margin: EdgeInsets.only(left: 31, right: 31),
          child: Obx(
            () => bottomButton(
                text: AppLocalizations.of(context)!
                    .textSignContract
                    .toUpperCase(),
                onTap: () {
                  if (controller.checkOption.value) {
                    if (controller.checkMainContract.value) {
                      callback('MAIN');
                    } else {
                      callback('LENDING');
                    }
                  }
                },
                color: !(controller.checkOption.value)
                    ? const Color(0xFF415263).withOpacity(0.2)
                    : null),
          ),
        )
      ]),
    );
  }
}