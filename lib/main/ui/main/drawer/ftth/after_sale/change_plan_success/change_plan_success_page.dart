// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../../res/app_images.dart';
import '../../../../../../../res/app_styles.dart';
import '../../../../../../router/route_config.dart';
import '../../../../../../utils/common.dart';
import 'change_plan_success_logic.dart';

class ChangePlanSuccessPage extends GetView {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: ChangePlanSuccessLogic(context: context),
        builder: (controller) {
          return Scaffold(
            body: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8FBFB),
                      ),
                      width: width,
                      height: 200,
                      child: SvgPicture.asset(
                        AppImages.bgFtthContracting,
                        fit: BoxFit.fill,
                        width: width,
                      ),
                    ),
                    Positioned(
                        top: 46,
                        child: SizedBox(
                          width: width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.icSuccessFtthContracting),
                              Text(
                                AppLocalizations.of(context)!
                                    .textCongratulation,
                                style: AppStyles.b00A5B1_20_500,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .textSuccessfulTerminationOfContract,
                                style: AppStyles.r007689_14_500,
                              )
                            ],
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            inforContractRow(
                                lable: AppLocalizations.of(context)!
                                    .textOperationCode,
                                richText: () {
                                  return Text(
                                    controller.model.operationCode,
                                    style: AppStyles.rF76F5A_13_500,
                                  );
                                }),
                            DottedLine(
                              dashColor: Color(0xFFE3EAF2),
                              dashGapLength: 3,
                              dashLength: 4,
                            ),
                            // inforContractRow(
                            //     lable:
                            //         "${AppLocalizations.of(context)!.textAccount}:",
                            //     richText: () {
                            //       return Text(
                            //         controller.model.account,
                            //         style: AppStyles.r415263_13_500,
                            //       );
                            //     }),
                            // DottedLine(
                            //   dashColor: Color(0xFFE3EAF2),
                            //   dashGapLength: 3,
                            //   dashLength: 4,
                            // ),
                            inforContractRow(
                                lable:
                                    AppLocalizations.of(context)!.textCustomer,
                                richText: () {
                                  return Text(
                                    controller.model.customer.fullName,
                                    style: AppStyles.r415263_13_500,
                                  );
                                }),
                            DottedLine(
                              dashColor: Color(0xFFE3EAF2),
                              dashGapLength: 3,
                              dashLength: 4,
                            ),
                            inforContractRow(
                                lable: AppLocalizations.of(context)!
                                    .textDocIdentity,
                                richText: () {
                                  return Text(
                                    '${controller.model.customer.type}-${controller.model.customer.idNumber}',
                                    style: AppStyles.r415263_13_500,
                                  );
                                }),
                            DottedLine(
                              dashColor: Color(0xFFE3EAF2),
                              dashGapLength: 3,
                              dashLength: 4,
                            ),
                            inforContractRow(
                                lable:
                                    "${AppLocalizations.of(context)!.textPhoneNumber}:",
                                richText: () {
                                  return Text(
                                    controller.model.customer.telFax,
                                    style: AppStyles.r415263_13_500,
                                  );
                                }),
                            DottedLine(
                              dashColor: Color(0xFFE3EAF2),
                              dashGapLength: 3,
                              dashLength: 4,
                            ),
                            inforContractRow(
                                lable:
                                    "${AppLocalizations.of(context)!.textCurrentPlan}:",
                                richText: () {
                                  return Text(
                                    controller.model.currentPlan.productName ??
                                        "---",
                                    style: AppStyles.r415263_13_500,
                                  );
                                }),
                            DottedLine(
                              dashColor: Color(0xFFE3EAF2),
                              dashGapLength: 3,
                              dashLength: 4,
                            ),
                            inforContractRow(
                                lable:
                                    "${AppLocalizations.of(context)!.textNewPlan}:",
                                richText: () {
                                  return RichText(
                                      text: TextSpan(
                                    text:
                                        controller.model.newPlan.productName ??
                                            "---",
                                    style: AppStyles.r415263_13_500,
                                  ));
                                }),
                            DottedLine(
                              dashColor: Color(0xFFE3EAF2),
                              dashGapLength: 3,
                              dashLength: 4,
                            ),
                            inforContractRow(
                                lable:
                                    "${AppLocalizations.of(context)!.textPromotion}:",
                                richText: () {
                                  return Text(
                                    '---',
                                    style: AppStyles.r415263_13_500,
                                  );
                                }),
                            DottedLine(
                              dashColor: Color(0xFFE3EAF2),
                              dashGapLength: 3,
                              dashLength: 4,
                            ),
                            inforContractRow(
                                lable:
                                    "${AppLocalizations.of(context)!.textBillCycle}:",
                                richText: () {
                                  return Text(
                                    controller.getTextBillCycle(),
                                    style: AppStyles.r415263_13_500,
                                  );
                                }),
                            DottedLine(
                              dashColor: Color(0xFFE3EAF2),
                              dashGapLength: 3,
                              dashLength: 4,
                            ),
                            inforContractRow(
                                lable:
                                    "${AppLocalizations.of(context)!.textDateOfRequest}:",
                                richText: () {
                                  return Text(
                                    controller.model.dateOfRequest != '---'
                                        ? Common.fromDate(
                                            DateTime.parse(
                                                controller.model.dateOfRequest),
                                            'dd/MM/yyyy')
                                        : '---',
                                    style: AppStyles.r415263_13_500,
                                  );
                                }),
                            DottedLine(
                              dashColor: Color(0xFFE3EAF2),
                              dashGapLength: 3,
                              dashLength: 4,
                            ),
                            inforContractRow(
                                lable:
                                    "${AppLocalizations.of(context)!.textStartOfNewPlan}:",
                                richText: () {
                                  return Text(
                                    controller.model.startOfNewPlan != '---'
                                        ? Common.fromDate(
                                            DateTime.parse(controller
                                                .model.startOfNewPlan),
                                            'dd/MM/yyyy')
                                        : '---',
                                    style: AppStyles.r415263_13_500,
                                  );
                                }),
                          ]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.textDocumentsWereSentTo,
                          style: AppStyles.r6C8AA1_13_400,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          controller.model.customer.email,
                          style: AppStyles.r00A5B1_13_500,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: width - 62,
                            margin: EdgeInsets.only(left: 31, right: 31),
                            child: bottomButton(
                                text: AppLocalizations.of(context)!
                                    .textClose
                                    .toUpperCase(),
                                onTap: () {
                                  Get.until(
                                    (route) {
                                      return Get.currentRoute ==
                                          RouteConfig.afterSale;
                                    },
                                  );
                                })),
                        SizedBox(
                          height: 20,
                        )
                      ]),
                )),
              ],
            ),
          );
        });
  }

  Widget inforContractRow({required String lable, required var richText}) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 14),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      lable,
                      style: AppStyles.r6C8AA1_13_400,
                    ))),
            Expanded(
                flex: 3,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: richText())))
          ],
        ),
      ),
    );
  }
}
