import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/product_payment_method_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

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
          bottomButton(
            text: AppLocalizations.of(context)!.textContinue,
            onTap: () {
              if (controller.isOnMethodPage.value) {
                controller.isOnMethodPage.value = false;
                controller.isOnInvoicePage.value = true;
                controller.scrollController.scrollTo(
                  index: 1,
                  duration: const Duration(milliseconds: 200),
                );
              } else {}
            },
          ),
        ],
      )),
    );
  }
}
