// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'dart:io';

import 'package:bitel_ventas/main/ui/main/drawer/contracting/validate_fingerprint/validate_fingerprint_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';
import '../../../../../router/route_config.dart';

class ValidateFingerprintPage extends GetView<ValidateFingerprintLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: ValidateFingerprintLogic(),
        builder: (controller) {
          return Scaffold(
            body: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8FBFB),
                      ),
                      width: width,
                      height: 147,
                    ),
                    SvgPicture.asset(
                      AppImages.bgAppbar,
                      width: width,
                    ),
                    Positioned(
                      top: 50,
                      left: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .textRequestToContracting,
                              style: AppStyles.title),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 45,
                        left: 20,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13)),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 15,
                                color: AppColors.colorTitle,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
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
                              height: 52,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .textValidateFingerprint,
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
                            DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(26),
                              dashPattern: [2, 2],
                              strokeWidth: 1,
                              color: Color(0xFF9454C9),
                              child: SizedBox(
                                width: 234,
                                height: 41,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text:
                                                '${controller.typeCustomer}: ',
                                            style: AppStyles.r3,
                                            children: [
                                              TextSpan(
                                                text: controller.idNumber,
                                                style: AppStyles.r1,
                                              )
                                            ]),
                                      )
                                    ]),
                              ),
                            ),
                            SizedBox(
                              height: 43,
                            ),
                            SvgPicture.asset(AppImages.imgValidateFingerprint),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 24),
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .textEnterThe,
                                      style: AppStyles.r405264_14_500,
                                      children: [
                                        TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .textCustomerFingerprint,
                                          style: AppStyles.r9454C9_14_500,
                                        ),
                                        TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .textToVerifyIdentify,
                                          style: AppStyles.r405264_14_500,
                                        )
                                      ])),
                            ),
                            SizedBox(
                              height: 41,
                            ),
                            controller.textCapture.isNotEmpty
                                ? Image.file(
                                    File(controller.textCapture),
                                    width: 80,
                                    height: 160,
                                  )
                                : SvgPicture.asset(AppImages.imgHuellaDactilar),
                            SizedBox(
                              height: 22,
                            ),
                          ]),
                        ),
                        SizedBox(
                            width: width,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: bottomButtonV2(
                                        onTap: () {
                                          if(Platform.isAndroid) {
                                            controller.getCapture();
                                          } else {
                                            Common.showToastCenter("Chỉ hoạt động trên thiết bị Android");
                                          }
                                        },
                                        text: AppLocalizations.of(context)!
                                            .textCapture
                                            .toUpperCase())),
                                Expanded(
                                    flex: 1,
                                    child: bottomButton(
                                        onTap: () {
                                          if (controller.type == 'LENDING') {
                                            controller.signContract((p0) {
                                              if(p0){
                                                Get.toNamed(
                                                    RouteConfig.ftthContracting);
                                              } else {
                                                Common.showToastCenter(AppLocalizations.of(context)!.textErrorAPI);
                                              }
                                            },);
                                          } else {
                                            controller.signContract((p0) {
                                              if(p0){
                                                Get.back(result: true);
                                              } else {
                                                Common.showToastCenter(AppLocalizations.of(context)!.textErrorAPI);
                                              }
                                            },);

                                          }
                                        },
                                        text: AppLocalizations.of(context)!
                                            .textValidate)),
                              ],
                            )),
                        SizedBox(
                          height: 126,
                        )
                      ]),
                )),
              ],
            ),
          );
        });
  }
}
