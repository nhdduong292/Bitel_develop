import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/method_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/receipt_information_page.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../../res/app_images.dart';
import '../../../../../../../../res/app_styles.dart';
import '../../../../../../../networks/model/product_model.dart';
import '../../../../../../../networks/model/request_detail_model.dart';
import '../../../../../../../router/route_config.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';
import '../../../../contracting/product/invoice_page.dart';
import 'infor_change_plan_logic.dart';

class InforChangePlanPage extends GetView {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: InforChangePlanLogic(context: context),
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
                      top: 50,
                      left: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.textChangePlan,
                              style: AppStyles.title),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 45,
                        left: 20,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
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
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0xFFE3EAF2)),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .textReceiptInformation,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Barlow',
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(26),
                                  dashPattern: const [2, 2],
                                  strokeWidth: 1,
                                  color: const Color(0xFF9454C9),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 12),
                                    child: Obx(
                                      () => RichText(
                                        text: TextSpan(
                                            text:
                                                'S/${Common.numberFormat(controller.balance.value)} ',
                                            style: AppStyles.r9454C9_14_500
                                                .copyWith(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w700),
                                            children: [
                                              TextSpan(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .textAnyPayBalanceRemain,
                                                style: AppStyles.r1.copyWith(
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                AppLocalizations.of(context)!.textCurrentPlan,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Barlow',
                                    fontSize: 14),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(15),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: const Color(0xFFE3EAF2)),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFFE3EAF2), blurRadius: 3)
                                  ]),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.currentPlan.productName ??
                                              'null',
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Barlow',
                                              color: AppColors.colorText1,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '${AppLocalizations.of(context)!.textSpeed}: ',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Barlow',
                                                  color: AppColors.colorText1,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              '${controller.currentPlan.speed ?? '---'} Mpbs',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Barlow',
                                                color: AppColors.colorText1,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.colorSubContent
                                          .withOpacity(0.07),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '${Common.numberFormat(controller.currentPlan.defaultValue)}/${AppLocalizations.of(context)!.textMonth}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Barlow',
                                          color: AppColors.colorText3,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                AppLocalizations.of(context)!.textNewPlan,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Barlow',
                                    fontSize: 14),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(15),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: const Color(0xFFE3EAF2)),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFFE3EAF2), blurRadius: 3)
                                  ]),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.newPlan.productName ??
                                              'null',
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Barlow',
                                              color: AppColors.colorText1,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '${AppLocalizations.of(context)!.textSpeed}: ',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Barlow',
                                                  color: AppColors.colorText1,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              '${controller.newPlan.speed ?? '---'} Mpbs',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Barlow',
                                                color: AppColors.colorText1,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.colorSubContent
                                          .withOpacity(0.07),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '${Common.numberFormat(controller.newPlan.defaultValue)}/${AppLocalizations.of(context)!.textMonth}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Barlow',
                                          color: AppColors.colorText3,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                AppLocalizations.of(context)!.textPayment,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Barlow',
                                    fontSize: 14),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: const Color(0xFFE3EAF2)),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFFE3EAF2), blurRadius: 3)
                                  ]),
                              child: Column(
                                children: [
                                  _paymentElement(
                                      AppLocalizations.of(context)!
                                          .textPrepaidMonth(controller
                                              .checkPaymentChangePlanModel
                                              .prepaidMonth),
                                      'S/${Common.numberFormat(controller.checkPaymentChangePlanModel.prepaidMoney)}',
                                      const Color(0xFF415263)),
                                  const DottedLine(
                                    dashColor: Color(0xFFE3EAF2),
                                    dashGapLength: 3,
                                    dashLength: 4,
                                  ),
                                  _paymentElement(
                                      AppLocalizations.of(context)!
                                          .textPaymentOfCurrentInvoie,
                                      'S/${Common.numberFormat(controller.checkPaymentChangePlanModel.paymentCurrentInvoice)}',
                                      const Color(0xFF415263)),
                                  const DottedLine(
                                    dashColor: Color(0xFFE3EAF2),
                                    dashGapLength: 3,
                                    dashLength: 4,
                                  ),
                                  _paymentElement(
                                      AppLocalizations.of(context)!
                                          .textDiscount,
                                      'S/${Common.numberFormat(controller.checkPaymentChangePlanModel.discount)}',
                                      const Color(0xFFD91C02)),
                                  const DottedLine(
                                    dashColor: Color(0xFFE3EAF2),
                                    dashGapLength: 3,
                                    dashLength: 4,
                                  ),
                                  _paymentElement(
                                      AppLocalizations.of(context)!
                                          .textTotalAmount,
                                      'S/${Common.numberFormat(controller.checkPaymentChangePlanModel.totalAmount)}',
                                      const Color(0xFF9454C9)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      bottomButton(
                          text: AppLocalizations.of(context)!.textContinue,
                          onTap: () {
                            controller.checkBalance((value) {
                              if (value) {
                                controller.getCustomer((isSuccess) {
                                  if (isSuccess) {
                                    Get.toNamed(RouteConfig.customerInformation,
                                        arguments: [
                                          controller.customerModel,
                                          RequestDetailModel(),
                                          0,
                                          0,
                                          controller.chooseChangePlanLogic
                                              .isForcedTerm,
                                          null,
                                          0,
                                          ContractStatus.Change_plan
                                        ]);
                                  }
                                });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return RechargeDialog(
                                        height: 340,
                                        onCanncel: () {},
                                        onContinue: () {
                                          Get.toNamed(RouteConfig.createOrder);
                                        },
                                      );
                                    });
                              }
                            });
                          }),
                    ],
                  ),
                )),
              ],
            ),
          );
        });
  }

  Widget _paymentElement(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
              child: Text(
            label,
            style: const TextStyle(
                fontFamily: 'Barlow',
                fontSize: 13,
                color: AppColors.colorText2),
          )),
          Text(
            value,
            style: TextStyle(
                fontFamily: 'Barlow',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: color),
          )
        ],
      ),
    );
  }
}
