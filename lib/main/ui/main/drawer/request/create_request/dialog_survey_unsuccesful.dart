import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_unsuccessfull_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

import '../../ftth/after_sale/transfer_service/create_transfer_service_logic.dart';

class DialogSurveyUnsuccessful extends GetWidget {
  final Function? onSubmit;
  int id;

  DialogSurveyUnsuccessful(this.id, this.onSubmit, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogSurveyUnsuccessfullLogic(context: context, id: id),
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
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: LineDash(color: AppColors.colorLineDash),
                ),
                Text(
                  AppLocalizations.of(context)!.textContentSurveyUnsuccessful,
                  textAlign: TextAlign.center,
                  style: AppStyles.r6.copyWith(
                      color: AppColors.colorText4, fontWeight: FontWeight.w500),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    controller.setSurveyOffline(!controller.isSelectOffline);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: controller.isSelectOffline
                                ? iconOnlyRadio(-1)
                                : iconOnlyUnRadio()),
                        Expanded(
                            flex: 4,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .textCreateOfflineSurvey,
                              textAlign: TextAlign.left,
                              style: AppStyles.r6.copyWith(
                                  color: AppColors.colorText4,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    _onLoading(context);

                    bool isExit =
                        Get.isRegistered<CreateTransferServiceLogic>();
                    if (isExit) {
                      controller.createSurveyOfflineTransfer(
                        (isSuccess) {
                          if (isSuccess) {
                            Get.back();
                            Get.until(
                              (route) {
                                return Get.currentRoute ==
                                    RouteConfig.afterSale;
                              },
                            );
                            Get.toNamed(RouteConfig.sale);
                            Get.toNamed(RouteConfig.listRequest, arguments: 1);
                          } else {
                            Get.back();
                          }
                        },
                      );
                      return;
                    }

                    controller.createSurveyOffline(
                      (isSuccess) {
                        if (isSuccess) {
                          Get.back();
                          bool isExit = Get.isRegistered<ListRequestLogic>();
                          if (isExit) {
                            Get.until(
                              (route) {
                                return Get.currentRoute ==
                                    RouteConfig.listRequest;
                              },
                            );
                            ListRequestLogic listRequestLogic = Get.find();
                            listRequestLogic.updateSearchRequestToIndex(1);
                            listRequestLogic.refreshListRequest();
                          } else {
                            Get.until(
                              (route) {
                                return Get.currentRoute == RouteConfig.sale;
                              },
                            );
                            Get.toNamed(RouteConfig.listRequest, arguments: 1);
                          }
                        } else {
                          Get.back();
                        }
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.colorButton,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                        child: Text(
                      AppLocalizations.of(context)!.textAccept.toUpperCase(),
                      style: AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                    )),
                  ),
                )
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
