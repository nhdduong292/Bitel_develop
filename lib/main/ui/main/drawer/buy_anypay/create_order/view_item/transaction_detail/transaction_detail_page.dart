// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/ui/main/drawer/buy_anypay/create_order/view_item/transaction_detail/transaction_detail_logic.dart';
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

class TransactionDetailPage extends GetView<TransactionDetailLogic> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: TransactionDetailLogic(context: context),
        builder: (controller) {
          return SingleChildScrollView(
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
                          _itemInfor(
                              title: AppLocalizations.of(context)!.textCode,
                              content: controller.buyAnyPayCreateModel.code,
                              isColor: false),
                          DottedLine(
                            dashColor: Color(0xFFE3EAF2),
                            dashGapLength: 3,
                            dashLength: 4,
                          ),
                          _itemInfor(
                              title: AppLocalizations.of(context)!.textIDNumber,
                              content: controller.buyAnyPayCreateModel.idNumber,
                              isColor: false),
                          DottedLine(
                            dashColor: Color(0xFFE3EAF2),
                            dashGapLength: 3,
                            dashLength: 4,
                          ),
                          _itemInfor(
                              title: AppLocalizations.of(context)!.textName,
                              content: controller.buyAnyPayCreateModel.name,
                              isColor: false),
                          DottedLine(
                            dashColor: Color(0xFFE3EAF2),
                            dashGapLength: 3,
                            dashLength: 4,
                          ),
                          _itemInfor(
                              title:
                                  '${AppLocalizations.of(context)!.textAmount} (1)',
                              content:
                                  'S/${controller.buyAnyPayCreateModel.amount}',
                              isColor: true),
                          DottedLine(
                            dashColor: Color(0xFFE3EAF2),
                            dashGapLength: 3,
                            dashLength: 4,
                          ),
                          _itemInfor(
                              title:
                                  '${AppLocalizations.of(context)!.textDiscount} (2)',
                              content:
                                  'S/${controller.buyAnyPayCreateModel.discount}',
                              isColor: true),
                          DottedLine(
                            dashColor: Color(0xFFE3EAF2),
                            dashGapLength: 3,
                            dashLength: 4,
                          ),
                          _itemInfor(
                              title:
                                  '${AppLocalizations.of(context)!.textTotalAPagar} (1-2)',
                              content:
                                  'S/${controller.buyAnyPayCreateModel.total}',
                              isColor: true)
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                                    .textLegalConditions,
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
                            height: 15,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              controller.isCheckBox = !controller.isCheckBox;
                              controller.update();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 17,
                                ),
                                controller.isCheckBox
                                    ? iconChecked()
                                    : iconUnchecked(),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .textIHaveReadAndAcceptTheTerms,
                                    style: AppStyles.r6C8AA1_13_400,
                                  ),
                                ),
                                SizedBox(
                                  width: 17,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ]),
                  ),
                  SizedBox(
                    width: width,
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textBuy,
                        onTap: () {
                          if (controller.isCheckBox) {
                            controller.postCreateBuyAnyPay(
                                isSuccess: (isSuccess) {
                              if (isSuccess) {
                                controller.setBuyAnyPayModel();

                                controller.createOrderLogic.isTabThree.value =
                                    true;
                                controller.createOrderLogic.isTabTwo.value =
                                    false;

                                controller.createOrderLogic.nextPage(2);
                              }
                            });
                          }
                        },
                        color: controller.isCheckBox
                            ? null
                            : const Color(0xFF415263).withOpacity(0.2)),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(top: 24, left: 10, right: 10),
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
                                    child:
                                        SvgPicture.asset(AppImages.icAnypayBCP))
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
          );
        });
  }

  Widget _itemInfor(
      {required String title, required String content, required bool isColor}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                title,
                style: AppStyles.r6C8AA1_13_400,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              content,
              style: isColor
                  ? AppStyles.r9454C9_14_500
                      .copyWith(fontSize: 13, fontWeight: FontWeight.w700)
                  : AppStyles.r2B3A4A_12_500.copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
