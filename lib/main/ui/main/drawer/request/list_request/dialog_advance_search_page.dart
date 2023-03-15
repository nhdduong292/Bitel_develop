import 'dart:async';
import 'dart:math';

import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/networks/model/address_model.dart';
import 'package:bitel_ventas/main/networks/request/search_request.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_advance_search_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_transfer_request_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/event_bus.dart';
import 'package:bitel_ventas/main/utils/provider/search_request_provider.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

class DialogAdvancedSearchPage extends GetWidget {
  final Function(SearchRequest model)? onSubmit;
  SearchRequest searchRequest;
  DialogAdvancedSearchPage({super.key, this.onSubmit, required this.searchRequest});



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogAdvanceSearchLogic(searchRequest),
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
                              function: (value) {
                                controller.setService(value);
                              },
                              dropValue: controller.searchRequest.service,
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
                              controlTextField: controller.controllerCode,
                              function: (value) {
                                controller.setRequestCode(value);
                              },
                              dropValue:"",
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
                              dropValue: controller.searchRequest.status,
                              function: (value) {
                                controller.setStatus(value);
                              },
                              listDrop: controller.searchRequest.listStatus))
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
                          child:   InkWell(
                            onTap: () {
                              if(controller.listProvince.isEmpty){
                                _onLoading(context);
                                controller.getListProvince((isSuccess) {
                                  Get.back();
                                },);
                              }
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: Color(0xFFE3EAF2))),
                              child: DropdownButtonFormField2(
                                autofocus: true,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                ),
                                // selectedItemHighlightColor: Colors.red,
                                buttonHeight: 60,
                                buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                                dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(color: Color(0xFFE3EAF2))),
                                isExpanded: true,
                                // value: controller.currentProvince.name!.isNotEmpty ? controller.currentProvince.name! : null,
                                onChanged: (value) {
                                  controller.setProvince(value!.areaCode!);
                                },

                                items: controller.listProvince.map<DropdownMenuItem<AddressModel>>((AddressModel value) {
                                  return DropdownMenuItem(value: value, child: Text(value.name!));
                                }).toList(),
                                style: AppStyles.r2.copyWith(
                                    color: AppColors.colorTitle, fontWeight: FontWeight.w500),
                                icon: SvgPicture.asset(AppImages.icDropdownSpinner),
                                hint: Text(
                                  AppLocalizations.of(context)!
                                      .hintProvince,
                                  style: AppStyles.r2.copyWith(
                                      color: AppColors.colorHint1, fontWeight: FontWeight.w400),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return AppLocalizations.of(context)!.textPleaseSelect;
                                  }
                                },

                              ),
                            ),
                          ))
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
                              dropValue: "",
                              controlTextField: controller.controllerStaffCode,
                              function: (value) {
                                controller.setStaffCode(value);
                              },
                              listDrop: []))
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
                      Future.delayed(Duration(milliseconds: 600));
                      if(controller.checkValidate()) {
                        Get.back();
                        onSubmit!.call(controller.searchRequest);
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
