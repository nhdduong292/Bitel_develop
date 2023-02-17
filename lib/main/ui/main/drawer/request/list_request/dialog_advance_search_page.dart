import 'dart:async';
import 'dart:math';

import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_advance_search_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_transfer_request_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

class DialogAdvancedSearchPage extends GetWidget {
  final Function(String status)? onSubmit;

  DialogAdvancedSearchPage({super.key, this.onSubmit});


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogAdvanceSearchLogic(),
      builder: (controller) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          child:SingleChildScrollView(
            child:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Stack(
                    children: [
                      Center(child: Text(
                        AppLocalizations.of(context)!.textAdvancedSearch,
                        style: AppStyles.r6.copyWith(
                            color: AppColors.colorText1,
                            fontWeight: FontWeight.w500),
                      )),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset(AppImages.icClose)),
                      )
                    ],
                  ),
                ),
                const LineDash(color: AppColors.colorLineDash),
                Container(
                  padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(
                        AppLocalizations.of(context)!.textTelecomService,
                        style: AppStyles.r8.copyWith(
                            color: AppColors.colorText1.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      )),
                      Expanded(
                          flex: 5,
                          child: spinnerFormV2(
                              context: context,
                              hint:
                              AppLocalizations.of(context)!.hintTelecomService,
                              required: false,
                              dropValue: controller.currentService,
                              listDrop: controller.listService))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child:  Text(
                        AppLocalizations.of(context)!.textRequestCode,
                        style: AppStyles.r8.copyWith(
                            color: AppColors.colorText1.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      )),
                      Expanded(
                          flex: 5,
                          child: spinnerFormV2(
                              context: context,
                              hint:
                              AppLocalizations.of(context)!.hintRequestCode,
                              required: false,
                              dropValue: "",
                              listDrop: []))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child:  Text(
                        AppLocalizations.of(context)!.textStatus,
                        style: AppStyles.r8.copyWith(
                            color: AppColors.colorText1.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      )),
                      Expanded(
                          flex: 5,
                          child: spinnerFormV2(
                              context: context,
                              hint:
                              AppLocalizations.of(context)!.hintStatus,
                              required: false,
                              dropValue: controller.currentStatus,
                              function: (value) {
                                controller.setStatus(value);
                              },
                              listDrop: controller.listStatus))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child:  Text(
                        AppLocalizations.of(context)!.textProvince,
                        style: AppStyles.r8.copyWith(
                            color: AppColors.colorText1.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      )),
                      Expanded(
                          flex: 5,
                          child: spinnerFormV2(
                              context: context,
                              hint:
                              AppLocalizations.of(context)!.hintProvince,
                              required: false,
                              dropValue: "",
                              listDrop: []))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child:  Text(
                        AppLocalizations.of(context)!.textStaffCode,
                        style: AppStyles.r8.copyWith(
                            color: AppColors.colorText1.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      )),
                      Expanded(
                          flex: 5,
                          child: spinnerFormV2(
                              context: context,
                              hint:
                              AppLocalizations.of(context)!.hintStaffCode,
                              required: false,
                              dropValue: controller.currentReason,
                              listDrop: controller.listReason))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child:  Text(
                        AppLocalizations.of(context)!.textRequestDate,
                        style: AppStyles.r8.copyWith(
                            color: AppColors.colorText1.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      )),
                      Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex:1,
                                child: InkWell(
                                    onTap: () {
                                      _selectDate(context,controller, true);
                                    },
                                    child:  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                          border: Border.all(color: Color(0xFFE3EAF2))),
                                      padding: EdgeInsets.only(top: 11,bottom: 11, left: 16, right: 16),
                                      child: Text.rich(TextSpan(
                                          style: AppStyles.r2.copyWith(color: controller.fromDate.value.isEmpty  ? AppColors.colorHint1 : AppColors.colorText1, fontWeight: FontWeight.w400),
                                          children: [
                                            WidgetSpan(
                                              child: controller.fromDate.value.isEmpty ? Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: SvgPicture.asset(AppImages.icSelectDate),
                                              ) : Container(),
                                            ),

                                            TextSpan(
                                              text: controller.fromDate.value.isEmpty ? AppLocalizations.of(context)!.textFrom: controller.fromDate.value,
                                            )
                                          ]
                                      )),
                                    )),
                              ),
                              SizedBox(width: 12,),
                              Expanded(
                                flex:1,
                                child: InkWell(
                                    onTap: () {
                                      _selectDate(context,controller,false);
                                    },
                                    child:  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                          border: Border.all(color: Color(0xFFE3EAF2))),
                                      padding: EdgeInsets.only(top: 11,bottom: 11, left: 16, right: 16),
                                      child: Text.rich(TextSpan(
                                          style: AppStyles.r2.copyWith(color: controller.toDate.value.isEmpty  ? AppColors.colorHint1 : AppColors.colorText1, fontWeight: FontWeight.w400),
                                          children: [
                                            WidgetSpan(
                                              child: controller.toDate.value.isEmpty ? Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: SvgPicture.asset(AppImages.icSelectDate),
                                              ) : Container(),
                                            ),

                                            TextSpan(
                                              text: controller.toDate.value.isEmpty ? AppLocalizations.of(context)!.textTo: controller.toDate.value,
                                            )
                                          ]
                                      )),
                                    )),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 30,bottom: 36, left: 16, right: 16),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.colorButton,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: InkWell(
                    onTap: () {
                      if(controller.currentStatus.isNotEmpty) {
                        Get.back();
                        onSubmit!.call(controller.currentStatus);
                      }
                    },
                    child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.textSearch.toUpperCase(),
                          style: AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                        )),
                  ),
                )
              ],
            ),
          )
        );
      },
    );
  }

  _selectDate(BuildContext context, DialogAdvanceSearchLogic control, bool from) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: control.selectDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if(from){
      control.setFromDate(picked!);
    } else {
      control.setToDate(picked!);
    }
  }
}
