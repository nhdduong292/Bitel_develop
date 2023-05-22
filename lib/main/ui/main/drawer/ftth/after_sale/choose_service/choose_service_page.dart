import 'package:bitel_ventas/main/networks/model/check_debt_model.dart';
import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/choose_service/choose_service_item_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/choose_service/choose_service_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/dialog_cancel_service/dialog_cancel_service.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../res/app_images.dart';
import '../../../../../../networks/model/request_detail_model.dart';
import '../../../../../../router/route_config.dart';
import '../../../../../../utils/common_widgets.dart';

class ChooseServicePage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChooseServiceLogic(context: context),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(children: [
            Expanded(
              child: ListView.builder(
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
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                if (controller.isActive) {
                  return;
                }
                // _onLoading(context);
                if (controller.afterSaleSearchLogic.type == 'CHANGE_PLAN') {
                  RequestDetailModel requestModel = RequestDetailModel();
                  Get.toNamed(RouteConfig.productPayment,
                      arguments: [requestModel, 'CHANGE']);
                } else if (controller.afterSaleSearchLogic.type ==
                    'TRANSFER_SERVICE') {
                } else {
                  controller.checkOldRequest((value) {
                    if (value) {
                      controller.checkDebtWO((value) {
                        if (value) {
                          controller.onCheckDebtWO();
                        }
                      });
                    }
                  });

                  // Get.toNamed(RouteConfig.dateCancelService, arguments: [
                  //   controller.listAccount[controller.valueService.value]
                  // ]);
                }
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 50, left: 25, right: 25),
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
        );
      },
    );
  }
}

class NotiCancelDialog extends Dialog {
  CheckDebtModel model;
  Function onOk;
  bool isDebt;
  NotiCancelDialog(
      {super.key,
      required this.model,
      required this.onOk,
      required this.isDebt});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Wrap(children: [
        Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            SvgPicture.asset(AppImages.imgNotify),
            const SizedBox(
              height: 15,
            ),
            const DottedLine(
              dashColor: AppColors.colorLineDash,
              dashGapLength: 3,
              dashLength: 4,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                isDebt
                    ? AppLocalizations.of(context)!.textTheAccountHasUnpaid
                    : AppLocalizations.of(context)!.textTheAccountHasUnfinished,
                style: AppStyles.r415263_14_600.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isDebt
                            ? "${AppLocalizations.of(context)!.textAmountOfDebt}:"
                            : '${AppLocalizations.of(context)!.textStatus}:',
                        style: AppStyles.r15,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        isDebt ? model.debt.toString() : model.pendingWoStatus,
                        style: AppStyles.r15,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isDebt
                            ? "${AppLocalizations.of(context)!.textInvoiceNumber}:"
                            : '${AppLocalizations.of(context)!.textWOType}:',
                        style: AppStyles.r15,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        isDebt ? model.debtInvoiceNumber : model.pendingWoType,
                        style: AppStyles.r15,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: bottomButtonV2(
                        text: AppLocalizations.of(context)!.textNo,
                        onTap: () {
                          Get.back();
                        })),
                Expanded(
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textYes,
                        onTap: () {
                          Get.back();
                          onOk();
                        })),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ]),
    );
  }
}
