// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/style.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../res/app_styles.dart';
import 'forgot_password_logic.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:math';

class ForgotPassword extends GetView<ForgotPasswordLogic> {
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  var checkIsVerify = false.obs;
  var checkIsUpdate = false.obs;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: ForgotPasswordLogic(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      width: width,
                      height: 147,
                    ),
                    SvgPicture.asset(
                      AppImages.bgAppbar,
                      width: width,
                    ),
                    Positioned(
                      top: 40,
                      left: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.textForgotPassword,
                              style: AppStyles.title),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.icTimeBar),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("28/12/2020 07:30 - V1.1",
                                  style: AppStyles.b1),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        top: 35,
                        left: 20,
                        child: InkWell(
                          onTap: () {
                            if (_itemPositionsListener.itemPositions.value
                                    .elementAt(0)
                                    .index ==
                                0) {
                              Get.back();
                            } else {
                              checkIsVerify.value = false;
                              _scrollController.scrollTo(
                                index: 0,
                                duration: const Duration(milliseconds: 200),
                              );
                            }
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
                    Positioned(
                        top: 111,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SizedBox(
                            width: 120,
                            height: 36,
                            child: Row(
                              children: [
                                circleMarkerView(check: true.obs, text: '1'),
                                const SizedBox(
                                  width: 48,
                                ),
                                circleMarkerView(
                                    check: checkIsVerify, text: '2'),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 470,
                          child: ScrollablePositionedList.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 2,
                              itemScrollController: _scrollController,
                              itemPositionsListener: _itemPositionsListener,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return _changePassword(context: context);
                                } else {
                                  return _verifyPhoneNumber(context: context);
                                }
                              }),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              top: 41, left: 25, right: 25),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.colorButton,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: InkWell(
                            onTap: () {
                              checkIsVerify.value = true;
                              _scrollController.scrollTo(
                                index: 1,
                                duration: const Duration(milliseconds: 200),
                              );

                              var random = Random();
                              bool randomBool = random.nextBool();

                              if (checkIsUpdate.value) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SuccessDialog(
                                      height: randomBool ? 299 : 341,
                                      isSuccess: randomBool,
                                    );
                                  },
                                );
                              }
                            },
                            child: Center(
                                child: Obx(() => Text(
                                      !checkIsUpdate.value
                                          ? AppLocalizations.of(context)!
                                              .textContinue
                                              .toUpperCase()
                                          : AppLocalizations.of(context)!
                                              .textUpdatePassword
                                              .toUpperCase(),
                                      style: AppStyles.r5,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _changePassword({required BuildContext context}) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 20,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffE3EAF2), width: 1),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(185, 212, 220, 0.18),
            offset: Offset(0, 9),
            blurRadius: 20,
          ),
        ],
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
      ),
      margin: const EdgeInsets.only(top: 16, left: 10, right: 10),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 9, bottom: 4.16),
          width: 256,
          height: 30,
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.textChangePassword,
            style: AppStyles.r00A5B1,
          )),
        ),
        const DottedLine(
          dashColor: Color(0xFFE3EAF2),
          dashGapLength: 3,
          dashLength: 4,
        ),
        const SizedBox(
          height: 26.84,
        ),
        SizedBox(
          width: width,
          child: Column(children: [
            inputForm(
                label: AppLocalizations.of(context)!.textOldPassword,
                hint: 'Enter password',
                required: false,
                inputType: TextInputType.text)
          ]),
        ),
        SizedBox(
          width: width,
          child: Column(children: [
            inputFormPassword(
                label: AppLocalizations.of(context)!.textNewPassword,
                hint: 'Enter password',
                required: false,
                inputType: TextInputType.text,
                isVisibility: false.obs)
          ]),
        ),
        SizedBox(
          width: width,
          child: Column(children: [
            inputFormPassword(
                label: AppLocalizations.of(context)!.textRepeatNewPassword,
                hint: 'Enter password',
                required: false,
                inputType: TextInputType.text,
                isVisibility: false.obs)
          ]),
        ),
        const SizedBox(
          height: 17,
        ),
        Container(
          margin:
              const EdgeInsets.only(top: 17, left: 15, right: 15, bottom: 19),
          padding: const EdgeInsets.only(top: 10, left: 40, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.transparent, // Màu nền
            border: Border.all(
                color: Colors.grey.shade300,
                width: 1), // Viền đường kẻ màu xám nhạt
            borderRadius: BorderRadius.circular(30), // Góc bo tròn 30px
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter captcha',
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 12.01),
                child: InkWell(
                  child: Image.asset(AppImages.imgCapchaTest),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 7.04),
                child: InkWell(
                  child: SvgPicture.asset(AppImages.icRefreshCapcha),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget _verifyPhoneNumber({required BuildContext context}) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 20,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffE3EAF2), width: 1),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(185, 212, 220, 0.18),
            offset: Offset(0, 9),
            blurRadius: 20,
          ),
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      margin: const EdgeInsets.only(top: 16, left: 10, right: 10),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 9, bottom: 4.16),
          width: 256,
          height: 30,
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.textVerifyYour,
            style: AppStyles.r00A5B1,
          )),
        ),
        const DottedLine(
          dashColor: Color(0xFFE3EAF2),
          dashGapLength: 3,
          dashLength: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.84),
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.textEnterTheOTP,
            style: AppStyles.r17,
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.84, left: 40, right: 40),
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.textAnOTPHasBeen,
            style: AppStyles.r7,
            textAlign: TextAlign.center,
          )),
        ),
        SizedBox(
          height: 23,
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
            style: AppStyles.r8,
            onChanged: (pin) {
              print("Changed: " + pin);
            },
            onCompleted: (pin) {
              print("Completed: " + pin);
              checkIsUpdate.value = true;
            }),
        SizedBox(
          height: 15,
        ),
        Visibility(
          visible: true,
          child: RichText(
            text: TextSpan(
              style: AppStyles.r10,
              children: <TextSpan>[
                TextSpan(
                  text: AppLocalizations.of(context)!.textTimeRemaining,
                ),
                TextSpan(
                  text: '01:30',
                  style: AppStyles.r9,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: true,
          child: Padding(
            padding: EdgeInsets.only(top: 14),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: AppLocalizations.of(context)!.textDidntGetTheOTP,
                    style: AppStyles.r10,
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context)!.textResendOTP,
                    style: AppStyles.r13,
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(26),
              dashPattern: [2, 2],
              strokeWidth: 1,
              color: AppColors.color_9454C9,
              child: SizedBox(
                width: 230,
                height: 48,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.done,
                    color: AppColors.color_9454C9,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.textCorrectCode,
                    style: AppStyles.r11,
                  )
                ]),
              ),
            ),
          ),
        ),
        Visibility(
          visible: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(26),
              dashPattern: [2, 2],
              strokeWidth: 1,
              color: AppColors.color_F76F5A,
              child: SizedBox(
                width: 270,
                height: 48,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset(AppImages.icWarning),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Incorrect code (1/3 tries)',
                    style: AppStyles.r12,
                  )
                ]),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class SuccessDialog extends Dialog {
  final double height;
  final bool isSuccess;

  const SuccessDialog(
      {super.key, required this.height, required this.isSuccess});
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
              isSuccess
                  ? AppLocalizations.of(context)!.textCongratulations
                  : AppLocalizations.of(context)!.textNotify,
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
                isSuccess
                    ? AppLocalizations.of(context)!.textYourPassword
                    : AppLocalizations.of(context)!.textYouHaveEntered,
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            Visibility(
              visible: !isSuccess,
              child: Padding(
                padding: const EdgeInsets.only(top: 26),
                child: Text(
                  AppLocalizations.of(context)!.textYouWillRedo,
                  style: AppStyles.r10,
                  textAlign: TextAlign.center,
                ),
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
                onTap: () {},
                child: Center(
                    child: Text(
                  isSuccess
                      ? AppLocalizations.of(context)!.textOk.toUpperCase()
                      : AppLocalizations.of(context)!
                          .textUnderstood
                          .toUpperCase(),
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
