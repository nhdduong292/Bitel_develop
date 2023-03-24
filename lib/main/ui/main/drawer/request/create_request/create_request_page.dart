import 'dart:async';

import 'package:bitel_ventas/main/networks/model/address_model.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/create_request_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/create_request_policy_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_map_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_map_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_successful.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/dialog_address_page.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dialog_survey_unsuccesful.dart';

class CreateRequestPage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: CreateRequestLogic(context: context),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.only(left: 18, bottom: 18, top: 2),
              child: GestureDetector(
                child: SvgPicture.asset(AppImages.icBack),
                onTap: () {
                  Get.back();
                },
              ),
            ),
            elevation: 0.0,
            title: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(AppLocalizations.of(context)!.textCreateNewRequest,
                  style: AppStyles.title),
            ),
            toolbarHeight: 100,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: AppColors.colorBackground,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(width / 2, 20),
                      bottomRight: Radius.elliptical(width / 2, 20))),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      top: 20, left: 10, right: 10, bottom: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
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
                                            ..onTap = () => Get.to(
                                                CreateRequestPolicyPage()),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: Text(
                          AppLocalizations.of(context)!.textChooseService,
                          style: AppStyles.r1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      spinnerFormV2(
                          context: context,
                          hint: AppLocalizations.of(context)!.textChooseService,
                          required: false,
                          dropValue: controller.currentService,
                          function: (value) {
                            controller.setService(value);
                          },
                          listDrop: controller.listService),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: Text(
                          AppLocalizations.of(context)!.textIdentityNumber,
                          style: AppStyles.r1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: spinnerFormV2(
                                  context: context,
                                  hint: AppLocalizations.of(context)!
                                      .hintIdentityNumber,
                                  required: false,
                                  dropValue: controller.currentIdentityType,
                                  function: (value) {
                                    controller.setIdentityType(value);
                                  },
                                  listDrop: controller.listIdentity)),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: const EdgeInsets.only(top: 14),
                              child: TextField(
                                  maxLength: controller.getMaxLengthIdNumber(
                                      controller.currentIdentityType),
                                  controller: controller.textFieldIdNumber,
                                  keyboardType: TextInputType.number,
                                  focusNode: controller.focusIdNumber,
                                  textInputAction: TextInputAction.send,
                                  style: AppStyles.r2.copyWith(
                                      color: AppColors.colorTitle,
                                      fontWeight: FontWeight.w500),
                                  onSubmitted: (value) {
                                    // controller.searchNumberContact(value);
                                  },
                                  onChanged: (value) {
                                    controller.setIdentity(value);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
                                    hintText: AppLocalizations.of(context)!
                                        .hintIdentityNumber,
                                    hintStyle: AppStyles.r2.copyWith(
                                        color: AppColors.colorHint1,
                                        fontWeight: FontWeight.w400),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColors.colorLineDash)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.redAccent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColors.colorLineDash)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColors.colorLineDash)),
                                  )),
                            ),
                          )
                        ],
                      ),
                      controller.isAddContact
                          ? Container()
                          : Container(
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.centerRight,
                              child: Text(
                                  style: AppStyles.r1.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.colorTitle,
                                      decoration: TextDecoration.underline),
                                  AppLocalizations.of(context)!
                                      .textAddNewContact
                                      .toUpperCase()),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: Text(
                          AppLocalizations.of(context)!.textContactPerson,
                          style: AppStyles.r1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        height: 45,
                        child: TextField(
                            controller: controller.textFieldName,
                            focusNode: controller.focusName,
                            style: AppStyles.r2.copyWith(
                                color: AppColors.colorTitle,
                                fontWeight: FontWeight.w500),
                            onChanged: (value) {
                              controller.setName(value);
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  top: 5, left: 10, right: 10),
                              hintText: AppLocalizations.of(context)!
                                  .hintContactPerson,
                              hintStyle: AppStyles.r2.copyWith(
                                  color: AppColors.colorHint1,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.colorLineDash)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.redAccent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.colorLineDash)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.colorLineDash)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: Text(
                          AppLocalizations.of(context)!.textContactPhone,
                          style: AppStyles.r1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        child: TextField(
                            keyboardType: TextInputType.number,
                            focusNode: controller.focusPhone,
                            controller: controller.textFieldPhone,
                            style: AppStyles.r2.copyWith(
                                color: AppColors.colorTitle,
                                fontWeight: FontWeight.w500),
                            onChanged: (value) {
                              controller.setPhone(value);
                            },

                            maxLength: 9,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  top: 5, left: 10, right: 10),
                              hintText: "${AppLocalizations.of(context)!
                                  .textContactPhone} *",
                              hintStyle: AppStyles.r2.copyWith(
                                  color: AppColors.colorHint1,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.colorLineDash)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.redAccent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.colorLineDash)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.colorLineDash)),
                            )),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: Text(
                              AppLocalizations.of(context)!.textSurveyAddress,
                              style: AppStyles.r1
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // InkWell(
                          //   child: SvgPicture.asset(AppImages.icSurveyAddress),
                          //   onTap: () {
                          //     // showDialogSurveyMap(context);
                          //   },
                          // )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: Text(
                          AppLocalizations.of(context)!.textProvince,
                          style: AppStyles.r1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.listProvince.isEmpty) {
                            _onLoading(context);
                            controller.getListProvince(
                              (isSuccess) {
                                Get.back();
                                if (isSuccess) {
                                  showDialogAddress(context,
                                      controller.listProvince, controller, 0);
                                }
                              },
                            );
                          } else {
                            showDialogAddress(context, controller.listProvince,
                                controller, 0);
                          }
                        },
                        child: Container(
                          height: 45,
                          child: TextField(
                              controller: controller.textFieldProvince,
                              focusNode: controller.focusProvince,
                              enabled: false,
                              style: AppStyles.r2.copyWith(
                                  color: AppColors.colorTitle,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 10),
                                  hintText: AppLocalizations.of(context)!
                                      .hintProvince,
                                  hintStyle: AppStyles.r2.copyWith(
                                      color: AppColors.colorHint1,
                                      fontWeight: FontWeight.w400),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.colorLineDash)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.redAccent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.colorLineDash)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.colorLineDash)),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                        AppImages.icDropdownSpinner),
                                  ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: Text(
                          AppLocalizations.of(context)!.textDistrict,
                          style: AppStyles.r1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.currentProvince.areaCode.isNotEmpty) {
                            if (controller.listDistrict.isEmpty) {
                              _onLoading(context);
                              controller.getListDistrict(
                                controller.currentProvince.areaCode,
                                (isSuccess) {
                                  Get.back();
                                  if (isSuccess) {
                                    showDialogAddress(context,
                                        controller.listDistrict, controller, 1);
                                  }
                                },
                              );
                            } else {
                              showDialogAddress(context,
                                  controller.listDistrict, controller, 1);
                            }
                          } else {
                            // Get.snackbar("Thông báo", "Bạn phải chọn Province trước", snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                        child: Container(
                          height: 45,
                          child: TextField(
                              controller: controller.textFieldDistrict,
                              focusNode: controller.focusDistrict,
                              enabled: false,
                              style: AppStyles.r2.copyWith(
                                  color: AppColors.colorTitle,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 10),
                                  hintText: AppLocalizations.of(context)!
                                      .hintDistrict,
                                  hintStyle: AppStyles.r2.copyWith(
                                      color: AppColors.colorHint1,
                                      fontWeight: FontWeight.w400),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.colorLineDash)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.redAccent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.colorLineDash)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.colorLineDash)),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                        AppImages.icDropdownSpinner),
                                  ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: Text(
                          AppLocalizations.of(context)!.textPrecinct,
                          style: AppStyles.r1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.currentDistrict.areaCode.isNotEmpty) {
                            if (controller.listPrecinct.isEmpty) {
                              _onLoading(context);
                              controller.getListPrecincts(
                                controller.currentDistrict.areaCode,
                                (isSuccess) {
                                  Get.back();
                                  if (isSuccess) {
                                    showDialogAddress(context,
                                        controller.listPrecinct, controller, 2);
                                  }
                                },
                              );
                            } else {
                              showDialogAddress(context,
                                  controller.listPrecinct, controller, 2);
                            }
                          } else {
                            // Get.snackbar("Thông báo", "Bạn phải chọn District trước", snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                        child: Container(
                          height: 45,
                          child: TextField(
                              controller: controller.textFieldPrecinct,
                              focusNode: controller.focusPrecinct,
                              enabled: false,
                              style: AppStyles.r2.copyWith(
                                  color: AppColors.colorTitle,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 10),
                                  hintText: AppLocalizations.of(context)!
                                      .hintPrecinct,
                                  hintStyle: AppStyles.r2.copyWith(
                                      color: AppColors.colorHint1,
                                      fontWeight: FontWeight.w400),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.colorLineDash)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.redAccent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.colorLineDash)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.colorLineDash)),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                        AppImages.icDropdownSpinner),
                                  ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: Text(
                          AppLocalizations.of(context)!.textAddress,
                          style: AppStyles.r1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        height: 45,
                        child: TextField(
                            focusNode: controller.focusAddress,
                            controller: controller.textFieldAddress,
                            style: AppStyles.r2.copyWith(
                                color: AppColors.colorTitle,
                                fontWeight: FontWeight.w500),
                            onChanged: (value) {
                              controller.setAddress(value);
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  top: 5, left: 10, right: 10),
                              hintText:
                                  AppLocalizations.of(context)!.hintAddress,
                              hintStyle: AppStyles.r2.copyWith(
                                  color: AppColors.colorHint1,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.colorLineDash)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.redAccent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.colorLineDash)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.colorLineDash)),
                            )),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              top: 30, left: 25, right: 5),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 2,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                                child: Text(
                              AppLocalizations.of(context)!
                                  .textCancel
                                  .toUpperCase(),
                              style: AppStyles.r1
                                  .copyWith(fontWeight: FontWeight.w500),
                            )),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            if (controller.checkValidateCreate(context)) {
                              return;
                            }
                            _onLoading(context);
                            controller.createRequest(
                              (isSuccess, model) {
                                Get.back();
                                if (isSuccess) {
                                  showDialogSurveyMap(context, controller);
                                } else {
                                  Common.showToastCenter(
                                      AppLocalizations.of(context)!
                                          .textErrorAPI);
                                }
                              },
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                top: 30, left: 5, right: 25),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: AppColors.colorButton,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                                child: Text(
                              AppLocalizations.of(context)!
                                  .textSurvey
                                  .toUpperCase(),
                              style: AppStyles.r5
                                  .copyWith(fontWeight: FontWeight.w500),
                            )),
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showDialogSurveySuccessful(
      BuildContext context, CreateRequestLogic controller) {
    // showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (context) {
    //       return DialogSurveySuccessful(
    //         onSubmit: (isOnline) {
    //           _onLoading(context);
    //           if (isOnline) {
    //             controller.createSurveyOnline(
    //               (isSuccess) {
    //                 if (isSuccess) {
    //                   //   Get.back();
    //                   //   DialogSurveyMapLogic surveyMapLogic = Get.find();
    //                   //   surveyMapLogic.setStateConnect(true);
    //                   Get.close(3);
    //                   // Get.toNamed(RouteConfig.productPayment,
    //                   //     arguments: controller.requestModel.id);
    //                   Get.toNamed(RouteConfig.productPayment,
    //                       arguments: [
    //                         controller.requestModel.id,
    //                         controller.requestModel.identityType
    //                       ]);
    //                 } else {
    //                   Get.back();
    //                 }
    //               },
    //             );
    //           } else {
    //             controller.createSurveyOffline(
    //               (isSuccess) {
    //
    //                 if (isSuccess) {
    //                   Get.close(3);
    //                   // DialogSurveyMapLogic surveyMapLogic = Get.find();
    //                   // surveyMapLogic.setStateConnect(true);
    //                   Get.toNamed(RouteConfig.listRequest, arguments: 1);
    //                 } else {
    //                   Get.back();
    //                 }
    //
    //               },
    //             );
    //           }
    //         },
    //       );
    //     });
  }

  void showDialogSurveyUnsuccessful(
      BuildContext context, CreateRequestLogic controller) {
    // showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (context) {
    //       return DialogSurveyUnsuccessful(
    //         onSubmit: (){
    //             _onLoading(context);
    //             controller.createSurveyOffline((isSuccess) {
    //               if(isSuccess){
    //                 Get.close(3);
    //                 // DialogSurveyMapLogic surveyMapLogic = Get.find();
    //                 // surveyMapLogic.setStateConnect(true);
    //                 Get.toNamed(RouteConfig.listRequest, arguments: 1);
    //               } else {
    //                 Get.back();
    //               }
    //             },);
    //         },);
    //     });
  }

  void showDialogSurveyMap(
      BuildContext context, CreateRequestLogic controller) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogSurveyMapPage(
            onSubmit: (isSuccess) {
              // if(isSuccess) {
              //   showDialogSurveySuccessful(context, controller);
              // } else {
              //   showDialogSurveyUnsuccessful(context, controller);
              // }
            },
            requestModel: controller.requestModel,
          );
        });
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
      CreateRequestLogic controll, int position) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogAddressPage(
            list,
            (model) {
              if (position == 0) {
                controll.setProvince(model);
              } else if (position == 1) {
                controll.setDistrict(model);
              } else if (position == 2) {
                controll.setPrecinct(model);
              }
            },
          );
        });
  }
}
