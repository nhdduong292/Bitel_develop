import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/product_payment_method_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/penalty_information/penalty_infromation_logic.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../../res/app_colors.dart';
import '../../../../../../../res/app_images.dart';
import '../../../../../../../res/app_styles.dart';
import '../../../../../../router/route_config.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';
import 'bill_transfer_service_logic.dart';

class BillTransferServicePage extends GetView<BillTransferServiceLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: BillTransferServiceLogic(context: context),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 18, bottom: 18, top: 2),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: SvgPicture.asset(AppImages.icBack),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
                elevation: 0.0,
                title: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(AppLocalizations.of(context)!.textTransferService,
                      style: AppStyles.title),
                ),
                toolbarHeight: 100,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      color: AppColors.colorBackground,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(width / 2, 20),
                          bottomRight: Radius.elliptical(width / 2, 20))),
                ),
              ),
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
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
                                  child: RichText(
                                    text: TextSpan(
                                        text:
                                            'S/${Common.numberFormat(controller.balance)} ',
                                        style: AppStyles.r9454C9_14_500
                                            .copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .textAnyPayBalanceRemain,
                                            style: AppStyles.r1.copyWith(
                                                fontWeight: FontWeight.w400),
                                          )
                                        ]),
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
                              AppLocalizations.of(context)!
                                  .textCurrentInstallationAddress,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Barlow',
                                  fontSize: 14),
                            ),
                          ),
                          addressBox(
                              content: controller.billTransferServiceModel
                                  .getInstalAddressOld()),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .textNewInstallationAddress,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Barlow',
                                  fontSize: 14),
                            ),
                          ),
                          addressBox(
                              content: controller.billTransferServiceModel
                                  .getInstalAddressNew()),
                          const SizedBox(
                            height: 4,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const DottedLine(
                            dashColor: Color(0xFFE3EAF2),
                            dashGapLength: 3,
                            dashLength: 4,
                          ),
                          SizedBox(
                            height: 8,
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
                          _paymentElement(
                              AppLocalizations.of(context)!.textTransferFee,
                              'S/${Common.numberFormat(controller.billTransferServiceModel.transferFee)}',
                              const Color(0xFF9454C9)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    bottomButton(
                        text: AppLocalizations.of(context)!.textContinue,
                        onTap: () {
                          Get.toNamed(RouteConfig.pdfTransferService);
                        }),
                  ],
                ),
              ));
        });
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

Widget addressBox({required String content}) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: Container(
        height: 45,
        padding: const EdgeInsets.only(left: 18, right: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE3EAF2), width: 1)),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  content,
                  style: AppStyles.r2B3A4A_12_500.copyWith(
                      fontSize: 14,
                      color: AppColors.color_2B3A4A.withOpacity(0.85)),
                ),
              ),
            ),
          ],
        )),
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
