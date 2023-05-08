// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../../../../../../res/app_colors.dart';
import 'cell_phone_verify_sms_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
typedef void TouchScan();

class CellPhoneVerifySmsWidget extends GetView<CellPhoneVerifySmsWidget> {
  final TouchScan callback;
  CellPhoneVerifySmsWidget({required this.callback});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: CellPhoneVerifySmsLogic(),
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
                    height: 8,
                  ),
                  SizedBox(
                    height: 30,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.textAdditionalInformation,
                        style: AppStyles.r3,
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
                      AppLocalizations.of(context)!.textWehavesentv2,
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
                      style: AppStyles.r8,
                      onChanged: (pin) {
                        print("Changed: " + pin);
                      },
                      onCompleted: (pin) {
                        print("Completed: " + pin);
                      }),
                  SizedBox(height: 15),
                  RichText(
                      text: TextSpan(
                          text: AppLocalizations.of(context)!.textTimeRemaining,
                          style: AppStyles.r1,
                          children: [
                        TextSpan(text: '01:30', style: AppStyles.r3)
                      ])),
                  SizedBox(
                    height: 12,
                  ),
                  RichText(
                      text: TextSpan(
                          text: AppLocalizations.of(context)!.textDidOTPCode,
                          style: AppStyles.r1,
                          children: [
                        TextSpan(text: AppLocalizations.of(context)!.textResendCode, style: AppStyles.r3)
                      ])),
                  SizedBox(
                    height: 103,
                  )
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
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                  onTap: () {
                    callback();
                  },
                  child: Center(
                      child: Text(
                    AppLocalizations.of(context)!.textValidatev2.toUpperCase(),
                    style: AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                  )),
                ),
              )
            ]),
          );
        });
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
}
