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

import '../../../../../networks/model/staff_model.dart';
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
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
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
                              margin: const EdgeInsets.only(top: 20),
                              child: TextField(
                                  maxLength: controller.getMaxLengthIdNumber(
                                      controller.currentIdentityType),
                                  controller: controller.textFieldIdNumber,
                                  keyboardType:
                                      controller.currentIdentityType == 'PP'
                                          ? TextInputType.text
                                          : TextInputType.number,
                                  focusNode: controller.focusIdNumber,
                                  textInputAction: TextInputAction.send,
                                  style: AppStyles.r2.copyWith(
                                      color: AppColors.colorTitle,
                                      fontWeight: FontWeight.w500),
                                  onSubmitted: (value) {
                                    // controller.searchNumberContact(value);
                                  },
                                  onChanged: (value) {
                                    controller.textFieldIdNumber.text =
                                        value.toUpperCase();
                                    controller.textFieldIdNumber.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: controller.textFieldIdNumber
                                                .text.length));
                                    controller.setIdentity(value.toUpperCase());
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
                        child: RichText(
                          text: TextSpan(
                              text: AppLocalizations.of(context)!
                                  .textContactPerson,
                              style: AppStyles.r1
                                  .copyWith(fontWeight: FontWeight.w500),
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Barlow',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
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
                          child: RichText(
                            text: TextSpan(
                                text: AppLocalizations.of(context)!
                                    .textContactPhone,
                                style: AppStyles.r1
                                    .copyWith(fontWeight: FontWeight.w500),
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'Barlow',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          )),
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
                              hintText: AppLocalizations.of(context)!
                                  .hintContactPhone,
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
                          //   highlightColor: Colors.transparent,
                          //   splashColor: Colors.transparent,
                          //   child: SvgPicture.asset(AppImages.icSurveyAddress),
                          //   onTap: () {
                          //     // showDialogSurveyMap(context);
                          //   },
                          // )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: RichText(
                          text: TextSpan(
                              text: AppLocalizations.of(context)!.textArea,
                              style: AppStyles.r1
                                  .copyWith(fontWeight: FontWeight.w500),
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Barlow',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                          height: 45,
                          child: aHeadFieldType(
                              autoFocus: false,
                              hint: AppLocalizations.of(context)!.textEnterArea,
                              controller: controller.textFieldArea,
                              context: context,
                              suggestionsCallback: (pattern) async {
                                print(pattern);
                                controller.listArea.clear();
                                if (pattern.isEmpty) {
                                  return [];
                                }
                                List<AddressModel> list =
                                    await controller.getAreas(pattern);
                                if (list.isEmpty) {
                                  return [
                                    // ignore: use_build_context_synchronously
                                    AppLocalizations.of(context)!
                                        .textAddressNotFound
                                  ];
                                }
                                return list;
                              },
                              itemBuilder: (context, suggestion) {
                                if (suggestion is AddressModel) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(suggestion.fullName),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(suggestion),
                                  );
                                }
                              },
                              onChange: () {
                                controller.currentArea.province = "";
                                controller.currentArea.district = "";
                                controller.currentArea.precinct = "";
                              },
                              onSuggestionSelected: (suggestion) {
                                if (suggestion is AddressModel) {
                                  controller.textFieldArea.text =
                                      suggestion.fullName;
                                  controller.currentArea.province =
                                      suggestion.province;
                                  controller.currentArea.district =
                                      suggestion.district;
                                  controller.currentArea.precinct =
                                      suggestion.precinct;
                                  controller.update();
                                }
                              })),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: RichText(
                          text: TextSpan(
                              text: AppLocalizations.of(context)!.textAddress,
                              style: AppStyles.r1
                                  .copyWith(fontWeight: FontWeight.w500),
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Barlow',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
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
                        child: bottomButton(
                            isBoxShadow: true,
                            color: Colors.white,
                            text: AppLocalizations.of(context)!
                                .textCancel
                                .toUpperCase(),
                            onTap: () {
                              Get.back();
                            })),
                    Expanded(
                        flex: 1,
                        child: bottomButton(
                            text: AppLocalizations.of(context)!
                                .textSurvey
                                .toUpperCase(),
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
                                  }
                                },
                              );
                            }))
                  ],
                ),
                const SizedBox(
                  height: 150,
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
            isTimekeeping: false,
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
}
