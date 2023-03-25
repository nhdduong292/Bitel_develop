import 'dart:async';
import 'dart:math';

import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/networks/model/address_model.dart';
import 'package:bitel_ventas/main/networks/request/search_request.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/dialog_address_page.dart';
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

  DialogAdvancedSearchPage(
      {super.key, this.onSubmit, required this.searchRequest});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogAdvanceSearchLogic(context, searchRequest),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Stack(
                      children: [
                        Center(
                            child: Text(
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
                    padding:
                        const EdgeInsets.only(top: 16, right: 16, left: 16),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              AppLocalizations.of(context)!.textTelecomService,
                              style: AppStyles.r8.copyWith(
                                  color: AppColors.colorText1.withOpacity(0.85),
                                  fontWeight: FontWeight.w400),
                            )),
                        Expanded(
                            flex: 5,
                            child: spinnerFormV2(
                                context: context,
                                hint: AppLocalizations.of(context)!
                                    .hintTelecomService,
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
                    padding:
                        const EdgeInsets.only(top: 16, right: 16, left: 16),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              AppLocalizations.of(context)!.textRequestCode,
                              style: AppStyles.r8.copyWith(
                                  color: AppColors.colorText1.withOpacity(0.85),
                                  fontWeight: FontWeight.w400),
                            )),
                        Expanded(
                            flex: 5,
                            child: spinnerFormV2(
                                context: context,
                                hint: AppLocalizations.of(context)!
                                    .hintRequestCode,
                                required: false,
                                controlTextField: controller.controllerCode,
                                function: (value) {
                                  controller.setRequestCode(value);
                                },
                                dropValue: "",
                                listDrop: []))
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 16, right: 16, left: 16),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              AppLocalizations.of(context)!.textStatus,
                              style: AppStyles.r8.copyWith(
                                  color: AppColors.colorText1.withOpacity(0.85),
                                  fontWeight: FontWeight.w400),
                            )),
                        Expanded(
                            flex: 5,
                            child: spinnerFormV2(
                                context: context,
                                hint: AppLocalizations.of(context)!.hintStatus,
                                required: false,
                                dropValue: controller.searchRequest.status,
                                function: (value) {
                                  controller.setStatus(value);
                                },
                                listDrop: controller.searchRequest
                                    .listStatus(context)))
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 16, right: 16, left: 16),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              AppLocalizations.of(context)!.textProvince,
                              style: AppStyles.r8.copyWith(
                                  color: AppColors.colorText1.withOpacity(0.85),
                                  fontWeight: FontWeight.w400),
                            )),
                        Expanded(
                            flex: 5,
                            child: InkWell(
                              onTap: () {
                                if (controller.listProvince.isEmpty) {
                                  _onLoading(context);
                                  controller.getListProvince(
                                    (isSuccess) {
                                      Get.back();
                                      if (isSuccess) {
                                        showDialogAddress(
                                            context,
                                            controller.listProvince,
                                            controller,
                                            0);
                                      }
                                    },
                                  );
                                } else {
                                  showDialogAddress(context,
                                      controller.listProvince, controller, 0);
                                }
                              },
                              child: Container(
                                height: 45,
                                child: TextField(
                                    controller: controller.controllerProvince,
                                    enabled: false,
                                    style: AppStyles.r2.copyWith(
                                        color: AppColors.colorTitle,
                                        fontWeight: FontWeight.w500),
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 10, right: 10),
                                        hintText: AppLocalizations.of(context)!
                                            .textProvince,
                                        hintStyle: AppStyles.r2.copyWith(
                                            color: AppColors.colorHint1,
                                            fontWeight: FontWeight.w400),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color:
                                                    AppColors.colorLineDash)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Colors.redAccent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color:
                                                    AppColors.colorLineDash)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color:
                                                    AppColors.colorLineDash)),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SvgPicture.asset(
                                              AppImages.icDropdownSpinner),
                                        ))),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 16, right: 16, left: 16),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
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
                                controlTextField:
                                    controller.controllerStaffCode,
                                function: (value) {
                                  controller.setStaffCode(value);
                                },
                                listDrop: []))
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 16, right: 16, left: 16),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
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
                                  flex: 1,
                                  child: InkWell(
                                      onTap: () {
                                        _selectDate(context, controller, true);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            border: Border.all(
                                                color:
                                                    const Color(0xFFE3EAF2))),
                                        padding: const EdgeInsets.only(
                                            top: 11,
                                            bottom: 11,
                                            left: 16,
                                            right: 16),
                                        child: Row(
                                          children: [
                                            Visibility(
                                              visible:
                                                  controller.from.value.isEmpty,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: SvgPicture.asset(
                                                    AppImages.icSelectDate),
                                              ),
                                            ),
                                            Text.rich(TextSpan(
                                                style: AppStyles.r2.copyWith(
                                                    color: controller
                                                            .from.value.isEmpty
                                                        ? AppColors.colorHint1
                                                        : AppColors.colorText1,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                children: [
                                                  TextSpan(
                                                    text: controller
                                                            .from.value.isEmpty
                                                        ? AppLocalizations.of(
                                                                context)!
                                                            .textFrom
                                                        : controller.from.value,
                                                  )
                                                ])),
                                          ],
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                      onTap: () {
                                        _selectDate(context, controller, false);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            border: Border.all(
                                                color:
                                                    const Color(0xFFE3EAF2))),
                                        padding: const EdgeInsets.only(
                                            top: 11,
                                            bottom: 11,
                                            left: 16,
                                            right: 16),
                                        child: Row(
                                          children: [
                                            Visibility(
                                              visible:
                                                  controller.to.value.isEmpty,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: SvgPicture.asset(
                                                    AppImages.icSelectDate),
                                              ),
                                            ),
                                            Text.rich(TextSpan(
                                                style: AppStyles.r2.copyWith(
                                                    color: controller
                                                            .to.value.isEmpty
                                                        ? AppColors.colorHint1
                                                        : AppColors.colorText1,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                children: [
                                                  TextSpan(
                                                    text: controller
                                                            .to.value.isEmpty
                                                        ? AppLocalizations.of(
                                                                context)!
                                                            .textTo
                                                        : controller.to.value,
                                                  )
                                                ])),
                                          ],
                                        ),
                                      )),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Future.delayed(const Duration(milliseconds: 600));
                      if (controller.checkValidate(context)) {
                        Get.back();
                        onSubmit!.call(controller.searchRequest);
                      }
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
                        AppLocalizations.of(context)!.textSearch.toUpperCase(),
                        style:
                            AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                      )),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  _selectDate(
      BuildContext context, DialogAdvanceSearchLogic control, bool from) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: control.selectDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (from) {
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

  void showDialogAddress(BuildContext context, List<AddressModel> list,
      DialogAdvanceSearchLogic controll, int position) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogAddressPage(
            list,
            (model) {
              controll.setProvince(model);
            },
          );
        });
  }
}
