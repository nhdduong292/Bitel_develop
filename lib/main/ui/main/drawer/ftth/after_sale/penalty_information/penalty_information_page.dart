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

class PenaltyInformationPage extends GetView<PenaltyInformationLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: PenaltyInformationLogic(context: context),
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
                  child: Text(
                      AppLocalizations.of(context)!.textPenaltyInformation,
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
                                        text: 'S/${controller.balance} ',
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
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                  width: 1, color: AppColors.colorLineDash),
                              boxShadow: [
                                const BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 2,
                                  color: AppColors.colorLineDash,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 2),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .textTypeOfService,
                                            style: AppStyles.r6C8AA1_13_400,
                                          ),
                                        ),
                                        Text(
                                          controller
                                              .findAccountModel.typeOfService,
                                          style: AppStyles.rText1_13_500,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .textServiceNumber,
                                            style: AppStyles.r6C8AA1_13_400,
                                          ),
                                        ),
                                        Text(
                                          controller
                                              .findAccountModel.serviceNumber
                                              .toString(),
                                          style: AppStyles.rText1_13_500,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 22),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .textIDType,
                                            style: AppStyles.r6C8AA1_13_400,
                                          ),
                                        ),
                                        Text(
                                          Common.getIdentityType(controller
                                              .findAccountModel.idType),
                                          style: AppStyles.rText1_13_500,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .textName,
                                            style: AppStyles.r6C8AA1_13_400,
                                          ),
                                        ),
                                        Text(
                                          controller.findAccountModel.name,
                                          style: AppStyles.rText1_13_500,
                                        )
                                      ],
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 2),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .textPlan,
                                              style: AppStyles.r6C8AA1_13_400,
                                            ),
                                          ),
                                          Text(
                                            controller.findAccountModel.plan,
                                            style: AppStyles.rText1_13_500,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 4),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .textStatus,
                                              style: AppStyles.r6C8AA1_13_400,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8, bottom: 2),
                                            decoration: BoxDecoration(
                                              color: AppColors.colorBackground3,
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                            ),
                                            child: Text(
                                              'Active',
                                              style: AppStyles.rText1_13_500
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 22),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .textIDNumber,
                                              style: AppStyles.r6C8AA1_13_400,
                                            ),
                                          ),
                                          Text(
                                            controller
                                                .findAccountModel.idNumber,
                                            style: AppStyles.rText1_13_500,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              "",
                                              style: AppStyles.r6C8AA1_13_400,
                                            ),
                                          ),
                                          Text(
                                            "",
                                            style: AppStyles.rText1_13_500,
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(color: const Color(0xFFE3EAF2)),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0xFFE3EAF2), blurRadius: 3)
                                ]),
                            child: Column(
                              children: [
                                _paymentElement(
                                    AppLocalizations.of(context)!
                                        .textTotalAmount,
                                    'S/.${controller.cancelServiceModel.totalPenalty}',
                                    const Color(0xFF9454C9)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    bottomButton(
                        text: AppLocalizations.of(context)!.textContinue,
                        onTap: () {
                          controller.checkBalance((value) {
                            if (value) {
                              Get.toNamed(RouteConfig.cancelServicePDF,
                                  arguments: [
                                    controller.cancelServiceModel.cancelOrderId
                                  ]);
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
