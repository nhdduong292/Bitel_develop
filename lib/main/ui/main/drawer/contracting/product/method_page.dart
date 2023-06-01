import 'package:bitel_ventas/main/networks/model/package_model.dart';
import 'package:bitel_ventas/main/networks/model/plan_reason_model.dart';
import 'package:bitel_ventas/main/networks/model/product_model.dart';
import 'package:bitel_ventas/main/networks/model/promotion_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/product_payment_method_logic.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../networks/model/method_model.dart';
import '../../../../../utils/common.dart';
import '../../../../../utils/common_widgets.dart';

class MethodPage extends GetView<ProductPaymentMethodLogic> {
  ProductPaymentMethodLogic controller;

  MethodPage({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                                  controller.checkLoading();
                                  controller.resetPlanReason();
                                  if (value > -1) {
                                    controller.getPlanReasons();
                                  }
                                  controller.resetPromotions();
                                  if (value > -1) {
                                    controller.getPromotions();
                                  }
                                },
                                fee: controller.getProduct().productValue),
                        separatorBuilder: (BuildContext context, int index) =>
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
                      AppLocalizations.of(context)!.textChonseAReasonConnection,
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
                            _itemMethod(
                                context: context,
                                groupValue: controller.valueMethod,
                                reason: controller.listPlanReason[index],
                                value: index,
                                onChange: (value) {
                                  controller.valueMethod.value = value;
                                }),
                        separatorBuilder: (BuildContext context, int index) =>
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
                    ListView.separated(
                        padding: const EdgeInsets.only(top: 0),
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) =>
                            _itemPromotion(
                              context: context,
                              promotion: controller.listPromotion[index],
                            ),
                        separatorBuilder: (BuildContext context, int index) =>
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
                          padding: const EdgeInsets.only(left: 15, right: 15),
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
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
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
                  if (controller.valueMethod.value > -1 &&
                      controller.valueProduct.value > -1 &&
                      controller.valuePackage.value > -1) {
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
