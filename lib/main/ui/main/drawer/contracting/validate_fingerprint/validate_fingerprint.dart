// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'dart:io';

import 'package:bitel_ventas/main/ui/main/drawer/contracting/validate_fingerprint/validate_fingerprint_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        init: ValidateFingerprintLogic(context),
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
                                            style: AppStyles.r9454C9_14_500
                                                .copyWith(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w700),
                                            children: [
                                              TextSpan(
                                                text: controller.idNumber,
                                                style: AppStyles.r2B3A4A_12_500
                                                    .copyWith(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              )
                                            ]),
                                      )
                                    ]),
                              ),
                            ),
                            SizedBox(
                              height: 43,
                            ),
                            Obx(
                              () => SizedBox(
                                width: 200,
                                height: 280,
                                child: controller.pathFinger.value != ''
                                    ? Image.asset(
                                        controller.pathFinger.value,
                                        fit: BoxFit.fitHeight,
                                      )
                                    : LoadingCirculApi(),
                              ),
                            ),
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
                                    height: 100,
                                  )
                                : SvgPicture.asset(
                                    AppImages.imgHuellaDactilar,
                                    width: 80,
                                    height: 100,
                                  ),
                            SizedBox(
                              height: 22,
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 30, right: 30),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    // if (controller.isGetFingerSuccess) {
                                    //   if (Platform.isAndroid) {
                                    //     controller.getCapture(context);
                                    //   } else {
                                    //     Common.showToastCenter(
                                    //         AppLocalizations.of(context)!
                                    //             .textOnlyActionAndroid);
                                    //   }
                                    // } else {
                                    //   Common.showToastCenter(
                                    //       "Chờ hiển thị ngón tay cần lấy");
                                    // }

                                    if (Platform.isAndroid) {
                                      controller.getCapture(context);
                                    } else {
                                      Common.showToastCenter(
                                          AppLocalizations.of(context)!
                                              .textOnlyActionAndroid);
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: controller.listFinger.isEmpty
                                          ? AppColors.colorButton
                                          : Colors.white,
                                      border:
                                          Border.all(color: Color(0xFFE3EAF2)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      AppLocalizations.of(context)!
                                          .textCapture
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: controller.listFinger.isEmpty
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    if (controller.listFinger.isEmpty) {
                                      return;
                                    }
                                    if (controller.type == 'LENDING') {
                                      controller.signContract(
                                        (p0) {
                                          if (p0) {
                                            Get.toNamed(
                                                RouteConfig.ftthContracting,
                                                arguments: [
                                                  controller.contractId,
                                                ]);
                                          } else {
                                            Common.showToastCenter(
                                                AppLocalizations.of(context)!
                                                    .textErrorAPI);
                                          }
                                        },
                                      );
                                    } else {
                                      controller.signContract(
                                        (p0) {
                                          if (p0) {
                                            Get.back(result: true);
                                          } else {
                                            Common.showToastCenter(
                                                AppLocalizations.of(context)!
                                                    .textErrorAPI);
                                          }
                                        },
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: controller.listFinger.isEmpty
                                          ? Colors.white
                                          : AppColors.colorButton,
                                      border:
                                          Border.all(color: Color(0xFFE3EAF2)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      AppLocalizations.of(context)!
                                          .textValidate
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: controller.listFinger.isEmpty
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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

  Uint8List convertBase64Image(String base64String) {
    return Base64Decoder().convert(base64String.split(',').last);
  }
}
