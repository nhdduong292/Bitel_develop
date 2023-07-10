// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bitel_ventas/main/networks/model/package_model.dart';
import 'package:bitel_ventas/main/networks/model/plan_ott_model.dart';
import 'package:bitel_ventas/main/networks/model/plan_reason_model.dart';
import 'package:bitel_ventas/main/networks/model/product_model.dart';
import 'package:bitel_ventas/main/networks/model/promotion_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/product_payment_method_logic.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import '../../../../../networks/model/sub_ott_model.dart';
import '../../../../../utils/common.dart';
import '../../../../../utils/common_widgets.dart';

class MethodPage extends GetView<ProductPaymentMethodLogic> {
  ProductPaymentMethodLogic controller;

  MethodPage({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _voiceContract(context: context, controller: controller),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                padding: const EdgeInsets.only(top: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: const Color(0xFFE3EAF2)),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.textSelectProduct,
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
                        padding: const EdgeInsets.only(top: 0),
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) =>
                            _itemProduct(
                                context: context,
                                groupValue: controller.valueProduct,
                                product: controller.listProduct[index],
                                value: index,
                                onChange: (value) {
                                  controller.valueProduct.value = value;
                                  controller.resetPackage();
                                  if (value > -1) {
                                    controller.isLoadingOTTService = true;
                                    controller.resetPlanOTTs();
                                    controller.getOTTService();
                                  }
                                }),
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                              color: AppColors.colorLineDash,
                              height: 1,
                              thickness: 1,
                            ),
                        itemCount: controller.listProduct.length)
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
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    padding: const EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFFE3EAF2)),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                        ]),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.textSelectPaymentMethod,
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
                            padding: const EdgeInsets.only(top: 0),
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) =>
                                _itemPackage(
                                    context: context,
                                    groupValue: controller.valuePackage,
                                    package: controller.listPackage[index],
                                    value: index,
                                    onChange: (value) {
                                      controller.valuePackage.value = value;
                                      controller.isLoadingReason = true;
                                      controller.isLoadingPromotion = true;
                                      // controller.isLoadingOTTService = true;
                                      controller.checkLoading();
                                      controller.resetPlanReason();
                                      controller.resetPromotions();
                                      // controller.resetPlanOTTs();
                                      if (value > -1) {
                                        controller.getPlanReasons();
                                        controller.getPromotions();
                                        // controller.getOTTService();
                                      }
                                    },
                                    fee: controller.getProduct().productValue),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                                      color: AppColors.colorLineDash,
                                      height: 1,
                                      thickness: 1,
                                    ),
                            itemCount: controller.listPackage.length)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Visibility(
                  visible: controller.valueProduct.value > -1 &&
                      controller.valuePackage.value > -1,
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 100),
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    padding: const EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFFE3EAF2)),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                        ]),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .textChonseAReasonConnection,
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
                        controller.isLoadingReason
                            ? LoadingCirculApi()
                            : ListView.separated(
                                padding: const EdgeInsets.only(top: 0),
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    _itemMethod(
                                        context: context,
                                        groupValue: controller.valueMethod,
                                        reason:
                                            controller.listPlanReason[index],
                                        value: index,
                                        onChange: (value) {
                                          controller.valueMethod.value = value;
                                        }),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                          color: AppColors.colorLineDash,
                                          height: 1,
                                          thickness: 1,
                                        ),
                                itemCount: controller.listPlanReason.length)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Visibility(
                  visible: controller.valueProduct.value > -1 &&
                      controller.valuePackage.value > -1,
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 100),
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    padding: const EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFFE3EAF2)),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                        ]),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.textChoosePromotion,
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
                        controller.isLoadingPromotion
                            ? LoadingCirculApi()
                            : ListView.separated(
                                padding: const EdgeInsets.only(top: 0),
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        _itemPromotion(
                                          context: context,
                                          promotion:
                                              controller.listPromotion[index],
                                        ),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                          color: AppColors.colorLineDash,
                                          height: 1,
                                          thickness: 1,
                                        ),
                                itemCount: controller.listPromotion.length)
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.valueMethod.value > -1,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        constraints: const BoxConstraints(minHeight: 100),
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        padding: const EdgeInsets.only(top: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0xFFE3EAF2)),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.textTypecontract,
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
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: typeContact(
                                          check: !controller.isForcedTerm(),
                                          content: AppLocalizations.of(context)!
                                              .textUndetermined)),
                                  Expanded(
                                      child: typeContact(
                                          check: controller.isForcedTerm(),
                                          content: AppLocalizations.of(context)!
                                              .textForcedTerm))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Visibility(
                  visible: controller.valueProduct.value > -1,
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 100),
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    padding: const EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFFE3EAF2)),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                        ]),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.textOTTService,
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
                        controller.isLoadingOTTService
                            ? LoadingCirculApi()
                            : controller.listPlanOTT.isNotEmpty
                                ? ListView.separated(
                                    padding: const EdgeInsets.only(top: 0),
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        controller.listPlanOTT[index]
                                                    .ottService !=
                                                OTTService.CABLE_GO
                                            ? _itemOTT(
                                                context: context,
                                                ott: controller
                                                    .listPlanOTT[index],
                                                value: index,
                                                listValue:
                                                    controller.listSelectOtt,
                                                onChange: (value) {
                                                  if (controller.listSelectOtt
                                                      .contains(value)) {
                                                    controller.listSelectOtt
                                                        .removeWhere(
                                                            (element) =>
                                                                element ==
                                                                value);
                                                  } else {
                                                    controller.listSelectOtt
                                                        .add(value);
                                                  }
                                                  controller.update();
                                                },
                                                controller: controller,
                                              )
                                            : _itemOTTCableGo(
                                                context: context,
                                                ott: controller
                                                    .listPlanOTT[index],
                                                value: index,
                                                listValue:
                                                    controller.listSelectOtt,
                                                onChange: (value) {
                                                  if (controller.listSelectOtt
                                                      .contains(value)) {
                                                    controller.listSelectOtt
                                                        .removeWhere(
                                                            (element) =>
                                                                element ==
                                                                value);
                                                  } else {
                                                    controller.listSelectOtt
                                                        .add(value);
                                                  }
                                                  controller.update();
                                                },
                                                controller: controller,
                                              ),
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(
                                              color: AppColors.colorLineDash,
                                              height: 1,
                                              thickness: 1,
                                            ),
                                    itemCount: controller.listPlanOTT.length)
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          AppLocalizations.of(context)!
                                              .textNoOTTService,
                                          style: AppStyles.r2B3A4A_12_500
                                              .copyWith(fontSize: 13)),
                                    ],
                                  )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(
                () => bottomButton(
                    text: AppLocalizations.of(context)!.textContinue,
                    onTap: () {
                      if (controller.checkBtnContinue()) {
                        controller.checkEmailCableGo((isSuccess) {
                          if (isSuccess) {
                            controller.isOnMethodPage.value = false;
                            controller.isOnInvoicePage.value = true;
                            controller.scrollController?.scrollTo(
                              index: 1,
                              duration: const Duration(milliseconds: 200),
                            );
                            controller.isLoadingWallet = true;
                            controller.isLoadingBill = true;
                            controller.checkLoadingBill();
                            controller.getWallet(context);
                            controller.postContractInformation();
                          }
                        });
                      }
                    },
                    color: !(controller.valueMethod.value > -1 &&
                            controller.valueProduct.value > -1 &&
                            controller.valuePackage.value > -1)
                        ? const Color(0xFF415263).withOpacity(0.2)
                        : null),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          )),
        ),
      ),
    );
  }
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

