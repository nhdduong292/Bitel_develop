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
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Text(
                AppLocalizations.of(context)!.textTheAccountIsConditioned,
                style: AppStyles.r415263_14_600.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text('${AppLocalizations.of(context)!.textCancelAnyway}?',
                      style: AppStyles.r415263_14_600.copyWith(fontSize: 16)),
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
