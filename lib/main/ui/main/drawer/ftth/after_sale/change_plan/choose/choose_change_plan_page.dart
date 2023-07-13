import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/method_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/receipt_information_page.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../../res/app_images.dart';
import '../../../../../../../../res/app_styles.dart';
import '../../../../../../../networks/model/plan_ott_model.dart';
import '../../../../../../../networks/model/product_model.dart';
import '../../../../../../../networks/model/promotion_model.dart';
import '../../../../../../../networks/model/sub_ott_model.dart';
import '../../../../../../../router/route_config.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';
import 'choose_change_plan_logic.dart';

class ChooseChangePlanPage extends GetView {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: ChooseChangePlanLogic(context: context),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                color: Colors.white,
                child: Column(
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
                        child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .textCurrentPlan,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Barlow',
                                        fontSize: 16),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.all(15),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: const Color(0xFFE3EAF2)),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xFFE3EAF2),
                                            blurRadius: 3)
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
                                              controller
                                                      .productChangePlanModel
                                                      .currentPlan
                                                      .productName ??
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
                                                      color:
                                                          AppColors.colorText1,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  '${controller.productChangePlanModel.currentPlan.speed ?? '---'} Mpbs ',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          '${Common.numberFormat(controller.productChangePlanModel.currentPlan.defaultValue)}/${AppLocalizations.of(context)!.textMonth}',
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
                                        fontSize: 16),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: const Color(0xFFE3EAF2)),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xFFE3EAF2),
                                            blurRadius: 3)
                                      ]),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListView.separated(
                                          padding:
                                              const EdgeInsets.only(top: 0),
                                          shrinkWrap: true,
                                          primary: false,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              _itemProduct(
                                                  context: context,
                                                  groupValue:
                                                      controller.valueProduct,
                                                  product: controller
                                                      .productChangePlanModel
                                                      .newPlan[index],
                                                  value: index,
                                                  onChange: (value) {
                                                    controller.valueProduct
                                                        .value = value;

                                                    controller.resetPlanOTTs();
                                                    controller
                                                        .resetPromotions();
                                                    if (value > -1) {
                                                      controller.isLoadingOTT =
                                                          true;
                                                      controller
                                                              .isLoadingPromotion =
                                                          true;
                                                      controller.checkLoading();
                                                      controller
                                                          .getPromotions();
                                                      controller
                                                          .getOTTService();
                                                    }
                                                    controller.update();
                                                  }),
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const Divider(
                                                    color:
                                                        AppColors.colorLineDash,
                                                    height: 1,
                                                    thickness: 1,
                                                  ),
                                          itemCount: controller
                                              .productChangePlanModel
                                              .newPlan
                                              .length)
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.valueProduct.value > -1,
                                    child: Container(
                                      constraints:
                                          const BoxConstraints(minHeight: 100),
                                      padding: const EdgeInsets.only(top: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: const Color(0xFFE3EAF2)),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color(0xFFE3EAF2),
                                                blurRadius: 3)
                                          ]),
                                      child: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .textChoosePromotion,
                                            style: const TextStyle(
                                                color: AppColors.colorContent,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Barlow'),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const DottedLine(
                                            dashColor: Color(0xFFE3EAF2),
                                            dashGapLength: 3,
                                            dashLength: 4,
                                          ),
                                          ListView.separated(
                                              padding:
                                                  const EdgeInsets.only(top: 0),
                                              shrinkWrap: true,
                                              primary: false,
                                              itemBuilder: (BuildContext
                                                          context,
                                                      int index) =>
                                                  _itemPromotion(
                                                    context: context,
                                                    promotion: controller
                                                        .listPromotion[index],
                                                  ),
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      const Divider(
                                                        color: AppColors
                                                            .colorLineDash,
                                                        height: 1,
                                                        thickness: 1,
                                                      ),
                                              itemCount: controller
                                                  .listPromotion.length)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: const Color(0xFFE3EAF2)),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xFFE3EAF2),
                                            blurRadius: 3)
                                      ]),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .textTypecontract,
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                            color: AppColors.colorContent,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Barlow'),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const DottedLine(
                                        dashColor: Color(0xFFE3EAF2),
                                        dashGapLength: 3,
                                        dashLength: 4,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: typeContact(
                                                    check: controller
                                                        .isUndetermined(
                                                            ContractType
                                                                .UNDETERMINED),
                                                    content:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .textUndetermined)),
                                            Expanded(
                                                child: typeContact(
                                                    check: controller
                                                        .isUndetermined(
                                                            ContractType
                                                                .FORCED_TERM),
                                                    content:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .textForcedTerm))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.valueProduct.value > -1,
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: const Color(0xFFE3EAF2)),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color(0xFFE3EAF2),
                                                blurRadius: 3)
                                          ]),
                                      child: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .textOTTService,
                                            style: const TextStyle(
                                                color: AppColors.colorContent,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Barlow'),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const DottedLine(
                                            dashColor: Color(0xFFE3EAF2),
                                            dashGapLength: 3,
                                            dashLength: 4,
                                          ),
                                          controller.listPlanOTT.isNotEmpty
                                              ? ListView.separated(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0),
                                                  shrinkWrap: true,
                                                  primary: false,
                                                  itemBuilder: (BuildContext
                                                              context,
                                                          int index) =>
                                                      controller
                                                                  .listPlanOTT[
                                                                      index]
                                                                  .ottService !=
                                                              OTTService
                                                                  .CABLE_GO
                                                          ? _itemOTT(
                                                              context: context,
                                                              ott: controller
                                                                      .listPlanOTT[
                                                                  index],
                                                              value: index,
                                                              listValue: controller
                                                                  .listSelectOtt,
                                                              onChange:
                                                                  (value) {
                                                                if (controller
                                                                    .listSelectOtt
                                                                    .contains(
                                                                        value)) {
                                                                  controller
                                                                      .listSelectOtt
                                                                      .removeWhere((element) =>
                                                                          element ==
                                                                          value);
                                                                } else {
                                                                  controller
                                                                      .listSelectOtt
                                                                      .add(
                                                                          value);
                                                                }
                                                                controller
                                                                    .update();
                                                              },
                                                              controller:
                                                                  controller,
                                                            )
                                                          : _itemOTTCableGo(
                                                              context: context,
                                                              ott: controller
                                                                      .listPlanOTT[
                                                                  index],
                                                              value: index,
                                                              listValue: controller
                                                                  .listSelectOtt,
                                                              onChange:
                                                                  (value) {
                                                                if (controller
                                                                    .listSelectOtt
                                                                    .contains(
                                                                        value)) {
                                                                  controller
                                                                      .listSelectOtt
                                                                      .removeWhere((element) =>
                                                                          element ==
                                                                          value);
                                                                } else {
                                                                  controller
                                                                      .listSelectOtt
                                                                      .add(
                                                                          value);
                                                                }
                                                                controller
                                                                    .update();
                                                              },
                                                              controller:
                                                                  controller,
                                                            ),
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                              int index) =>
                                                          const Divider(
                                                            color: AppColors
                                                                .colorLineDash,
                                                            height: 1,
                                                            thickness: 1,
                                                          ),
                                                  itemCount: controller
                                                      .listPlanOTT.length)
                                              : Column(children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .textNoOTTService,
                                                      style: AppStyles
                                                          .r2B3A4A_12_500
                                                          .copyWith(
                                                              fontSize: 13))
                                                ])
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                bottomButton(
                                    text: AppLocalizations.of(context)!
                                        .textContinue,
                                    onTap: () {
                                      if (controller.checkValidate()) {
                                        for (int value
                                            in controller.listSelectOtt) {
                                          if (!controller.listPlanOTT[value]
                                                  .isSuccess &&
                                              controller.listPlanOTT[value]
                                                      .ottService !=
                                                  OTTService.CABLE_GO) {
                                            controller
                                                .listPlanOTT[value].focusNode!
                                                .requestFocus();
                                            return;
                                          } else if (controller
                                                  .listPlanOTT[value]
                                                  .ottService ==
                                              OTTService.CABLE_GO) {
                                            if (controller.valueCableGo.value >
                                                -1) {
                                              if (!controller
                                                  .listPlanOTT[value]
                                                  .listSubOtt[controller
                                                      .valueCableGo.value]
                                                  .isSuccess) {
                                                controller
                                                    .listPlanOTT[value]
                                                    .listSubOtt[controller
                                                        .valueCableGo.value]
                                                    .focusNode!
                                                    .requestFocus();
                                                return;
                                              }
                                            }
                                          }
                                        }
                                        controller
                                            .checkEmailCableGo((isSuccess) {
                                          if (isSuccess) {
                                            controller.getPayment((isSuccess) {
                                              if (isSuccess) {
                                                Get.toNamed(RouteConfig
                                                    .inforChangePlan);
                                              }
                                            });
                                          }
                                        });
                                      }
                                    },
                                    color: !controller.checkValidate()
                                        ? const Color(0xFF415263)
                                            .withOpacity(0.2)
                                        : null),
                                const SizedBox(
                                  height: 30,
                                )
                              ]),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _itemProduct(
      {required BuildContext context,
      required int value,
      required ProductModel product,
      required RxInt groupValue,
      required var onChange}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: InkWell(
        splashColor: Colors.red,
        onTap: () {
          groupValue.value != value ? onChange(value) : onChange(-1);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Obx(() =>
                groupValue.value == value ? iconChecked() : iconUnchecked()),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.productName ?? 'null',
                      style: AppStyles.r2B3A4A_12_500),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.textSpeed} ${product.speed} Mpbs',
                    style: AppStyles.r6C8AA1_13_400
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.colorSubContent.withOpacity(0.07),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${Common.numberFormat(product.defaultValue)}/${AppLocalizations.of(context)!.textMonth}',
                style: AppStyles.r9454C9_14_500
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemOTT(
      {required BuildContext context,
      required PlanOttModel ott,
      required int value,
      required List<int> listValue,
      required var onChange,
      required ChooseChangePlanLogic controller}) {
    var check = listValue.contains(value).obs;
    if (ott.controller == null) {
      ott.controller = ExpandableController();
      ott.controller!.addListener(() {
        // if (ott.controller!.expanded) {
        //   groupValue.value != value ? onChange(value) : onChange(-1);
        // } else {
        //   groupValue.value != value ? onChange(value) : onChange(-1);
        // }
        onChange(value);
      });
    }
    ott.textController ??= TextEditingController();
    ott.focusNode ??= FocusNode();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: ExpandableNotifier(
        child: Column(
          children: [
            ExpandablePanel(
              controller: ott.controller,
              theme: const ExpandableThemeData(hasIcon: false),
              expanded: ExpandableButton(
                child: Row(
                  children: [
                    Obx(() => check.value
                        ? const Icon(
                            Icons.check_box,
                            color: AppColors.colorSubContent,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank,
                            color: AppColors.colorSubContent,
                          )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(ott.ottName,
                          style:
                              AppStyles.r2B3A4A_12_500.copyWith(fontSize: 13)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.colorSubContent.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${Common.numberFormat(ott.listSubOtt[0].fee)}/${AppLocalizations.of(context)!.textMonth}',
                        style: AppStyles.r9454C9_14_500.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              collapsed: Column(
                children: [
                  ExpandableButton(
                    child: Row(
                      children: [
                        Obx(() => check.value
                            ? const Icon(
                                Icons.check_box,
                                color: AppColors.colorSubContent,
                              )
                            : const Icon(
                                Icons.check_box_outline_blank,
                                color: AppColors.colorSubContent,
                              )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(ott.ottName,
                              style: AppStyles.r2B3A4A_12_500
                                  .copyWith(fontSize: 13)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.colorSubContent.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${Common.numberFormat(ott.listSubOtt[0].fee)}/${AppLocalizations.of(context)!.textMonth}',
                            style: AppStyles.r9454C9_14_500.copyWith(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFFF0FAFA),
                          boxShadow: const [
                            BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                                AppLocalizations.of(context)!.textPhoneNumber,
                                textAlign: TextAlign.left,
                                style: AppStyles.r2B3A4A_12_500.copyWith(
                                    fontSize: 13,
                                    color: const Color(0xFF6C8AA1))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 12, bottom: 17),
                            child: SizedBox(
                              height: 65,
                              child: TextField(
                                  controller: ott.textController,
                                  maxLength: 9,
                                  keyboardType: TextInputType.phone,
                                  focusNode: ott.focusNode,
                                  style: AppStyles.r2B3A4A_12_500.copyWith(
                                      fontSize: 14,
                                      color: AppColors.color_2B3A4A
                                          .withOpacity(0.85)),
                                  onChanged: (value) {
                                    controller.onChangePhoneNumber(
                                        ott.ottService, value, ott);
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    errorText: ott.errorText,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.only(
                                        top: 5, left: 18, right: 10),
                                    hintText: AppLocalizations.of(context)!
                                        .textEnterBitelPhoneNumber,
                                    hintStyle: AppStyles.r2.copyWith(
                                        color: AppColors.colorHint1,
                                        fontWeight: FontWeight.w400),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColors.colorLineDash)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.redAccent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColors.colorLineDash)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColors.colorLineDash)),
                                  )),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemOTTCableGo(
      {required BuildContext context,
      required PlanOttModel ott,
      required int value,
      required List<int> listValue,
      required var onChange,
      required ChooseChangePlanLogic controller}) {
    var check = listValue.contains(value).obs;
    if (ott.controller == null) {
      ott.controller = ExpandableController();
      ott.controller!.addListener(() {
        onChange(value);
      });
    }
    ott.textController ??= TextEditingController();
    ott.focusNode ??= FocusNode();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: ExpandableNotifier(
        child: Column(
          children: [
            ExpandablePanel(
              controller: ott.controller,
              theme: const ExpandableThemeData(hasIcon: false),
              expanded: ExpandableButton(
                child: Row(
                  children: [
                    Obx(() => check.value
                        ? const Icon(
                            Icons.check_box,
                            color: AppColors.colorSubContent,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank,
                            color: AppColors.colorSubContent,
                          )),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(ott.ottName,
                            style: AppStyles.r2B3A4A_12_500
                                .copyWith(fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ),
              collapsed: Column(
                children: [
                  ExpandableButton(
                    child: Row(
                      children: [
                        Obx(() => check.value
                            ? const Icon(
                                Icons.check_box,
                                color: AppColors.colorSubContent,
                              )
                            : const Icon(
                                Icons.check_box_outline_blank,
                                // color: Colors.white,
                                color: AppColors.colorSubContent,
                              )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(ott.ottName,
                              style: AppStyles.r2B3A4A_12_500
                                  .copyWith(fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListView.separated(
                      padding: const EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) =>
                          _itemCableGo(
                            context: context,
                            model: ott.listSubOtt[index],
                            value: index,
                            groupValue: controller.valueCableGo,
                            onChange: (value) {
                              // controller.update();
                              for (var item in ott.listSubOtt) {
                                final index = ott.listSubOtt.indexOf(item);
                                if (index != value) {
                                  item.controller!.expanded = false;
                                }
                              }
                            },
                            controller: controller,
                          ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                            color: AppColors.colorLineDash,
                            height: 1,
                            thickness: 1,
                          ),
                      itemCount: ott.listSubOtt.length)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemCableGo(
      {required BuildContext context,
      required SubOTTModel model,
      required int value,
      required var groupValue,
      required var onChange,
      required ChooseChangePlanLogic controller}) {
    if (model.controller == null) {
      model.controller = ExpandableController();
      model.controller!.addListener(() {
        if (model.controller!.expanded) {
          onChange(value);
        }
        groupValue.value != value
            ? controller.valueCableGo.value = value
            : controller.valueCableGo.value = -1;
      });
    }
    model.textController ??= TextEditingController();
    model.focusNode ??= FocusNode();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: ExpandableNotifier(
        child: Column(
          children: [
            ExpandablePanel(
              controller: model.controller,
              theme: const ExpandableThemeData(hasIcon: false),
              collapsed: ExpandableButton(
                child: Row(
                  children: [
                    Obx(() => groupValue.value == value
                        ? iconChecked()
                        : iconUnchecked()),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 10),
                        child: Text(model.description,
                            style: AppStyles.r2B3A4A_12_500
                                .copyWith(fontSize: 13)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.colorSubContent.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${Common.numberFormat(model.fee)}/${AppLocalizations.of(context)!.textMonth}',
                        style: AppStyles.r9454C9_14_500.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              expanded: Column(
                children: [
                  ExpandableButton(
                    child: Row(
                      children: [
                        Obx(() => groupValue.value == value
                            ? iconChecked()
                            : iconUnchecked()),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 10),
                            child: Text(model.description,
                                style: AppStyles.r2B3A4A_12_500
                                    .copyWith(fontSize: 13)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.colorSubContent.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${Common.numberFormat(model.fee)}/${AppLocalizations.of(context)!.textMonth}',
                            style: AppStyles.r9454C9_14_500.copyWith(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFFF0FAFA),
                          boxShadow: const [
                            BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Text(AppLocalizations.of(context)!.textEmail,
                                textAlign: TextAlign.left,
                                style: AppStyles.r2B3A4A_12_500.copyWith(
                                    fontSize: 13,
                                    color: const Color(0xFF6C8AA1))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 12, bottom: 17),
                            child: SizedBox(
                              height: 65,
                              child: TextField(
                                  controller: model.textController,
                                  keyboardType: TextInputType.text,
                                  focusNode: model.focusNode,
                                  style: AppStyles.r2B3A4A_12_500.copyWith(
                                      fontSize: 14,
                                      color: AppColors.color_2B3A4A
                                          .withOpacity(0.85)),
                                  onChanged: (value) {
                                    controller.onChangeEmail(value, model);
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    errorText: model.errorText,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.only(
                                        top: 5, left: 18, right: 10),
                                    hintText: AppLocalizations.of(context)!
                                        .textEnterEmail,
                                    hintStyle: AppStyles.r2.copyWith(
                                        color: AppColors.colorHint1,
                                        fontWeight: FontWeight.w400),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColors.colorLineDash)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.redAccent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColors.colorLineDash)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColors.colorLineDash)),
                                  )),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemPromotion(
      {required BuildContext context, required PromotionModel promotion}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            iconChecked(),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 1,
              child: Text(promotion.name ?? 'null',
                  style: AppStyles.r2B3A4A_12_500.copyWith(fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}
