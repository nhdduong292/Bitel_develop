import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/choose_service/choose_service_item_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/choose_service/choose_service_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/dialog_cancel_service/dialog_cancel_service.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../networks/model/request_detail_model.dart';
import '../../../../../../router/route_config.dart';

class ChooseServicePage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChooseServiceLogic(context: context),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(children: [
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: controller.listAccount.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      controller.valueService.value = index;
                      controller.setActive(false);
                    },
                    child: ChooseServiceItemPage(index, controller.valueService,
                        controller.listAccount[index]),
                  );
                },
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  // if (controller.isActive ||
                  //     controller.checkValidate(context)) {
                  //   return;
                  // }
                  // _onLoading(context);
                  if (controller.afterSaleSearchLogic.type == 'CHANGE_PLAN') {
                    RequestDetailModel requestModel = RequestDetailModel();
                    Get.toNamed(RouteConfig.productPayment,
                        arguments: [requestModel, 'CHANGE']);
                  } else if (controller.afterSaleSearchLogic.type ==
                      'TRANSFER_SERVICE') {
                  } else {
                    Get.toNamed(RouteConfig.dateCancelService, arguments: [
                      controller.listAccount[controller.valueService.value]
                    ]);
                  }
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
      },
    );
  }
}
