import 'dart:async';

import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/networks/model/reason_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_cancel_request_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

import '../../../../../router/route_config.dart';
import '../../../../../utils/dialog_util.dart';
import 'list_request_logic.dart';

class DialogCancelRequest extends GetWidget {
  final Function? onSubmit;
  int id;
  TextEditingController controllerTextField = TextEditingController();

  DialogCancelRequest({this.onSubmit, required this.id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogCancelRequestLogic(context: context),
      builder: (controller) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Stack(
                    children: [
                      Center(
                          child: Text(
                        AppLocalizations.of(context)!.textCancelRequest,
                        style: AppStyles.r6.copyWith(
                            color: AppColors.colorText1,
                            fontWeight: FontWeight.w500),
                      )),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset(AppImages.icClose)),
                      )
                    ],
                  ),
                ),
                const LineDash(color: AppColors.colorLineDash),
                Container(
                  padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            AppLocalizations.of(context)!.textReason,
                            style: AppStyles.r8.copyWith(
                                color: AppColors.colorText1.withOpacity(0.85),
                                fontWeight: FontWeight.w400),
                          )),
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border:
                                  Border.all(color: const Color(0xFFE3EAF2))),
                          child: DropdownButtonFormField2(
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                            ),
                            // selectedItemHighlightColor: Colors.red,
                            buttonHeight: 60,
                            buttonPadding:
                                const EdgeInsets.only(left: 0, right: 10),
                            dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                border:
                                    Border.all(color: const Color(0xFFE3EAF2))),
                            isExpanded: true,
                            // value: controller.currentReason.isNotEmpty ? controller.currentReason : null,
                            onChanged: (value) {
                              controller.currentReason = value!.id!;
                            },
                            items: controller.listReason
                                .map<DropdownMenuItem<ReasonModel>>(
                                    (ReasonModel value) {
                              return DropdownMenuItem(
                                  value: value, child: Text(value.content!));
                            }).toList(),
                            style: AppStyles.r2.copyWith(
                                color: AppColors.colorTitle,
                                fontWeight: FontWeight.w500),
                            icon: SvgPicture.asset(AppImages.icDropdownSpinner),
                            hint: Text(
                              AppLocalizations.of(context)!.hintReason,
                              style: AppStyles.r2.copyWith(
                                  color: AppColors.colorHint1,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return AppLocalizations.of(context)!
                                    .textPleaseSelect;
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            AppLocalizations.of(context)!.textNote,
                            style: AppStyles.r8.copyWith(
                                color: AppColors.colorText1.withOpacity(0.85),
                                fontWeight: FontWeight.w400),
                          )),
                      Expanded(
                          flex: 5,
                          child: spinnerFormV2(
                              isMaxlenght: true,
                              context: context,
                              hint: AppLocalizations.of(context)!.hintNote,
                              required: false,
                              dropValue: "",
                              function: (value) {
                                controller.setNote(value);
                              },
                              listDrop: [],
                              controlTextField: controllerTextField,
                              height: 150))
                    ],
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (controller.checkValidate(context)) return;
                    _onLoading(context);
                    controller.changeStatusRequest(
                      id,
                      controllerTextField.text,
                      (isSuccess) {
                        Get.back();
                        if (isSuccess) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return SuccessDialog(
                                  text: AppLocalizations.of(context)!
                                      .textCancelRequestSuccessfully,
                                  onOk: () {
                                    Get.until(
                                      (route) {
                                        return Get.currentRoute ==
                                            RouteConfig.listRequest;
                                      },
                                    );
                                    ListRequestLogic listRequestLogic =
                                        Get.find();
                                    listRequestLogic
                                        .updateSearchRequestToIndex(0);
                                    listRequestLogic.refreshListRequest();
                                  },
                                );
                              });
                        }
                      },
                    );
                    onSubmit!.call();
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        top: 30, bottom: 36, left: 16, right: 16),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.colorButton,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                        child: Text(
                      AppLocalizations.of(context)!.textCancel.toUpperCase(),
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
