import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/choose_service/choose_service_item_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/choose_service/choose_service_logic.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseServicePage extends GetWidget{
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChooseServiceLogic(),
      builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 2,
              itemBuilder: (
                context, index) {
              return InkWell(
                onTap: () {
                  controller.valueService.value = index;
                  controller.setActive(false);
                },
                child: ChooseServiceItemPage(index,controller.valueService),
              );
            },),


            InkWell(
              onTap: () {
                // if (controller.isActive ||
                //     controller.checkValidate(context)) {
                //   return;
                // }
                // _onLoading(context);
              },
              child: Container(
                width: double.infinity,
                margin:
                const EdgeInsets.only(bottom: 50, left: 25, right: 25),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: controller.isActive
                      ? Colors.white
                      : AppColors.colorButton,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
                child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.textContinue.toUpperCase(),
                      style: controller.isActive
                          ? AppStyles.r1.copyWith(fontWeight: FontWeight.w500)
                          : AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                    )),
              ),
            )
          ]),
        ),
      );
    },);
  }

}