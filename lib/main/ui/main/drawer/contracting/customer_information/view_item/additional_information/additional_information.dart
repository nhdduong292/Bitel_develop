// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/customer_information_logic.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../networks/model/address_model.dart';
import '../../../../../../../router/route_config.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';
import '../../../../request/dialog_address_page.dart';

typedef void TouchContinue();

class AdditionalInformationWidget extends GetView<CustomerInformationLogic> {
  final TouchContinue callback;
  CustomerInformationLogic controller;
  AdditionalInformationWidget(
      {required this.controller, required this.callback});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return FocusScope(
      node: controller.focusScopeNode,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFFE3EAF2),
                        width: 1.0,
                      ),
                      boxShadow: [
                        const BoxShadow(
                          color: Color.fromRGBO(185, 212, 220, 0.2),
                          offset: Offset(0, 2),
                          blurRadius: 7.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      SizedBox(
                        height: 20,
                      ),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(26),
                        dashPattern: [2, 2],
                        strokeWidth: 1,
                        color: Color(0xFF9454C9),
                        child: SizedBox(
                          width: 234,
                          height: 41,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: '${controller.getTypeCustomer()} ',
                                      style: AppStyles.r9454C9_14_500.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                          text: controller.customer.idNumber,
                                          style: AppStyles.r2B3A4A_12_500
                                              .copyWith(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400),
                                        )
                                      ]),
                                )
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      inputFormMaxLenght(
                          hint: AppLocalizations.of(context)!
                              .textEnterPhoneNumber,
                          label: AppLocalizations.of(context)!.textPhoneNumber,
                          required: true,
                          maxLength: 9,
                          controller: controller.phoneController,
                          inputType: TextInputType.number,
                          width: 210,
                          onChange: (value) {
                            controller.phone = value;
                            controller.checkChangeAdditionalInformation();
                            controller.showButtonContinue();
                          }),
                      inputFormV3(
                          hint: AppLocalizations.of(context)!.textEnterEmail,
                          label: AppLocalizations.of(context)!.textEmail,
                          required: true,
                          controller: controller.emailController,
                          inputType: TextInputType.text,
                          width: 210,
                          onChange: (value) {
                            controller.email = value;
                            controller.checkChangeAdditionalInformation();
                            controller.showButtonContinue();
                          }),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              controller.resetAdress();
                              return BillAddressInformation(
                                height: 300,
                                controller: controller,
                              );
                            },
                          ).then((value) {
                            controller.checkChangeAdditionalInformation();
                            if (value) {
                              controller.address =
                                  '${controller.currentAddress}, ${controller.currentArea.fullName}';
                              controller.update();
                            }
                          });
                        },
                        child: lockedBox(
                            content: controller.address,
                            label: AppLocalizations.of(context)!
                                .textAddressCustomerInfo,
                            required: true,
                            isIcon: false,
                            width: 210),
                      ),
                      SizedBox(
                        height: 27,
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  customRadioMutiple(
                      width: width,
                      text: AppLocalizations.of(context)!
                          .textUpdateCustomerInformation,
                      check: controller.checkOption,
                      changeValue: (value) {
                        controller.checkOption.value = value;
                        controller.isActiveUpdate = value;
                      }),
                  Visibility(
                    visible: controller.showBypass(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2, right: 20),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          controller.valueCheckBypass =
                              !controller.valueCheckBypass;
                          controller.update();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                activeColor: AppColors.colorText3,
                                value: controller.valueCheckBypass,
                                onChanged: (value) {
                                  controller.valueCheckBypass = value ?? false;
                                  controller.update();
                                }),
                            Text(
                              '${AppLocalizations.of(context)!.textBypassFingerprint}.',
                              style: AppStyles.r2B3A4A_12_500
                                  .copyWith(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.isShowAppointment(),
                    child: customRadioMutiple(
                        width: width,
                        text: AppLocalizations.of(context)!
                            .textScheduleImplementationDate,
                        check: controller.checkAppointmentDate,
                        changeValue: (value) {
                          controller.checkAppointmentDate.value = value;
                          controller.isActiveUpdate = value;
                        }),
                  ),
                  Obx(() => Visibility(
                        visible: controller.checkAppointmentDate.value,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            formDateView(
                                controller: controller,
                                context: context,
                                hint:
                                    AppLocalizations.of(context)!.textEnterDate,
                                label:
                                    AppLocalizations.of(context)!.textDateTime,
                                content: controller.appointmentDate,
                                required: true,
                                isIcon: true,
                                width: width * 0.5),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 18, right: 18),
                              width: width - 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .textReason,
                                      style: AppStyles.r2B3A4A_12_500.copyWith(
                                          fontSize: 14,
                                          color: AppColors.color_2B3A4A
                                              .withOpacity(0.85)),
                                      children: [
                                        TextSpan(
                                            text: ' *',
                                            style: const TextStyle(
                                              color: AppColors.colorTextError,
                                              fontFamily: 'Barlow',
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  spinnerFormV2(
                                      fontSize: 14,
                                      focusNode: controller.appointmenFocusNode,
                                      isMaxlenght: true,
                                      context: context,
                                      hint: AppLocalizations.of(context)!
                                          .hintNote,
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
                          ],
                        ),
                      )),
                  SizedBox(
                      width: width,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: bottomButtonV2(
                                  onTap: () {
                                    Get.back();
                                  },
                                  text: AppLocalizations.of(context)!
                                      .textCancel
                                      .toUpperCase())),
                          Expanded(
                              flex: 1,
                              child: bottomButton(
                                onTap: () {
                                  if (controller.checkValidateAddInfo()) {
                                    return;
                                  }
                                  if (!controller.checkValidate()) {
                                    return;
                                  }
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  if (controller.isActiveUpdate &&
                                      controller
                                          .checkChangeAdditionalInformation()) {
                                    controller.updateCustomer((isSuccess) {
                                      if (isSuccess) {
                                        Common.showToastCenter(
                                            AppLocalizations.of(context)!
                                                .textUpdateCustomerInformationSuccessfully,
                                            context);
                                        if (controller.valueCheckBypass &&
                                            controller.showBypass()) {
                                          controller.checkBypass((isSuccess) {
                                            if (isSuccess) {
                                              callback();
                                            }
                                          });
                                        } else {
                                          callback();
                                        }
                                      } else {}
                                    });
                                  } else {
                                    if (controller.valueCheckBypass &&
                                        controller.showBypass()) {
                                      controller.checkBypass((isSuccess) {
                                        if (isSuccess) {
                                          callback();
                                        }
                                      });
                                    } else {
                                      callback();
                                    }
                                  }
                                },
                                color: !controller.isActiveContinue
                                    ? const Color(0xFF415263).withOpacity(0.2)
                                    : null,
                                text: AppLocalizations.of(context)!
                                    .textContinue
                                    .toUpperCase(),
                              )),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Widget lockedBoxV1(
      {required String label,
      required String content,
      required bool required,
      required bool isIcon,
      required double width}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: label,
                style: AppStyles.r2B3A4A_12_500
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                      text: required ? ' *' : '',
                      style: TextStyle(
                        color: AppColors.colorTextError,
                        fontFamily: 'Barlow',
                        fontSize: 14,
                      )),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Container(
              height: 45,
              width: width,
              padding: EdgeInsets.only(left: 18, right: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Color(0xFFE3EAF2), width: 1)),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        content,
                        style: TextStyle(
                            fontFamily: 'Barlow',
                            color: Color(0xFF415263),
                            fontWeight: FontWeight.w500,
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: isIcon,
                      child: SvgPicture.asset(AppImages.icArrowDownLockedBox))
                ],
              )),
        ),
      ],
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
            left: 18,
            right: 18,
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
                _selectDate(context, controller, false);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 18,
                  right: 18,
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

  Widget customRadioMutiple(
      {required var width,
      required String text,
      required var check,
      required var changeValue}) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 0),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          changeValue(!check.value);
        },
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Obx(() => check.value
              ? SvgPicture.asset(AppImages.icRadioChecked)
              : SvgPicture.asset(AppImages.icRadioUnChecked)),
          SizedBox(
            width: 10,
          ),
          SizedBox(
              width: width * 0.75,
              child: Text(
                text,
                style: AppStyles.r2B3A4A_12_500.copyWith(fontSize: 14),
              )),
        ]),
      ),
    );
  }

  _selectDate(
      BuildContext context, CustomerInformationLogic control, bool from) async {
    // DateTime firstDate = control.getFirstDate();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: control.appointmentDate.isNotEmpty
          ? control.datePicker!
          : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 200)),
    );
    if (selectedDate == null) return;
    // ignore: use_build_context_synchronously
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );
    DateTime? picked = selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
    if (from) {
      control.setFromDate(picked);
    } else {
      control.setToDate(picked);
    }
  }

  Widget lockedBox(
      {required String label,
      required String content,
      required bool required,
      required bool isIcon,
      required double width}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: label,
                style: TextStyle(
                  color: AppColors.colorText1,
                  fontFamily: 'Barlow',
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                      text: required ? ' *' : '',
                      style: TextStyle(
                        color: AppColors.colorTextError,
                        fontFamily: 'Barlow',
                        fontSize: 14,
                      )),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Container(
              constraints: BoxConstraints(
                minHeight: 45,
              ),
              width: width,
              padding: EdgeInsets.only(left: 13, right: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Color(0xFFE3EAF2), width: 1)),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        content,
                        style: TextStyle(
                            fontFamily: 'Barlow',
                            color: Color(0xFF415263),
                            fontWeight: FontWeight.w500,
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: isIcon,
                      child: SvgPicture.asset(AppImages.icArrowDownLockedBox))
                ],
              )),
        ),
      ],
    );
  }
}

