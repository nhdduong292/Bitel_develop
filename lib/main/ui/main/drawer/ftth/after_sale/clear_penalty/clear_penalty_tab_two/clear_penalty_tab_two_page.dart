// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ;
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../../res/app_images.dart';
import '../../../../../../../../res/app_styles.dart';
import '../../../../../../../router/route_config.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';
import 'clear_penalty_tab_two_logic.dart';

class ClearPenaltyTabTwoPage extends GetView<ClearPenaltyTabTwoLogic> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final FocusScopeNode _focusScopeNode = FocusScopeNode();
    return GetBuilder(
        init: ClearPenaltyTabTwoLogic(context: context),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
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
                          height: 8,
                        ),
                        SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.textEnterTheOTP,
                              style: AppStyles.r00A5B1_13_500
                                  .copyWith(fontSize: 17),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 26, right: 26),
                          child: Text(
                            AppLocalizations.of(context)!.textItHasBeenSentTo,
                            style: AppStyles.r405264_14_500
                                .copyWith(fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        OTPTextField(
                          length: 4,
                          width: 230,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 50,
                          keyboardType: TextInputType.number,
                          fieldStyle: FieldStyle.box,
                          outlineBorderRadius: 19,
                          spaceBetween: 10,
                          style: AppStyles.r19,
                          onChanged: (pin) {
                            if (int.parse(pin) < 1000) {
                              controller.isActiveButton = false;
                              controller.update();
                            }
                            print("Changed: " + pin);
                          },
                          onCompleted: (pin) {
                            controller.isActiveButton = true;
                            controller.update();
                            print("Completed: " + pin);
                          },
                        ),
                        SizedBox(height: 15),
                        Obx(
                          () => RichText(
                              text: TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .textTimeRemaining,
                                  style: AppStyles.r405264_14_500
                                      .copyWith(fontWeight: FontWeight.w400),
                                  children: [
                                TextSpan(
                                    text: Common.formatedTime(
                                        timeInSecond:
                                            controller.countDown.value),
                                    style: AppStyles.rF76F5A_13_500
                                        .copyWith(fontSize: 14))
                              ])),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: RichText(
                              text: TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .textIfYouDoNotRecive,
                                  style: AppStyles.rF76F5A_13_500,
                                  children: [
                                TextSpan(
                                    text:
                                        '${AppLocalizations.of(context)!.textClickOn} ',
                                    style: AppStyles.r405264_14_500
                                        .copyWith(fontSize: 13)),
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (controller.countDown.value == 0) {
                                          controller.countDown.value = 120;
                                          controller.startTimer();
                                        }
                                      },
                                    text: AppLocalizations.of(context)!
                                        .textResendOTP,
                                    style: AppStyles.rF76F5A_13_500),
                                TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .textOnceTheRemainingTimes,
                                    style: AppStyles.r405264_14_500
                                        .copyWith(fontSize: 13))
                              ])),
                        ),
                        SizedBox(
                          height: 150,
                        )
                      ]),
                    ),
                    SizedBox(
                      width: width,
                      child: bottomButton(
                          text: AppLocalizations.of(context)!
                              .textValidatev2
                              .toUpperCase(),
                          onTap: () {
                            if (!controller.isActiveButton) {
                              return;
                            }
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SuccessDialog(
                                  height: 292,
                                  isSuccess: true,
                                  onContinue: () {
                                    Get.back();
                                  },
                                );
                              },
                            );
                          },
                          color: controller.isActiveButton
                              ? null
                              : const Color(0xFF415263).withOpacity(0.2)),
                    ),
                  ]),
            ),
          );
        });
  }
}

class SuccessDialog extends Dialog {
  final double height;
  final bool isSuccess;
  Function onContinue;

  SuccessDialog({
    super.key,
    required this.height,
    required this.isSuccess,
    required this.onContinue,
  });

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
              AppLocalizations.of(context)!.textCongratulation,
              style: isSuccess ? AppStyles.r14 : AppStyles.r16,
            ),
            SizedBox(
              height: 10,
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
                AppLocalizations.of(context)!.textCongratulations,
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
                  onContinue();
                },
                child: Center(
                    child: Text(
                  AppLocalizations.of(context)!.textThankYou.toUpperCase(),
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
