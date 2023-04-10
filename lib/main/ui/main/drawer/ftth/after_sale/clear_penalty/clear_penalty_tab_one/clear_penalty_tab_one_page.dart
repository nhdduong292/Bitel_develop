// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ;
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../../res/app_images.dart';
import '../../../../../../../../res/app_styles.dart';
import '../../../../../../../utils/common_widgets.dart';
import 'clear_penalty_tab_one_logic.dart';

class ClearPenaltyTabOnePage extends GetView<ClearPenaltyTabOneLogic> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: ClearPenaltyTabOneLogic(context: context),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  itemDetailService(
                      context: context,
                      model: controller.detailServiceModel,
                      check: controller.isSelect,
                      onChange: (value) {
                        if (value) {
                          controller.totalService =
                              controller.detailServiceModel.receiptNumber;
                        } else {
                          controller.totalService = 0.0;
                        }
                        controller.isActiveButton = value;
                        controller.update();
                      }),
                  SizedBox(
                    height: 19,
                  ),
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
                            text: AppLocalizations.of(context)!.textTotalAmout,
                            style: AppStyles.r2B3A4A_12_500.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w400),
                            children: [
                              TextSpan(
                                text: ' S/${controller.totalService}',
                                style: AppStyles.r9454C9_14_500.copyWith(
                                    fontSize: 13, fontWeight: FontWeight.w700),
                              )
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textContinue,
                        onTap: () {
                          if (!controller.isActiveButton) {
                            return;
                          }
                          if (controller.isEnoughPayment()) {
                            controller.clearDebtLogic.isTabTwo.value = true;
                            controller.clearDebtLogic.isTabOne.value = false;
                            controller.clearDebtLogic.nextPage(1);
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NoticeDialog(
                                  height: 292,
                                  onCancel: () {
                                    Get.back();
                                  },
                                  onContinue: () {
                                    Get.back();
                                  },
                                );
                              },
                            );
                          }
                        },
                        color: controller.isActiveButton
                            ? null
                            : const Color(0xFF415263).withOpacity(0.2)),
                  ),
                ]),
          );
        });
  }

  Widget itemDetailService(
      {required BuildContext context,
      required DetailServiceModel model,
      required var check,
      required var onChange}) {
    return Container(
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
      child: expandableV1(
          context: context,
          model: model,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 27),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                AppLocalizations.of(context)!.textIDType,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                              Text(
                                model.idType,
                                style: AppStyles.r2B3A4A_12_500
                                    .copyWith(fontSize: 13),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                AppLocalizations.of(context)!.textIDNumber,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                              Text(model.idNumber,
                                  style: AppStyles.r2B3A4A_12_500
                                      .copyWith(fontSize: 13)),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                AppLocalizations.of(context)!.textName,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                              Text(model.name,
                                  style: AppStyles.r2B3A4A_12_500
                                      .copyWith(fontSize: 13)),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                AppLocalizations.of(context)!.textCondition,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF02CA34),
                                    borderRadius: BorderRadius.circular(9)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 9, right: 9, top: 2, bottom: 2),
                                  child: Text(
                                    model.condition,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    Expanded(flex: 1, child: Container())
                  ],
                ),
              ),
              SizedBox(
                height: 25,
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
                margin: EdgeInsets.only(left: 16, right: 17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFFE3EAF2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(185, 212, 220, 0.2),
                      offset: Offset(0, 2),
                      blurRadius: 7,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: InkWell(
                  onTap: () {
                    check.value = !check.value;
                    onChange(check.value);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 9, bottom: 12),
                    child: Row(children: [
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(left: 14, right: 15),
                          child: check.value ? iconChecked() : iconUnchecked(),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.textReceiptNumber,
                            style: AppStyles.r6C8AA1_13_400,
                          ),
                          Text(
                            'S/ ${model.receiptNumber}',
                            style:
                                AppStyles.r9454C9_14_500.copyWith(fontSize: 17),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 28,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model.bankNumber,
                              style: AppStyles.r2B3A4A_12_500
                                  .copyWith(fontSize: 13)),
                          RichText(
                              text: TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.textVence} ',
                                  style: AppStyles.r6C8AA1_13_400,
                                  children: [
                                TextSpan(
                                    text: model.vence,
                                    style: AppStyles.r2B3A4A_12_500
                                        .copyWith(fontSize: 13))
                              ]))
                        ],
                      ),
                    ]),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget expandableV1(
      {required BuildContext context,
      required Widget child,
      required DetailServiceModel model}) {
    return ExpandableNotifier(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expandable(
            theme: ExpandableThemeData(hasIcon: false),
            collapsed: ExpandableButton(
              child: Container(
                  height: 135,
                  margin: EdgeInsets.only(left: 7, right: 7, top: 7),
                  decoration: BoxDecoration(
                    color: Color(0xFFF0FAFA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .textTypeOfService,
                                      style: AppStyles.r6C8AA1_13_400),
                                  Text(model.type,
                                      style: AppStyles.r2B3A4A_12_500
                                          .copyWith(fontSize: 13)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(AppLocalizations.of(context)!.textNumber,
                                      style: AppStyles.r6C8AA1_13_400),
                                  Text(model.number,
                                      style: AppStyles.r2B3A4A_12_500
                                          .copyWith(fontSize: 13)),
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(AppLocalizations.of(context)!.textPlan,
                                      style: AppStyles.r6C8AA1_13_400),
                                  Text(model.plan,
                                      style: AppStyles.r2B3A4A_12_500
                                          .copyWith(fontSize: 13)),
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 50,
                              ),
                            ))
                      ],
                    ),
                  )),
            ),
            expanded: Column(
              children: [
                ExpandableButton(
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Container(
                        height: 135,
                        margin: EdgeInsets.only(left: 7, right: 7, top: 7),
                        decoration: BoxDecoration(
                          color: Color(0xFFF0FAFA),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .textTypeOfService,
                                            style: AppStyles.r6C8AA1_13_400),
                                        Text(model.type,
                                            style: AppStyles.r2B3A4A_12_500
                                                .copyWith(fontSize: 13)),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .textNumber,
                                            style: AppStyles.r6C8AA1_13_400),
                                        Text(model.number,
                                            style: AppStyles.r2B3A4A_12_500
                                                .copyWith(fontSize: 13)),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .textPlan,
                                            style: AppStyles.r6C8AA1_13_400),
                                        Text(model.plan,
                                            style: AppStyles.r2B3A4A_12_500
                                                .copyWith(fontSize: 13)),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 50,
                                    ),
                                  ))
                            ],
                          ),
                        )),
                    child
                  ]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}

class NoticeDialog extends Dialog {
  final double height;
  Function onCancel;
  Function onContinue;

  NoticeDialog(
      {super.key,
      required this.height,
      required this.onCancel,
      required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: 330,
        height: height,
        child: Column(
          children: [
            SizedBox(
              height: 22,
            ),
            SvgPicture.asset(AppImages.imgNotify),
            SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.textNotice,
              style: AppStyles.r16,
            ),
            SizedBox(
              height: 16,
            ),
            const DottedLine(
              dashColor: Color(0xFFE3EAF2),
              dashGapLength: 3,
              dashLength: 4,
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                AppLocalizations.of(context)!.textYouDontHaveEnoughAnypayIn,
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: bottomButtonV2(
                        text: AppLocalizations.of(context)!.textCancel,
                        onTap: () {
                          onCancel();
                        })),
                Expanded(
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textRecharge,
                        onTap: () {
                          onContinue();
                        }))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