Widget _itemPackage(
    {required BuildContext context,
    required int value,
    required PackageModel package,
    required RxInt groupValue,
    required var onChange,
    required double fee}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    child: InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        groupValue.value != value ? onChange(value) : onChange(-1);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() =>
              groupValue.value == value ? iconChecked() : iconUnchecked()),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(package.packageName ?? '---',
                    style: AppStyles.r2B3A4A_12_500),
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
              Common.numberFormat(fee * (package.numMonthPay ?? 0)),
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
  );
}

Widget _itemMethod(
    {required BuildContext context,
    required int value,
    required PlanReasonModel reason,
    required RxInt groupValue,
    required var onChange}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    child: InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        groupValue.value != value ? onChange(value) : onChange(-1);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() =>
              groupValue.value == value ? iconChecked() : iconUnchecked()),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${AppLocalizations.of(context)!.textName}: ${reason.name}',
                    style: AppStyles.r2B3A4A_12_500),
                Text(
                    '${AppLocalizations.of(context)!.textReasonCode} ${reason.reasonCode}',
                    style: AppStyles.r2B3A4A_12_500),
                Text(
                  '${AppLocalizations.of(context)!.textInstallationFee} ${Common.numberFormat(reason.feeInstallation)}',
                  style: AppStyles.r6C8AA1_13_400
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                ),
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

