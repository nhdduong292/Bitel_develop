import 'package:bitel_ventas/main/networks/model/plan_reason_model.dart';
import 'package:bitel_ventas/main/networks/model/product_model.dart';
import 'package:bitel_ventas/main/networks/model/promotion_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/product_payment_method_logic.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../networks/model/method_model.dart';
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
                            groupValue: controller.valueProduct,
                            product: controller.listProduct[index],
                            value: index,
                            onChange: (value) {
                              controller.valueProduct.value = value;
                              controller.isLoadingReason = true;
                              controller.isLoadingPromotion = true;
                              controller.checkLoading();
                              controller.resetPlanReason();
                              if (value > -1) {
                                controller.isChanged = true;
                                controller.getPlanReasons(
                                    controller.listProduct[value].productId!,
                                    context);
                              }
                              controller.resetPromotions();
                              if (value > -1) {
                                controller.getPromotions(
                                    controller.listProduct[value].productId!);
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
                                groupValue: controller.valuePromotion,
                                promotion: controller.listPromotion[index],
                                value: index,
                                onChange: (value) {
                                  controller.valuePromotion.value = value;
                                }),
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
                  if ((controller.valueMethod.value > -1 &&
                          controller.valueProduct.value > -1 &&
                          controller.status == 'CREATE') ||
                      (controller.valueMethod.value > -1 &&
                          controller.valueProduct.value > -1 &&
                          controller.status == 'CHANGE' &&
                          controller.checkChangePackage())) {
                    controller.isOnMethodPage.value = false;
                    controller.isOnInvoicePage.value = true;

                    controller.scrollController?.scrollTo(
                      index: 1,
                      duration: const Duration(milliseconds: 200),
                    );
                    controller.getWallet(context);
                  }
                },
                color: !(controller.valueMethod.value > -1 &&
                            controller.valueProduct.value > -1 &&
                            controller.status == 'CREATE') &&
                        !(controller.valueMethod.value > -1 &&
                            controller.valueProduct.value > -1 &&
                            controller.status == 'CHANGE' &&
                            controller.checkChangePackage())
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
    {required int value,
    required ProductModel product,
    required RxInt groupValue,
    required var onChange}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    child: InkWell(
      onTap: () {
        groupValue.value != value ? onChange(value) : onChange(-1);
      },
      splashColor: Colors.black38,
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
                  'Speed ${product.speed} Mpbs',
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
              '${product.defaultValue ?? 'null'}/month',
              style: AppStyles.r9454C9_14_500
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
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
      onTap: () {
        groupValue.value != value ? onChange(value) : onChange(-1);
      },
      splashColor: Colors.black38,
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
                  reason.name ?? 'null',
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Barlow',
                      color: AppColors.colorText1,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '${AppLocalizations.of(context)!.textFreeInstallation} ${reason.feeInstallation}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Barlow',
                      color: AppColors.colorText2,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '${AppLocalizations.of(context)!.textReasonCodeName} ${reason.reasonCode}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Barlow',
                      color: AppColors.colorText2,
                      fontWeight: FontWeight.w400),
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
              reason.fee.toString(),
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

Widget _itemPromotion(
    {required BuildContext context,
    required int value,
    required PromotionModel promotion,
    required RxInt groupValue,
    required var onChange}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    child: InkWell(
      onTap: () {
        groupValue.value != value ? onChange(value) : onChange(-1);
      },
      splashColor: Colors.black38,
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
            child:
                Text(promotion.name ?? 'null', style: AppStyles.r2B3A4A_12_500),
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
        style: AppStyles.r2B3A4A_12_500
            .copyWith(color: AppColors.color_2B3A4A.withOpacity(0.85)),
      )
    ],
  );
}
