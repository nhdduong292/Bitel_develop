// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:bitel_ventas/main/ui/main/drawer/contracting/register_finger_print/register_finger_print_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../../../res/app_colors.dart';
import '../../../../../router/route_config.dart';

typedef void TouchScan();

class RegisterFingerPrintPage extends GetView<RegisterFingerPrintLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final TouchScan callback;
    return GetBuilder(
        init: RegisterFingerPrintLogic(context: context),
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
                    height: 52,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 51, right: 82),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            selectedFingerView(
                                text: AppLocalizations.of(context)!.textLeft,
                                value: 1,
                                groupValue: controller.handValue,
                                onChange: (value) {
                                  if (controller.listImageLeft.isEmpty &&
                                      controller.listImageRight.isEmpty) {
                                    controller.handValue.value = value;
                                  }
                                }),
                            selectedFingerView(
                                text: AppLocalizations.of(context)!.textRight,
                                value: 2,
                                groupValue: controller.handValue,
                                onChange: (value) {
                                  if (controller.listImageLeft.isEmpty &&
                                      controller.listImageRight.isEmpty) {
                                    controller.handValue.value = value;
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  DottedLine(
                    dashColor: Color(0xFFE3EAF2),
                    dashGapLength: 3,
                    dashLength: 4,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(AppLocalizations.of(context)!.textYourBestFingerprint,
                      style: AppStyles.r00A5B1_13_500
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 72,
                      right: 82,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 92,
                          height: 140,
                          child: Obx(
                            () => Image.asset(
                              controller.pathFinger.value,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            selectedFingerView(
                                text: AppLocalizations.of(context)!.textThumb,
                                value: 1,
                                groupValue: controller.fingerValue,
                                onChange: (value) {
                                  if (controller.listImageLeft.isEmpty &&
                                      controller.listImageRight.isEmpty) {
                                    controller.fingerValue.value = value;
                                  }
                                }),
                            SizedBox(
                              height: 12,
                            ),
                            selectedFingerView(
                                text: AppLocalizations.of(context)!.textIndex,
                                value: 2,
                                groupValue: controller.fingerValue,
                                onChange: (value) {
                                  if (controller.listImageLeft.isEmpty &&
                                      controller.listImageRight.isEmpty) {
                                    controller.fingerValue.value = value;
                                  }
                                }),
                            SizedBox(
                              height: 12,
                            ),
                            selectedFingerView(
                                text: AppLocalizations.of(context)!.textMiddle,
                                value: 3,
                                groupValue: controller.fingerValue,
                                onChange: (value) {
                                  if (controller.listImageLeft.isEmpty &&
                                      controller.listImageRight.isEmpty) {
                                    controller.fingerValue.value = value;
                                  }
                                }),
                            SizedBox(
                              height: 12,
                            ),
                            selectedFingerView(
                                text: AppLocalizations.of(context)!.textRing,
                                value: 4,
                                groupValue: controller.fingerValue,
                                onChange: (value) {
                                  if (controller.listImageLeft.isEmpty &&
                                      controller.listImageRight.isEmpty) {
                                    controller.fingerValue.value = value;
                                  }
                                }),
                            SizedBox(
                              height: 12,
                            ),
                            selectedFingerView(
                                text: AppLocalizations.of(context)!.textLittle,
                                value: 5,
                                groupValue: controller.fingerValue,
                                onChange: (value) {
                                  if (controller.listImageLeft.isEmpty &&
                                      controller.listImageRight.isEmpty) {
                                    controller.fingerValue.value = value;
                                  }
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  DottedLine(
                    dashColor: Color(0xFFE3EAF2),
                    dashGapLength: 3,
                    dashLength: 4,
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  Obx(
                    () => RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: AppLocalizations.of(context)!
                                .textRegisterFingerprintWith,
                            style: AppStyles.r405264_14_500.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w400),
                            children: [
                              TextSpan(
                                text:
                                    '${controller.countFinger.value} ${AppLocalizations.of(context)!.textTimes}',
                                style: AppStyles.r9454C9_14_500
                                    .copyWith(fontSize: 13),
                              ),
                            ])),
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(26),
                    dashPattern: [2, 2],
                    strokeWidth: 1,
                    color: Color(0xFF9454C9),
                    child: SizedBox(
                      width: 266,
                      height: 44,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.textClickHereTo,
                          style:
                              AppStyles.r9454C9_14_500.copyWith(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 57, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .textDigitalFingerprint,
                                  style: AppStyles.r405264_14_500.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                )),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              width: 150,
                              height: 165,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFE3EAF2), width: 1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Visibility(
                                visible:
                                    (controller.listImageLeft.length >= 1 ||
                                        controller.listImageRight.length >= 1),
                                child: fingerPrintView(
                                    link: controller.listPathFinger.isNotEmpty
                                        ? controller.listPathFinger[0]
                                        : '',
                                    value: 0,
                                    onDelete: (value) {
                                      if (controller.indexLeft != 0) {
                                        controller.listImageLeft
                                            .removeAt(value);
                                      } else {
                                        controller.listImageRight
                                            .removeAt(value);
                                      }
                                      controller.listPathFinger.removeAt(value);
                                      controller.countFinger.value++;
                                      controller.update();
                                    })),
                            Visibility(
                                visible:
                                    (controller.listImageLeft.length >= 2 ||
                                        controller.listImageRight.length >= 2),
                                child: fingerPrintView(
                                    link: controller.listPathFinger.length == 2
                                        ? controller.listPathFinger[1]
                                        : '',
                                    value: 1,
                                    onDelete: (value) {
                                      if (controller.indexLeft != 0) {
                                        controller.listImageLeft
                                            .removeAt(value);
                                      } else {
                                        controller.listImageRight
                                            .removeAt(value);
                                      }
                                      controller.listPathFinger.removeAt(value);
                                      controller.countFinger.value++;
                                      controller.update();
                                    })),
                            Visibility(
                                visible:
                                    (controller.listImageLeft.length >= 3 ||
                                        controller.listImageRight.length >= 3),
                                child: fingerPrintView(
                                    link: controller.listPathFinger.length == 3
                                        ? controller.listPathFinger[2]
                                        : '',
                                    value: 2,
                                    onDelete: (value) {
                                      if (controller.indexLeft != 0) {
                                        controller.listImageLeft
                                            .removeAt(value);
                                      } else {
                                        controller.listImageRight
                                            .removeAt(value);
                                      }
                                      controller.listPathFinger.removeAt(value);
                                      controller.countFinger.value++;
                                      controller.update();
                                    })),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  )
                ]),
              ),
              SizedBox(
                  width: width,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: bottomButton(
                              isRegister:
                                  !(controller.listImageLeft.length == 3 ||
                                      controller.listImageRight.length == 3),
                              onTap: () {
                                if (controller.listImageLeft.length == 3 ||
                                    controller.listImageRight.length == 3) {
                                  Common.showToastCenter(
                                      AppLocalizations.of(context)!
                                          .textGetThree);
                                  return;
                                }
                                if (controller.listImageLeft.length < 3 ||
                                    controller.listImageRight.length < 3) {
                                  if (Platform.isAndroid) {
                                    controller.getCapture();
                                  } else {
                                    controller.indexLeft = 2;
                                    controller.listPathFinger.add('');
                                    controller.listImageLeft.add('');
                                    controller.countFinger.value--;
                                    controller.update();
                                    // Common.showToastCenter(
                                    //     AppLocalizations.of(context)!
                                    //         .textOnlyActionAndroid);
                                  }
                                }
                              },
                              text: AppLocalizations.of(context)!
                                  .textCapture
                                  .toUpperCase())),
                      Expanded(
                          flex: 1,
                          child: bottomButton(
                              isRegister:
                                  controller.listImageLeft.length == 3 ||
                                      controller.listImageRight.length == 3,
                              onTap: () {
                                if (controller.listImageLeft.length >= 3 ||
                                    controller.listImageRight.length >= 3) {
                                  controller.createCustomer(
                                    (isSuccess) {
                                      if (isSuccess) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SuccessDialog(
                                              height: 299,
                                              isSuccess: true,
                                              onClick: () {
                                                Get.back();
                                                Get.offNamed(
                                                    RouteConfig
                                                        .customerInformation,
                                                    arguments: [
                                                      controller.customerModel,
                                                      controller.requestId,
                                                      controller.productId,
                                                      controller.reasonId,
                                                      controller.isForcedTerm
                                                    ]);
                                              },
                                            );
                                          },
                                        );
                                      } else {
                                        Common.showToastCenter(
                                            AppLocalizations.of(context)!
                                                .textErrorAPI);
                                      }
                                    },
                                  );
                                } else {
                                  Common.showToastCenter(
                                      AppLocalizations.of(context)!
                                          .textLimitFingerRegister);
                                }
                              },
                              text: AppLocalizations.of(context)!
                                  .textRegister
                                  .toUpperCase())),
                    ],
                  )),
              SizedBox(
                height: 126,
              )
            ]),
          );
        });
  }

  Widget bottomButton(
      {required String text, required onTap, required isRegister}) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 24, right: 15, bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: isRegister ? AppColors.colorText3 : Colors.white,
              border: isRegister ? null : Border.all(color: Color(0xFFE3EAF2)),
              boxShadow: [
                BoxShadow(
                    color: isRegister ? Color(0xFFB3BBC5) : Colors.transparent,
                    blurRadius: 5),
              ]),
          child: Center(
              child: Text(
            text.toUpperCase(),
            style: TextStyle(
              color: isRegister ? Colors.white : Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          )),
        ),
      ),
    );
  }

  Widget infoClientView({required String lable, required String content}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 17,
            ),
            Text(lable),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 17,
            ),
            Text(content),
          ],
        ),
      ],
    );
  }

  Widget selectedFingerView(
      {required String text,
      required int value,
      required var groupValue,
      required onChange}) {
    return InkWell(
      onTap: () {
        onChange(value);
        controller.pathFinger.value = controller.findPathFinger();
      },
      splashColor: Colors.black38,
      child: Obx(
        () => SizedBox(
          child: Row(
            children: [
              groupValue.value == value
                  ? radioSelectFinger()
                  : radioUnSelectFinger(),
              SizedBox(
                width: 9,
              ),
              Text(
                text,
                style: AppStyles.b384858_14_500,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget radioUnSelectFinger() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(width: 1.875, color: Color(0xFF87A0B3)),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  Widget radioSelectFinger() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Color(0xFF29BDBE),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  Widget fingerPrintView(
      {required String link, required int value, required onDelete}) {
    return SizedBox(
      child: Row(children: [
        link.isNotEmpty
            ? Image.file(
                File(link),
                height: 55,
                fit: BoxFit.cover,
              )
            : SizedBox(
                width: 50,
                height: 55,
              ),
        SizedBox(
          width: 16,
        ),
        Center(
          child: SvgPicture.asset(AppImages.icTickFingerPrint),
        ),
        InkWell(
          onTap: () {
            onDelete(value);
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 14, top: 10, right: 10, bottom: 10),
            child: Center(
              child: SvgPicture.asset(AppImages.icDelete),
            ),
          ),
        ),
      ]),
    );
  }
}

class SuccessDialog extends Dialog {
  final double height;
  final bool isSuccess;
  var onClick;

  SuccessDialog(
      {super.key,
      required this.height,
      required this.isSuccess,
      required this.onClick});

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
              AppLocalizations.of(context)!.textIFelicidades,
              style: isSuccess ? AppStyles.r14 : AppStyles.r16,
            ),
            SizedBox(
              height: 16,
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
                AppLocalizations.of(context)!.textTusHuellas,
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 27, left: 38, right: 38),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.colorButton,
                borderRadius: BorderRadius.circular(24),
              ),
              child: InkWell(
                onTap: () {
                  onClick();
                },
                child: Center(
                    child: Text(
                  AppLocalizations.of(context)!.textMuchasGracias.toUpperCase(),
                  style: AppStyles.r5,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
