import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/product_payment_method_logic.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';
import '../../../../../router/route_config.dart';
import '../../../../../utils/common_widgets.dart';

class InvoicePage extends GetView<ProductPaymentMethodLogic> {
  ProductPaymentMethodLogic controller;

  InvoicePage({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                                text: 'S/${controller.balance} ',
                                style: AppStyles.r9454C9_14_500.copyWith(
                                    fontSize: 13, fontWeight: FontWeight.w700),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .textAnyPayBalanceRemain,
                                    style: AppStyles.r1
                                        .copyWith(fontWeight: FontWeight.w400),
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
                    AppLocalizations.of(context)!.textProduct,
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
                      border: Border.all(color: const Color(0xFFE3EAF2)),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                      ]),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.billModel.product.productName ??
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
                                controller.billModel.speedNew != 0
                                    ? Text(
                                        '${controller.billModel.product.speed ?? '---'} Mpbs ',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Barlow',
                                          color: AppColors.colorText1,
                                          fontWeight: FontWeight.w400,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationStyle:
                                              TextDecorationStyle.solid,
                                        ),
                                      )
                                    : Text(
                                        '${controller.billModel.product.speed ?? '---'} Mpbs',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Barlow',
                                          color: AppColors.colorText1,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                Visibility(
                                  visible: controller.billModel.speedNew != 0,
                                  child: Text(
                                    '${controller.billModel.speedNew} Mpbs',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Barlow',
                                      color: AppColors.colorText1,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.colorSubContent.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${controller.billModel.product.defaultValue ?? 'null'} /month',
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
                      border: Border.all(color: const Color(0xFFE3EAF2)),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                      ]),
                  child: Column(
                    children: [
                      _paymentElement(
                          controller.billModel.paymentName,
                          'S/.${controller.billModel.fee}',
                          const Color(0xFF415263)),
                      const DottedLine(
                        dashColor: Color(0xFFE3EAF2),
                        dashGapLength: 3,
                        dashLength: 4,
                      ),
                      _paymentElement(
                          AppLocalizations.of(context)!.textInstallationFee,
                          'S/.${controller.billModel.installationFee}',
                          const Color(0xFF415263)),
                      const DottedLine(
                        dashColor: Color(0xFFE3EAF2),
                        dashGapLength: 3,
                        dashLength: 4,
                      ),
                      _paymentElement(
                          AppLocalizations.of(context)!.textDiscount,
                          'S/.${controller.billModel.discount}',
                          const Color(0xFFD91C02)),
                      const DottedLine(
                        dashColor: Color(0xFFE3EAF2),
                        dashGapLength: 3,
                        dashLength: 4,
                      ),
                      _paymentElement(
                          AppLocalizations.of(context)!.textTotalAmount,
                          'S/.${controller.billModel.total}',
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
                    controller.checkRegisterCustomer(context).then((value) {
                      if (value) {
                        Get.toNamed(RouteConfig.customerInformation,
                            arguments: [
                              controller.customer,
                              controller.requestModel,
                              controller.getProduct().productId,
                              controller.getPlanReason().id,
                              controller.isForcedTerm(),
                              controller.listIdPromotion,
                              controller.getPackage().packageId
                            ]);
                      } else {
                        Get.toNamed(RouteConfig.createContact, arguments: [
                          controller.requestModel,
                          controller.getProduct().productId,
                          controller.getPlanReason().id,
                          controller.isForcedTerm(),
                          controller.listIdPromotion,
                          controller.getPackage().packageId
                        ]);
                      }
                    });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return RechargeDialog(
                            height: 340,
                            onCanncel: () {
                              controller.isOnInvoicePage.value = false;
                              controller.isOnMethodPage.value = true;
                              controller.scrollController?.scrollTo(
                                index: 0,
                                duration: const Duration(milliseconds: 200),
                              );
                            },
                            onContinue: () {
                              Get.toNamed(RouteConfig.createOrder);
                            },
                          );
                        });
                  }
                });
              }),
        ],
      )),
    );
  }
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
              fontFamily: 'Barlow', fontSize: 13, color: AppColors.colorText2),
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

class RechargeDialog extends Dialog {
  final double height;
  Function onCanncel;
  Function onContinue;

  RechargeDialog(
      {super.key,
      required this.height,
      required this.onCanncel,
      required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Wrap(children: [
        Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            SvgPicture.asset(AppImages.imgNotify),
            const SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.textNotify,
              style: AppStyles.r16,
            ),
            const SizedBox(
              height: 16,
            ),
            const DottedLine(
              dashColor: AppColors.colorLineDash,
              dashGapLength: 3,
              dashLength: 4,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                AppLocalizations.of(context)!.contentRechargeDialog,
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: bottomButtonV2(
                        text: AppLocalizations.of(context)!.textCancel,
                        onTap: () {
                          Get.back();
                          onCanncel();
                        })),
                Expanded(
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textRecharge,
                        onTap: () {
                          Get.back();
                          onContinue();
                        }))
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ]),
    );
  }
}
