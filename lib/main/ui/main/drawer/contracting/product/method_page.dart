import 'package:bitel_ventas/main/networks/model/product_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/product_payment_method_logic.dart';
import 'package:bitel_ventas/res/app_colors.dart';
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
              children: [
                Text(
                  AppLocalizations.of(context)!.textSelectProduct,
                  style: const TextStyle(
                      color: AppColors.colorContent,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto'),
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
                            controller.listProduct[index], controller, context),
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
              children: [
                Text(
                  AppLocalizations.of(context)!.textSelectPaymentMethod,
                  style: const TextStyle(
                      color: AppColors.colorContent,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto'),
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
                            controller.listMethod[index], controller, context),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                          color: AppColors.colorLineDash,
                          height: 1,
                          thickness: 1,
                        ),
                    itemCount: controller.listMethod.length)
              ],
            ),
          ),
          Obx(
            () => bottomButton(
                text: AppLocalizations.of(context)!.textContinue,
                onTap: () {
                  if (controller.isSelectedMethod.value &&
                      controller.isSelectedProduct.value) {
                    controller.isOnMethodPage.value = false;
                    controller.isOnInvoicePage.value = true;
                    controller.scrollController.scrollTo(
                      index: 1,
                      duration: const Duration(milliseconds: 200),
                    );
                  }
                },
                color: !controller.isSelectedMethod.value ||
                        !controller.isSelectedProduct.value
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

Widget _itemProduct(ProductModel product, ProductPaymentMethodLogic controller,
    BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    child: InkWell(
      onTap: () {
        controller.isSelectedProduct.value = true;
        controller.setSelectedProduct(product);
        for (ProductModel item in controller.listProduct) {
          item.isSelected.value = false;
        }
        product.isSelected.value = true;
      },
      splashColor: Colors.black38,
      child: Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() =>
                product.isSelected.value ? iconChecked() : iconUnchecked()),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? 'null',
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        color: AppColors.colorText1,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    product.desc ?? 'null',
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        color: AppColors.colorText1,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Speed ${product.speed}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        color: AppColors.colorText1,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Text(
              product.price ?? 'null',
              style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: AppColors.colorText1,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _itemMethod(MethodModel method, ProductPaymentMethodLogic controller,
    BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    child: InkWell(
      onTap: () {
        controller.isSelectedMethod.value = true;
        controller.setSelectedMethod(method);
        for (MethodModel item in controller.listMethod) {
          item.isSelected.value = false;
        }
        method.isSelected.value = true;
      },
      splashColor: Colors.black38,
      child: Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() =>
                method.isSelected.value ? iconChecked() : iconUnchecked()),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.name ?? 'null',
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: AppColors.colorText1,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Free installation: ${method.freeInstallation}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        color: AppColors.colorText2,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Reason code-name: ${method.reasonCodeName}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
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
                method.price ?? 'null',
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    color: AppColors.colorText3,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