class BillAddressInformation extends Dialog {
  final double height;
  final CustomerInformationLogic controller;
  const BillAddressInformation(
      {super.key, required this.height, required this.controller});

  @override
  Widget build(BuildContext context) {
    controller.currentArea.province = "";
    controller.currentArea.district = "";
    controller.currentArea.precinct = "";
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: 330,
        height: height,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.back(result: false);
                  },
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SvgPicture.asset(AppImages.icClose),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: RichText(
                    text: TextSpan(
                        text: AppLocalizations.of(context)!.textArea,
                        style:
                            AppStyles.r1.copyWith(fontWeight: FontWeight.w500),
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
                        autoFocus: true,
                        hint: AppLocalizations.of(context)!.textEnterArea,
                        controller: controller.textFieldArea,
                        context: context,
                        suggestionsCallback: (pattern) async {
                          controller.listArea.clear();
                          if (pattern.isEmpty) {
                            return [];
                          }
                          List<AddressModel> list =
                              await controller.getAreas(pattern);
                          if (list.isEmpty) {
                            return [
                              // ignore: use_build_context_synchronously
                              AppLocalizations.of(context)!.textAddressNotFound
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
                            controller.textFieldArea.text = suggestion.fullName;
                            controller.currentArea.fullName =
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
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                  child: Text(
                    AppLocalizations.of(context)!.textAddress,
                    style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),
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
                        contentPadding:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
                        hintText: AppLocalizations.of(context)!.hintAddress,
                        hintStyle: AppStyles.r2.copyWith(
                            color: AppColors.colorHint1,
                            fontWeight: FontWeight.w400),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.colorLineDash)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.redAccent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.colorLineDash)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.colorLineDash)),
                      )),
                ),
                bottomButton(
                  onTap: () {
                    if (controller.validateAddress()) {
                      Get.back(result: true);
                    }
                  },
                  text:
                      AppLocalizations.of(context)!.textContinue.toUpperCase(),
                  // color: !controller.isValidateAddress
                  //     ? const Color(0xFF415263).withOpacity(0.2)
                  //     : null
                ),
              ],
            ),
          ),
        ),
      ),
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
