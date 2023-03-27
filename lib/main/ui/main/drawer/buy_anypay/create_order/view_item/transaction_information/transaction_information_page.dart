// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ;
import 'dart:ffi';

import 'package:bitel_ventas/main/ui/main/drawer/buy_anypay/create_order/view_item/transaction_information/transaction_information_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../../res/app_images.dart';
import '../../../../../../../../res/app_styles.dart';
import '../../../../../../../utils/common_widgets.dart';

typedef void TouchScan();

class TransactionInformationPage extends GetView<TransactionInformationLogic> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: TransactionInformationLogic(context: context),
        builder: (controller) {
          return FocusScope(
            node: controller.focusScopeNode,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
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
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                height: 30,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .textTransactionInformation,
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
                              SizedBox(
                                height: 16,
                              ),
                              itemTextFieldLock(
                                title: AppLocalizations.of(context)!.textCode,
                                content: 'LI1DL01',
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              itemTextFieldLock(
                                title:
                                    AppLocalizations.of(context)!.textIDNumber,
                                content: '19283737',
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              itemTextFieldLock(
                                title: AppLocalizations.of(context)!.textName,
                                content: 'RUC 2019283737',
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              itemTextFieldLock(
                                  title: AppLocalizations.of(context)!
                                      .textCurrentAnypay,
                                  content: '990.1',
                                  textColor: AppColors.color_9454C9),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 14,
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .textAmountToBuy,
                                            style: AppStyles.r2B3A4A_12_500
                                                .copyWith(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                            children: [
                                          TextSpan(
                                              text: ' *',
                                              style: AppStyles.rF76F5A_13_500)
                                        ])),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .textTheMinimumIs100,
                                      style: AppStyles.r2B3A4A_12_500.copyWith(
                                          color: AppColors.color_2B3A4A
                                              .withOpacity(0.65),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    inputFrom(
                                        controller:
                                            controller.textAmountController,
                                        context: context,
                                        hint: AppLocalizations.of(context)!
                                            .textEnterTheAmount,
                                        type: TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                        errorText: controller.errorTextAmount,
                                        onChange: () {
                                          controller.checkValidate();
                                        })
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .textCreateOrder,
                                        style: AppStyles.r2B3A4A_12_500
                                            .copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400)),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    inputFrom(
                                        controller:
                                            controller.textEmailController,
                                        context: context,
                                        hint: AppLocalizations.of(context)!
                                            .textSendToEmail,
                                        type: TextInputType.text,
                                        onChange: () {
                                          controller.checkValidate();
                                        })
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 20, left: 15, right: 15, bottom: 19),
                                padding: const EdgeInsets.only(
                                    top: 10, left: 40, bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color(0xFFE3EAF2), width: 1),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            controller.textCaptchaController,
                                        style: AppStyles.r415263_13_500
                                            .copyWith(fontSize: 16),
                                        onChanged: (value) {
                                          controller.checkValidate();
                                        },
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .textEnterCaptcha,
                                          hintStyle: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF7F96AD)),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 12.01),
                                      child: InkWell(
                                        child: Image.asset(
                                            AppImages.imgCapchaTest),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 7.04),
                                      child: InkWell(
                                        child: SvgPicture.asset(
                                            AppImages.icRefreshCapcha),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        width: width,
                        child: bottomButton(
                            text: AppLocalizations.of(context)!.textContinue,
                            onTap: () {
                              if (controller.isActiveButton) {
                                if (!controller.validateEmail()) {
                                  return;
                                }
                                controller.setAmountToBuy();

                                controller.createOrderLogic.isTabOne.value =
                                    false;
                                controller.createOrderLogic.isTabTwo.value =
                                    true;

                                controller.createOrderLogic.nextPage(1);
                              }
                            },
                            color: controller.isActiveButton
                                ? null
                                : const Color(0xFF415263).withOpacity(0.2)),
                      ),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              top: 24, left: 10, right: 10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                width: 1, color: AppColors.colorLineDash),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                blurRadius: 1,
                                color: AppColors.colorLineDash,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .textTitleAnypay1,
                                    style: AppStyles.r415263_14_600,
                                    children: [
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .textTitleAnypay2,
                                          style: AppStyles.r415263_14_400)
                                    ]),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                height: 80,
                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                        child: SvgPicture.asset(
                                            AppImages.icAnypayBBVA)),
                                    VerticalDivider(
                                      color: AppColors.colorLineDash,
                                    ),
                                    Expanded(
                                        child: SvgPicture.asset(
                                            AppImages.icAnypayBCP))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ]),
              ),
            ),
          );
        });
  }

  Widget itemTextFieldLock(
      {required String title, required String content, Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.r2B3A4A_12_500
                .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 9,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xFFE3EAF2)),
                borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.only(left: 21, top: 13, bottom: 13),
              child: Text(
                content,
                style: textColor == null
                    ? AppStyles.r415263_13_500
                    : AppStyles.r415263_13_500.copyWith(color: textColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget inputFrom(
      {required TextEditingController controller,
      required BuildContext context,
      required String hint,
      required TextInputType type,
      String? errorText,
      required onChange}) {
    return TextField(
        controller: controller,
        keyboardType: type,
        textInputAction: TextInputAction.done,
        style: AppStyles.r2
            .copyWith(color: AppColors.colorTitle, fontWeight: FontWeight.w500),
        onChanged: (value) {
          onChange();
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          hintText: hint,
          errorText: errorText,
          hintStyle: AppStyles.r2.copyWith(
              color: AppColors.colorHint1, fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.colorLineDash)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(width: 1, color: Colors.redAccent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.colorLineDash)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.colorLineDash)),
        ));
  }
}