Widget _itemOTT(
    {required BuildContext context,
    required PlanOttModel ott,
    required int value,
    required List<int> listValue,
    required var onChange,
    required ProductPaymentMethodLogic controller}) {
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
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(ott.ottName,
                        style: AppStyles.r2B3A4A_12_500.copyWith(fontSize: 13)),
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
                      style: AppStyles.r9454C9_14_500
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
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
    required ProductPaymentMethodLogic controller}) {
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
                          style:
                              AppStyles.r2B3A4A_12_500.copyWith(fontSize: 13)),
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
    required ProductPaymentMethodLogic controller}) {
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
                          style:
                              AppStyles.r2B3A4A_12_500.copyWith(fontSize: 13)),
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
                      style: AppStyles.r9454C9_14_500
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
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

Widget _voiceContract(
    {required BuildContext context,
    required ProductPaymentMethodLogic controller}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    child: ExpandableNotifier(
      child: Column(
        children: [
          ExpandablePanel(
            controller: controller.voiceContractExpand,
            theme: const ExpandableThemeData(hasIcon: false),
            collapsed: ExpandableButton(
              child: Row(
                children: [
                  Obx(() => controller.checkVoiceContract.value
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
                    child: Text(AppLocalizations.of(context)!.textVoiceContract,
                        style: AppStyles.r2B3A4A_12_500.copyWith(fontSize: 13)),
                  ),
                ],
              ),
            ),
            expanded: Column(
              children: [
                ExpandableButton(
                  child: Row(
                    children: [
                      Obx(() => controller.checkVoiceContract.value
                          ? const Icon(
                              Icons.check_box,
                              color: AppColors.colorSubContent,
                            )
                          : const Icon(
                              Icons.check_box_outline_blank,
                              // color: Colors.white,
                              color: AppColors.colorSubContent,
                            )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                            AppLocalizations.of(context)!.textVoiceContract,
                            style: AppStyles.r2B3A4A_12_500
                                .copyWith(fontSize: 13)),
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
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: AppLocalizations.of(context)!.textCallId,
                              style: AppStyles.r2B3A4A_12_500.copyWith(
                                  fontSize: 13, color: const Color(0xFF6C8AA1)),
                              children: [
                                TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: AppColors.colorTextError,
                                      fontFamily: 'Barlow',
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 12, bottom: 17),
                          child: SizedBox(
                            height: 65,
                            child: TextField(
                                controller:
                                    controller.voiceContractTextController,
                                maxLength: 100,
                                keyboardType: TextInputType.text,
                                focusNode: controller.voiceContractFocusNode,
                                style: AppStyles.r2B3A4A_12_500.copyWith(
                                    fontSize: 14,
                                    color: AppColors.color_2B3A4A
                                        .withOpacity(0.85)),
                                onChanged: (value) {
                                  if (value.trim().isNotEmpty) {
                                    controller.voiceContractError = null;
                                  } else {
                                    controller.voiceContractError =
                                        AppLocalizations.of(context)!
                                            .textCannotBeBlank;
                                  }
                                  controller.update();
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  errorText: controller.voiceContractError,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.only(
                                      top: 5, left: 18, right: 10),
                                  hintText: AppLocalizations.of(context)!
                                      .textEnterCallID,
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

Widget typeContact({required bool check, required String content}) {
  return Row(
    children: [
      check ? iconChecked() : iconUnchecked(),
      const SizedBox(
        width: 13,
      ),
      Text(
        content,
        style: AppStyles.r2B3A4A_12_500.copyWith(
            color: AppColors.color_2B3A4A.withOpacity(0.85), fontSize: 13),
      )
    ],
  );
}
