// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bitel_ventas/main/ui/main/drawer/contracting/register_finger_print/register_finger_print_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';
import '../../../../../router/route_config.dart';

class RegisterFingerPrintPage extends GetView<RegisterFingerPrintLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: RegisterFingerPrintLogic(),
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
                                  .textRegisterFingerPrint,
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
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 51, right: 82),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      selectedFingerView(
                                          isSelect: false,
                                          text: AppLocalizations.of(context)!
                                              .textLeft),
                                      selectedFingerView(
                                          isSelect: true,
                                          text: AppLocalizations.of(context)!
                                              .textRight)
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    AppImages.imgFinger,
                                    height: 140,
                                    fit: BoxFit.cover,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      selectedFingerView(
                                          isSelect: false,
                                          text: AppLocalizations.of(context)!
                                              .textThumb),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      selectedFingerView(
                                          isSelect: false,
                                          text: AppLocalizations.of(context)!
                                              .textIndex),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      selectedFingerView(
                                          isSelect: true,
                                          text: AppLocalizations.of(context)!
                                              .textMiddle),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      selectedFingerView(
                                          isSelect: false,
                                          text: AppLocalizations.of(context)!
                                              .textRing),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      selectedFingerView(
                                          isSelect: false,
                                          text: AppLocalizations.of(context)!
                                              .textLittle)
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
                            RichText(
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
                                            '3 ${AppLocalizations.of(context)!.textTimes}',
                                        style: AppStyles.r9454C9_14_500
                                            .copyWith(fontSize: 13),
                                      ),
                                    ])),
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
                                    AppLocalizations.of(context)!
                                        .textClickHereTo,
                                    style: AppStyles.r9454C9_14_500
                                        .copyWith(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 57, right: 57),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .textDigitalFingerprint,
                                            style: AppStyles.r405264_14_500
                                                .copyWith(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          )),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        width: 150,
                                        height: 165,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xFFE3EAF2),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      fingerPrintView(
                                          link: AppImages.imgFingerPrint),
                                      fingerPrintView(
                                          link: AppImages.imgFingerPrint),
                                      fingerPrintView(
                                          link: AppImages.imgFingerPrint)
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
                                    child: bottomButtonV2(
                                        onTap: () {},
                                        text: AppLocalizations.of(context)!
                                            .textCapture
                                            .toUpperCase())),
                                Expanded(
                                    flex: 1,
                                    child: bottomButton(
                                        onTap: () {},
                                        text: AppLocalizations.of(context)!
                                            .textRegister
                                            .toUpperCase())),
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

  Widget selectedFingerView({required bool isSelect, required String text}) {
    return SizedBox(
      child: Row(
        children: [
          isSelect ? radioSelectFinger() : radioUnSelectFinger(),
          SizedBox(
            width: 9,
          ),
          Text(
            text,
            style: AppStyles.b384858_14_500,
          )
        ],
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

  Widget fingerPrintView({required String link}) {
    return SizedBox(
      child: Row(children: [
        Image.asset(
          link,
          height: 64,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 16,
        ),
        Center(
          child: SvgPicture.asset(AppImages.icTickFingerPrint),
        )
      ]),
    );
  }
}
