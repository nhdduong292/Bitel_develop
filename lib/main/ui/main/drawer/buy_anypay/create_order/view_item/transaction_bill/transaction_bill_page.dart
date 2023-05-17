// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
// ;
import 'package:bitel_ventas/main/ui/main/drawer/buy_anypay/create_order/view_item/transaction_bill/transaction_bill_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../../res/app_images.dart';
import '../../../../../../../../res/app_styles.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';

class TransactionBillPage extends GetView<TransactionBillLogic> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: TransactionBillLogic(context: context),
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
                                    .textOperationCompleted,
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
                            height: 20,
                          ),
                          Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 15, right: 15),
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
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .textBankCode,
                                            style: AppStyles.r6C8AA1_13_400,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            controller
                                                .buyAnyPayCreateModel.bankCode,
                                            style: AppStyles.r00A5B1_13_500
                                                .copyWith(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text: controller
                                                .buyAnyPayCreateModel
                                                .bankCode));
                                        Common.showToastCenter(
                                            AppLocalizations.of(context)!
                                                .textCopySuccess);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(19),
                                            color: Color(0xFF14E4A5)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 9, bottom: 9),
                                          child: Row(children: [
                                            SizedBox(
                                              width: 17,
                                            ),
                                            SvgPicture.asset(
                                                AppImages.icDocument),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .textCopy,
                                              style: AppStyles.r5,
                                            ),
                                            SizedBox(
                                              width: 18,
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 19,
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
                              isColor: true),
                          DottedLine(
                            dashColor: Color(0xFFE3EAF2),
                            dashGapLength: 3,
                            dashLength: 4,
                          ),
                          _itemInfor(
                              title:
                                  AppLocalizations.of(context)!.textDateAndHour,
                              content: controller.getCreationDate(controller
                                  .buyAnyPayCreateModel.transactionDate),
                              isColor: false)
                        ]),
                  ),
                  SizedBox(
                    width: width,
                    child: bottomButton(
                      text: AppLocalizations.of(context)!.textIrAlHome,
                      onTap: () {
                        Get.back();
                      },
                    ),
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
