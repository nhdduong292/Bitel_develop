import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/choose_service/choose_service_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/find_service/find_service_page.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../router/route_config.dart';
import '../../../../../../utils/common.dart';
import '../../../request/create_request/create_request_policy_page.dart';
import '../dialog_cancel_service/dialog_cancel_service.dart';
import 'date_cancel_service_logic.dart';

class DateCancelService extends GetWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: DateCancelServiceLogic(context: context),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    width: width,
                    height: 147,
                  ),
                  SvgPicture.asset(
                    AppImages.bgAppbar,
                    width: width,
                  ),
                  Positioned(
                    top: 50,
                    left: 70,
                    child: Text(AppLocalizations.of(context)!.textCancelService,
                        style: AppStyles.title),
                  ),
                  Positioned(
                      top: 45,
                      left: 20,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13)),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 15,
                              color: AppColors.colorTitle,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border:
                          Border.all(width: 1, color: AppColors.colorLineDash),
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 2,
                          color: AppColors.colorLineDash,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .textTypeOfService,
                                    style: AppStyles.r6C8AA1_13_400,
                                  ),
                                ),
                                Text(
                                  controller.findAccountModel.typeOfService,
                                  style: AppStyles.rText1_13_500,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    AppLocalizations.of(context)!.textNumber,
                                    style: AppStyles.r6C8AA1_13_400,
                                  ),
                                ),
                                Text(
                                  controller.findAccountModel.serviceNumber
                                      .toString(),
                                  style: AppStyles.rText1_13_500,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 22),
                                  child: Text(
                                    AppLocalizations.of(context)!.textIDType,
                                    style: AppStyles.r6C8AA1_13_400,
                                  ),
                                ),
                                Text(
                                  Common.getIdentityType(
                                      controller.findAccountModel.idType),
                                  style: AppStyles.rText1_13_500,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    AppLocalizations.of(context)!.textName,
                                    style: AppStyles.r6C8AA1_13_400,
                                  ),
                                ),
                                Text(
                                  controller.findAccountModel.name,
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
                                    controller.findAccountModel.plan,
                                    style: AppStyles.rText1_13_500,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 4),
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
                                      'Active',
                                      style: AppStyles.rText1_13_500
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 22),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .textIDNumber,
                                      style: AppStyles.r6C8AA1_13_400,
                                    ),
                                  ),
                                  Text(
                                    controller.findAccountModel.idNumber,
                                    style: AppStyles.rText1_13_500,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      "",
                                      style: AppStyles.r6C8AA1_13_400,
                                    ),
                                  ),
                                  Text(
                                    "",
                                    style: AppStyles.rText1_13_500,
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  formDateView(
                      controller: controller,
                      context: context,
                      hint: AppLocalizations.of(context)!.textEnterDate,
                      label: AppLocalizations.of(context)!.textCancelationDate,
                      content: controller.cancelDate,
                      required: true,
                      isIcon: true,
                      width: width * 0.5),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        controller.setCheckAgree(!controller.isCheckAgree);
                      },
                      child: Row(
                        children: [
                          controller.isCheckAgree
                              ? iconOnlyRadio(0)
                              : iconOnlyUnRadio(),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                              flex: 1,
                              child: RichText(
                                text: TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .textInfoCreateRequest1,
                                  style: AppStyles.r2
                                      .copyWith(color: AppColors.colorText1),
                                  children: <TextSpan>[
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () =>
                                              Get.to(CreateRequestPolicyPage()),
                                        text: AppLocalizations.of(context)!
                                            .textInfoCreateRequest2,
                                        style: const TextStyle(
                                            color: AppColors.colorUnderText,
                                            decoration:
                                                TextDecoration.underline)),
                                    TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .textInfoCreateRequest3)
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      if (!controller.checkActiveContinue()) {
                        return;
                      }
                      controller.requestCanncel((isSuccess) {
                        if (isSuccess) {
                          if (controller.cancelServiceModel.isPenalty &&
                              controller.cancelServiceModel.totalPenalty > 0) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CancelServiceDialog(
                                    context: context,
                                    accountModel: controller.findAccountModel,
                                    cancelServiceModel:
                                        controller.cancelServiceModel,
                                    onSuccess: () {
                                      Get.back();
                                      // Get.toNamed(RouteConfig.clearPenalty);
                                      Get.toNamed(RouteConfig.cancelServicePDF,
                                          arguments: [
                                            controller.cancelServiceModel
                                                .cancelOrderId
                                          ]);
                                    },
                                  );
                                });
                          } else {
                            Get.toNamed(RouteConfig.cancelServicePDF);
                          }
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          bottom: 50, left: 25, right: 25),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: !controller.checkActiveContinue()
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
                        AppLocalizations.of(context)!
                            .textContinue
                            .toUpperCase(),
                        style: !controller.checkActiveContinue()
                            ? AppStyles.r1.copyWith(fontWeight: FontWeight.w500)
                            : AppStyles.r5
                                .copyWith(fontWeight: FontWeight.w500),
                      )),
                    ),
                  )
                ],
              )),
            ],
          ),
        );
      },
    );
  }

  Widget formDateView(
      {required BuildContext context,
      required String label,
      required String hint,
      required String content,
      required bool required,
      required bool isIcon,
      required var controller,
      required var width}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 25,
            right: 25,
          ),
          child: RichText(
            text: TextSpan(
              text: label,
              style: AppStyles.r2B3A4A_12_500.copyWith(
                  fontSize: 14,
                  color: AppColors.color_2B3A4A.withOpacity(0.85)),
              children: [
                TextSpan(
                    text: required ? ' *' : '',
                    style: const TextStyle(
                      color: AppColors.colorTextError,
                      fontFamily: 'Barlow',
                      fontSize: 14,
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                controller.setDateNow();
                _selectDate(context, controller, false);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: Container(
                    height: 45,
                    width: width,
                    padding: const EdgeInsets.only(left: 18, right: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                            color: const Color(0xFFE3EAF2), width: 1)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              content.isNotEmpty ? content : hint,
                              style: content.isNotEmpty
                                  ? AppStyles.r2B3A4A_12_500.copyWith(
                                      fontSize: 14,
                                      color: AppColors.color_2B3A4A
                                          .withOpacity(0.85))
                                  : AppStyles.r2.copyWith(
                                      color: AppColors.colorHint1,
                                      fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: isIcon,
                            child: SvgPicture.asset(AppImages.icCalendar))
                      ],
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _selectDate(
      BuildContext context, DateCancelServiceLogic control, bool from) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: control.selectDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    );
    if (picked != null) {
      if (from) {
        control.setFromDate(picked);
      } else {
        control.setToDate(picked);
      }
    }
  }
}
