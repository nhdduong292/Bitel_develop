import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_unsuccessfull_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

class DialogSurveyUnsuccessful extends StatelessWidget {
  final Function? onSubmit;

  const DialogSurveyUnsuccessful({super.key, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogSurveyUnsuccessfullLogic(),
      builder: (controller) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        child: Padding(
          padding:
          const EdgeInsets.only(top: 22, left: 16, right: 16, bottom: 26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(AppImages.icClose)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  AppLocalizations.of(context)!.textTitleSurveyUnsuccessful,
                  style: AppStyles.r6.copyWith(
                      color: AppColors.colorTextError,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const LineDash(color: AppColors.colorLineDash),
              ),
              Text(
                AppLocalizations.of(context)!.textContentSurveyUnsuccessful,
                style: AppStyles.r6.copyWith(
                    color: AppColors.colorText4, fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {
                  controller.setSurveyOffline(!controller.isSelectOffline);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      controller.isSelectOffline ? iconOnlyRadio(-1) : iconOnlyUnRadio(),
                      SizedBox(width: 10,),
                      Text(
                        AppLocalizations.of(context)!.textCreateOfflineSurvey,
                        style: AppStyles.r6.copyWith(
                            color: AppColors.colorText4, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.colorButton,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: InkWell(
                  onTap: () {
                    onSubmit!.call();
                  },
                  child: Center(
                      child: Text(
                        AppLocalizations.of(context)!
                            .textAccept
                            .toUpperCase(),
                        style: AppStyles.r5
                            .copyWith(fontWeight: FontWeight.w500),
                      )),
                ),
              )
            ],
          ),
        ),
      );
    },);
  }
}
