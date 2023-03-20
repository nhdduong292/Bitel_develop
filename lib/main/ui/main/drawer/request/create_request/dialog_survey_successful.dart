import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_succesful_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

class DialogSurveySuccessful extends GetWidget {
  final Function(bool isOnline)? onSubmit;
  int id;
  String type;
  String idNumber;

  DialogSurveySuccessful(this.id, this.type, this.idNumber, this.onSubmit);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogSurveySuccessfulLogic(id),
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
                      margin: const EdgeInsets.only(bottom: 0),
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(AppImages.icClose)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    AppLocalizations.of(context)!.textTitleSurveySuccessful,
                    style: AppStyles.r6.copyWith(
                        color: AppColors.colorSelectTab,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: LineDash(color: AppColors.colorLineDash),
                ),
                Text(
                  AppLocalizations.of(context)!.textContentSurveySuccessful,
                  style: AppStyles.r6.copyWith(
                      color: AppColors.colorText4, fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () {
                    controller.setSurveyOffline(!controller.isSelectOffline);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller.isSelectOffline
                            ? iconOnlyRadio(-1)
                            : iconOnlyUnRadio(),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          AppLocalizations.of(context)!.textCreateOfflineSurvey,
                          style: AppStyles.r6.copyWith(
                              color: AppColors.colorText4,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            if (controller.isSelectOffline) {
                              _onLoading(context);
                              controller.createSurveyOffline(
                                (isSuccess) {
                                  if (isSuccess) {
                                    Get.close(4);
                                    // DialogSurveyMapLogic surveyMapLogic = Get.find();
                                    // surveyMapLogic.setStateConnect(true);
                                    Get.toNamed(RouteConfig.listRequest,
                                        arguments: 1);
                                  } else {
                                    Get.back();
                                  }
                                },
                              );
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 22),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: controller.isSelectOffline
                                  ? AppColors.colorButton
                                  : Colors.white,
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
                              AppLocalizations.of(context)!
                                  .textAccept
                                  .toUpperCase(),
                              style: controller.isSelectOffline
                                  ? AppStyles.r5
                                      .copyWith(fontWeight: FontWeight.w500)
                                  : AppStyles.r1
                                      .copyWith(fontWeight: FontWeight.w500),
                            )),
                          ),
                        )),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            if (!controller.isSelectOffline) {
                              _onLoading(context);
                              controller.createSurveyOnline(
                                (isSuccess) {
                                  if (isSuccess) {
                                    //   Get.back();
                                    //   DialogSurveyMapLogic surveyMapLogic = Get.find();
                                    //   surveyMapLogic.setStateConnect(true);
                                    Get.close(4);
                                    // Get.toNamed(RouteConfig.productPayment,
                                    //     arguments: controller.requestModel.id);
                                    Get.toNamed(RouteConfig.productPayment,
                                        arguments: [id, type, idNumber]);
                                  } else {
                                    Get.back();
                                  }
                                },
                              );
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 22),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: !controller.isSelectOffline
                                  ? AppColors.colorButton
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                                child: Text(
                              AppLocalizations.of(context)!
                                  .textConnect
                                  .toUpperCase(),
                              style: !controller.isSelectOffline
                                  ? AppStyles.r5
                                      .copyWith(fontWeight: FontWeight.w500)
                                  : AppStyles.r1
                                      .copyWith(fontWeight: FontWeight.w500),
                            )),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: LoadingCirculApi(),
        );
      },
    );
  }
}
