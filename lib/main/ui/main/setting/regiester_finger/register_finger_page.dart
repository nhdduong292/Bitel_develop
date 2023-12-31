import 'dart:io';

import 'package:bitel_ventas/main/ui/main/drawer/contracting/validate_fingerprint/validate_fingerprint_logic.dart';
import 'package:bitel_ventas/main/ui/main/setting/my_info/my_info_logic.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../res/app_colors.dart';
import '../../../../../res/app_styles.dart';
import '../../../../router/route_config.dart';
import '../../../../utils/common.dart';
import '../../../../utils/dialog_util.dart';
import '../../drawer/manage_contact/create/view_item/register_finger_print/register_finger_print_logic.dart';
import 'register_finger_logic.dart';

class RegisterFingerPage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: RegisterFingerLogic(context: context),
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: EdgeInsets.only(left: 18, bottom: 18, top: 2),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: SvgPicture.asset(AppImages.icBack),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              elevation: 0.0,
              title: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.textRegisterFingerPrint,
                        style: AppStyles.title),
                    Container(height: 5),
                  ],
                ),
              ),
              toolbarHeight: 100,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    color: AppColors.colorBackground,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(width / 2, 20),
                        bottomRight: Radius.elliptical(width / 2, 20))),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20),
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 51, right: 82),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    selectedFingerView(
                                        text: AppLocalizations.of(context)!
                                            .textLeft,
                                        value: 1,
                                        groupValue: controller.handValue,
                                        onChange: (value) {
                                          if (controller
                                                  .listImageLeft.isEmpty &&
                                              controller
                                                  .listImageRight.isEmpty) {
                                            controller.handValue.value = value;
                                          }
                                        },
                                        controller: controller),
                                    selectedFingerView(
                                        text: AppLocalizations.of(context)!
                                            .textRight,
                                        value: 2,
                                        groupValue: controller.handValue,
                                        onChange: (value) {
                                          if (controller
                                                  .listImageLeft.isEmpty &&
                                              controller
                                                  .listImageRight.isEmpty) {
                                            controller.handValue.value = value;
                                          }
                                        },
                                        controller: controller),
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
                          Text(
                              AppLocalizations.of(context)!
                                  .textYourBestFingerprint,
                              style: AppStyles.r00A5B1_13_500.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
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
                                        text: AppLocalizations.of(context)!
                                            .textThumb,
                                        value: 1,
                                        groupValue: controller.fingerValue,
                                        onChange: (value) {
                                          if (controller
                                                  .listImageLeft.isEmpty &&
                                              controller
                                                  .listImageRight.isEmpty) {
                                            controller.fingerValue.value =
                                                value;
                                          }
                                        },
                                        controller: controller),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    selectedFingerView(
                                        text: AppLocalizations.of(context)!
                                            .textIndex,
                                        value: 2,
                                        groupValue: controller.fingerValue,
                                        onChange: (value) {
                                          if (controller
                                                  .listImageLeft.isEmpty &&
                                              controller
                                                  .listImageRight.isEmpty) {
                                            controller.fingerValue.value =
                                                value;
                                          }
                                        },
                                        controller: controller),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    selectedFingerView(
                                        text: AppLocalizations.of(context)!
                                            .textMiddle,
                                        value: 3,
                                        groupValue: controller.fingerValue,
                                        onChange: (value) {
                                          if (controller
                                                  .listImageLeft.isEmpty &&
                                              controller
                                                  .listImageRight.isEmpty) {
                                            controller.fingerValue.value =
                                                value;
                                          }
                                        },
                                        controller: controller),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    selectedFingerView(
                                        text: AppLocalizations.of(context)!
                                            .textRing,
                                        value: 4,
                                        groupValue: controller.fingerValue,
                                        onChange: (value) {
                                          if (controller
                                                  .listImageLeft.isEmpty &&
                                              controller
                                                  .listImageRight.isEmpty) {
                                            controller.fingerValue.value =
                                                value;
                                          }
                                        },
                                        controller: controller),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    selectedFingerView(
                                        text: AppLocalizations.of(context)!
                                            .textLittle,
                                        value: 5,
                                        groupValue: controller.fingerValue,
                                        onChange: (value) {
                                          if (controller
                                                  .listImageLeft.isEmpty &&
                                              controller
                                                  .listImageRight.isEmpty) {
                                            controller.fingerValue.value =
                                                value;
                                          }
                                        },
                                        controller: controller),
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
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
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
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              controller.countFinger.value = 3;
                              controller.listImageLeft.clear();
                              controller.listImageRight.clear();
                              controller.listPathFinger.clear();
                              controller.currentImageFinger = '';
                              controller.currentPathFinger = '';
                              controller.update();
                            },
                            child: DottedBorder(
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
                                    AppLocalizations.of(context)!
                                        .textClickHereTo,
                                    style: AppStyles.r9454C9_14_500
                                        .copyWith(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .textDigitalFingerprint,
                                          style: AppStyles.r405264_14_500
                                              .copyWith(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400),
                                        )),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      width: 140,
                                      height: 165,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFE3EAF2), width: 1),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: controller.currentPathFinger
                                                  .isNotEmpty &&
                                              controller.currentPathFinger !=
                                                  "String"
                                          ? Image.file(
                                              File(
                                                  controller.currentPathFinger),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                                (controller.listImageLeft.isEmpty &&
                                        controller.listImageRight.isEmpty)
                                    ? SizedBox(
                                        width: 133,
                                      )
                                    : Column(
                                        children: [
                                          Visibility(
                                              visible: (controller.listImageLeft
                                                      .isNotEmpty ||
                                                  controller.listImageRight
                                                      .isNotEmpty),
                                              child: fingerPrintView(
                                                  link: controller
                                                          .listPathFinger
                                                          .isNotEmpty
                                                      ? controller
                                                          .listPathFinger[0]
                                                      : '',
                                                  value: 0,
                                                  onDelete: (value) {
                                                    if (controller.indexLeft !=
                                                        0) {
                                                      controller.listImageLeft
                                                          .removeAt(value);
                                                    } else {
                                                      controller.listImageRight
                                                          .removeAt(value);
                                                    }
                                                    controller.listPathFinger
                                                        .removeAt(value);
                                                    controller
                                                        .countFinger.value++;
                                                    controller.update();
                                                  })),
                                          Visibility(
                                              visible: (controller.listImageLeft
                                                          .length >=
                                                      2 ||
                                                  controller.listImageRight
                                                          .length >=
                                                      2),
                                              child: fingerPrintView(
                                                  link: controller
                                                              .listPathFinger
                                                              .length >=
                                                          2
                                                      ? controller
                                                          .listPathFinger[1]
                                                      : '',
                                                  value: 1,
                                                  onDelete: (value) {
                                                    if (controller.indexLeft !=
                                                        0) {
                                                      controller.listImageLeft
                                                          .removeAt(value);
                                                    } else {
                                                      controller.listImageRight
                                                          .removeAt(value);
                                                    }
                                                    controller.listPathFinger
                                                        .removeAt(value);
                                                    controller
                                                        .countFinger.value++;
                                                    controller.update();
                                                  })),
                                          Visibility(
                                              visible: (controller.listImageLeft
                                                          .length >=
                                                      3 ||
                                                  controller.listImageRight
                                                          .length >=
                                                      3),
                                              child: fingerPrintView(
                                                  link: controller
                                                              .listPathFinger
                                                              .length ==
                                                          3
                                                      ? controller
                                                          .listPathFinger[2]
                                                      : '',
                                                  value: 2,
                                                  onDelete: (value) {
                                                    if (controller.indexLeft !=
                                                        0) {
                                                      controller.listImageLeft
                                                          .removeAt(value);
                                                    } else {
                                                      controller.listImageRight
                                                          .removeAt(value);
                                                    }
                                                    controller.listPathFinger
                                                        .removeAt(value);
                                                    controller
                                                        .countFinger.value++;
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
                                      isRegister: !(controller
                                                  .listImageLeft.length ==
                                              3 ||
                                          controller.listImageRight.length ==
                                              3),
                                      onTap: () {
                                        if (controller.listImageLeft.length ==
                                                3 ||
                                            controller.listImageRight.length ==
                                                3) {
                                          Common.showToastCenter(
                                              AppLocalizations.of(context)!
                                                  .textGetThree,
                                              context);
                                          return;
                                        }
                                        if (controller.listImageLeft.length <
                                                3 ||
                                            controller.listImageRight.length <
                                                3) {
                                          if (Platform.isAndroid) {
                                            controller.getCapture();
                                          } else {
                                            // controller.indexLeft = controller.indexLeft;
                                            controller.currentPathFinger =
                                                'String';
                                            controller.currentImageFinger =
                                                'String';
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
                                      isRegister: controller
                                                  .listImageLeft.length ==
                                              3 ||
                                          controller.listImageRight.length ==
                                              3 ||
                                          controller
                                              .currentPathFinger.isNotEmpty,
                                      onTap: () {
                                        if (controller.listImageLeft.length >=
                                                3 ||
                                            controller.listImageRight.length >=
                                                3) {
                                          controller.saveInternalFinger(
                                            (isSuccess) {
                                              if (isSuccess) {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SuccessDialog(
                                                      height: 299,
                                                      isSuccess: true,
                                                      onClick: () {
                                                        Get.until((route) {
                                                          return Get
                                                                  .currentRoute ==
                                                              RouteConfig
                                                                  .validateFingerprint;
                                                        });
                                                        ValidateFingerprintLogic
                                                            validateFingerprintLogic =
                                                            Get.find();
                                                        validateFingerprintLogic
                                                            .reset();
                                                      },
                                                    );
                                                  },
                                                );
                                              } else {
                                                Common.showToastCenter(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .textErrorAPI,
                                                    context);
                                              }
                                            },
                                          );
                                        } else if (controller
                                                .currentPathFinger.isNotEmpty &&
                                            controller.currentImageFinger
                                                .isNotEmpty) {
                                          if (controller.indexLeft > 0) {
                                            controller.listImageLeft.add(
                                                controller.currentImageFinger);
                                            controller.listPathFinger.add(
                                                controller.currentPathFinger);
                                            controller.countFinger.value--;
                                            Common.showToastCenter(
                                                '${AppLocalizations.of(context)!.textGetSuccess} ${controller.listImageLeft.length}',
                                                context);
                                          } else {
                                            controller.listImageRight.add(
                                                controller.currentImageFinger);
                                            controller.listPathFinger.add(
                                                controller.currentPathFinger);
                                            controller.countFinger.value--;
                                            Common.showToastCenter(
                                                "${AppLocalizations.of(context)!.textGetSuccess} ${controller.listImageRight.length}",
                                                context);
                                          }
                                        } else {
                                          Common.showToastCenter(
                                              AppLocalizations.of(context)!
                                                  .textLimitFingerRegister,
                                              context);
                                        }
                                        controller.currentPathFinger = '';
                                        controller.currentImageFinger = '';
                                        controller.update();
                                      },
                                      text: controller.listImageLeft.length ==
                                                  3 ||
                                              controller
                                                      .listImageRight.length ==
                                                  3
                                          ? AppLocalizations.of(context)!
                                              .textRegister
                                              .toUpperCase()
                                          : AppLocalizations.of(context)!
                                              .textSave
                                              .toUpperCase())),
                            ],
                          )),
                      SizedBox(
                        height: 126,
                      )
                    ]),
              ),
            ));
      },
    );
  }

  Widget bottomButton(
      {required String text, required onTap, required isRegister}) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 24, right: 15, bottom: 10),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
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
      required onChange,
      required RegisterFingerLogic controller}) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        onChange(value);
        controller.pathFinger.value = controller.findPathFinger();
      },
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
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: SizedBox(
        child: Row(children: [
          SizedBox(
            width: 8,
          ),
          link.isNotEmpty && link != "String"
              ? Image.file(
                  File(link),
                  height: 55,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 50,
                  height: 55,
                  color: Colors.black,
                ),
          SizedBox(
            width: 16,
          ),
          Center(
            child: SvgPicture.asset(AppImages.icTickFingerPrint),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              onDelete(value);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, top: 10, right: 5, bottom: 10),
              child: Center(
                child: SvgPicture.asset(AppImages.icDelete),
              ),
            ),
          ),
        ]),
      ),
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
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
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
