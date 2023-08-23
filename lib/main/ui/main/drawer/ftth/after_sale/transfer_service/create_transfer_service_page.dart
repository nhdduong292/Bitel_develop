import 'package:bitel_ventas/main/networks/model/reasons_cancel_service_model.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../../../networks/model/address_model.dart';
import '../../../../../../router/route_config.dart';
import '../../../../../../utils/common.dart';
import '../../../request/create_request/create_request_policy_page.dart';
import '../../../request/create_request/dialog_survey_map_page.dart';
import '../dialog_cancel_service/dialog_cancel_service.dart';
import 'create_transfer_service_logic.dart';

class CreateTransferServicePage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: CreateTransferServiceLogic(context: context),
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
                    child: Text(
                        AppLocalizations.of(context)!.textTransferService,
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
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, bottom: 5),
                      child: Text(
                        AppLocalizations.of(context)!
                            .textCurrentInstallationAddress,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Barlow',
                            fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25, left: 25),
                      child: RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.textArea,
                          style: AppStyles.r1
                              .copyWith(fontWeight: FontWeight.w500),
                          // ignore: prefer_const_literals_to_create_immutables
                        ),
                      ),
                    ),
                    addressBox(
                        content:
                            controller.findAccountModel.getInstalAddress()),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 0, right: 25, left: 25),
                      child: RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.textAddress,
                          style: AppStyles.r1
                              .copyWith(fontWeight: FontWeight.w500),
                          // ignore: prefer_const_literals_to_create_immutables
                        ),
                      ),
                    ),
                    addressBox(content: controller.findAccountModel.address),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, bottom: 5),
                      child: Text(
                        AppLocalizations.of(context)!
                            .textNewInstallationAddress,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Barlow',
                            fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 25, left: 25, bottom: 10),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 25, left: 25),
                      child: SizedBox(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 10, right: 25, left: 25),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 25, left: 25),
                      child: SizedBox(
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    formDateView(
                        controller: controller,
                        context: context,
                        hint: AppLocalizations.of(context)!.textEnterDate,
                        label: AppLocalizations.of(context)!
                            .textScheduledDateOTransfer,
                        content: controller.cancelDate,
                        required: true,
                        isIcon: true,
                        width: width * 0.5),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.textReasonOfTransfer}:",
                            style: AppStyles.r2B3A4A_12_500.copyWith(
                                fontSize: 14,
                                color:
                                    AppColors.color_2B3A4A.withOpacity(0.85)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          spinnerFormV2(
                              fontSize: 14,
                              isMaxlenght: true,
                              context: context,
                              hint: AppLocalizations.of(context)!.hintNote,
                              required: false,
                              dropValue: "",
                              function: (value) {
                                controller.setNote(value);
                              },
                              listDrop: [],
                              controlTextField: controller.tfNote,
                              height: 100)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    bottomButton(
                      isBoxShadow: true,
                      color: !controller.checkActiveContinue()
                          ? Colors.white
                          : AppColors.colorButton,
                      text: AppLocalizations.of(context)!
                          .textContinue
                          .toUpperCase(),
                      onTap: () {
                        if (!controller.checkActiveContinue()) {
                          return;
                        }
                        controller.createTransfer((isSuccess) {
                          if (isSuccess) {
                            showDialogSurveyMap(context, controller);
                          }
                        });
                      },
                    )
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }

  void showDialogSurveyMap(
      BuildContext context, CreateTransferServiceLogic controller) {
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

  _selectDate(BuildContext context, CreateTransferServiceLogic control,
      bool from) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: control.cancelDate.isNotEmpty
          ? control.datePicker!
          : control.getCurrentDate(),
      firstDate: DateTime.now(),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 14),
    );
    if (picked != null) {
      if (from) {
        control.setFromDate(picked);
      } else {
        control.setToDate(picked);
      }
    }
  }

  Widget addressBox({required String content}) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: Container(
          height: 45,
          padding: const EdgeInsets.only(left: 18, right: 7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE3EAF2), width: 1)),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    content,
                    style: AppStyles.r2B3A4A_12_500.copyWith(
                        fontSize: 14,
                        color: AppColors.color_2B3A4A.withOpacity(0.85)),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
