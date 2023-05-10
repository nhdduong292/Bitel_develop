import 'package:bitel_ventas/main/networks/model/cancel_service_model.dart';
import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../../../res/app_colors.dart';
import '../../../../../../../res/app_images.dart';
import '../../../../../../../res/app_styles.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CancelServiceDialog extends Dialog {
  BuildContext context;
  Function onSuccess;
  FindAccountModel accountModel;
  CancelServiceModel cancelServiceModel;
  CancelServiceDialog(
      {required this.context,
      required this.onSuccess,
      required this.accountModel,
      required this.cancelServiceModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Wrap(children: [
        Column(
          children: [
            const SizedBox(
              height: 23,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 22),
              child: Text(
                AppLocalizations.of(context)!.textTheAccountIsConditioned,
                style: AppStyles.r415263_13_500
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 22),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 2),
                          //   child: Text(
                          //     AppLocalizations.of(context)!.textTypeOfService,
                          //     style: AppStyles.r6C8AA1_13_400,
                          //   ),
                          // ),
                          // Text(
                          //   "data",
                          //   style: AppStyles.rText1_13_500,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              AppLocalizations.of(context)!.textNumber,
                              style: AppStyles.r6C8AA1_13_400,
                            ),
                          ),
                          Text(
                            accountModel.serviceNumber,
                            style: AppStyles.rText1_13_500,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              AppLocalizations.of(context)!.textIDType,
                              style: AppStyles.r6C8AA1_13_400,
                            ),
                          ),
                          Text(
                            Common.getIdentityType(accountModel.idType),
                            style: AppStyles.rText1_13_500,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 22),
                            child: Text(
                              AppLocalizations.of(context)!.textName,
                              style: AppStyles.r6C8AA1_13_400,
                            ),
                          ),
                          Text(
                            accountModel.name,
                            style: AppStyles.rText1_13_500,
                          )
                        ],
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                AppLocalizations.of(context)!.textPlan,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                            ),
                            Text(
                              accountModel.plan,
                              style: AppStyles.rText1_13_500,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 4),
                              child: Text(
                                AppLocalizations.of(context)!.textStatus,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 2),
                              decoration: BoxDecoration(
                                color: AppColors.colorBackground3,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Text(
                                "Active",
                                style: AppStyles.rText1_13_500
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 22),
                              child: Text(
                                AppLocalizations.of(context)!.textIDNumber,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                            ),
                            Text(
                              accountModel.idNumber,
                              style: AppStyles.rText1_13_500,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10),
                            //   child: Text(
                            //     "",
                            //     style: AppStyles.r6C8AA1_13_400,
                            //   ),
                            // ),
                            // Text(
                            //   "",
                            //   style: AppStyles.rText1_13_500,
                            // )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(26),
              dashPattern: const [2, 2],
              strokeWidth: 1,
              color: const Color(0xFF9454C9),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 12),
                child: RichText(
                  text: TextSpan(
                      text: '${AppLocalizations.of(context)!.textPenalty}: ',
                      style: AppStyles.r1
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
                      children: [
                        TextSpan(
                          text: 'S/${cancelServiceModel.totalPenalty}',
                          style: AppStyles.r9454C9_14_500.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 22),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .textToContinueWithTheCancelation,
                    style: AppStyles.r415263_13_500
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(AppLocalizations.of(context)!.textDoesTheCustomerStill,
                      style: AppStyles.r415263_13_500),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                onSuccess();
                              }))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
