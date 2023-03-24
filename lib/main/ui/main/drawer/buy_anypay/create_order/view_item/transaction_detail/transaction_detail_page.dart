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

class TransactionDetailPage extends GetView<TransactionInformationLogic> {
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
                              DottedLine(
                                dashColor: Color(0xFFE3EAF2),
                                dashGapLength: 3,
                                dashLength: 4,
                              ),
                            ]),
                      ),
                      SizedBox(
                        width: width,
                        child: bottomButton(
                            text: AppLocalizations.of(context)!.textContinue,
                            onTap: () {
                              if (!controller.validateEmail()) {
                                return;
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
}
