// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../networks/model/address_model.dart';
import '../../../../../../../router/route_config.dart';
import '../../../../../../../utils/common_widgets.dart';
import '../../../../request/dialog_address_page.dart';
import 'client_data_dni_logic.dart';

typedef void TouchUpadte();

class ClientDataDNIWidget extends GetView<ClientDataDNILogic> {
  final TouchUpadte callback;
  ClientDataDNIWidget({required this.callback});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: ClientDataDNILogic(context: context),
        builder: (controller) {
          return FocusScope(
            node: controller.focusScopeNode,
            child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        child: Column(children: [
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 30,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .textInformacionDel,
                                style: AppStyles.r00A5B1_13_500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DottedLine(
                            dashColor: Color(0xFFE3EAF2),
                            dashGapLength: 3,
                            dashLength: 4,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(26),
                            dashPattern: [2, 2],
                            strokeWidth: 1,
                            color: Color(0xFF9454C9),
                            child: SizedBox(
                              width: 197,
                              height: 39,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      '${controller.logicCreateContact.typeCustomer}: ',
                                      style: AppStyles.r9454C9_14_500.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    // Text(
                                    //   controller.idNumber,
                                    //   style: AppStyles.r2B3A4A_12_500.copyWith(
                                    //       fontSize: 13,
                                    //       fontWeight: FontWeight.w400),
                                    // ),
                                    Expanded(
                                      child: SizedBox(
                                        child: TextField(
                                            keyboardType: controller
                                                        .logicCreateContact
                                                        .typeCustomer ==
                                                    'CE'
                                                ? TextInputType.number
                                                : TextInputType.text,
                                            controller: controller.tfIdNumber,
                                            focusNode: controller.fcIdNumber,
                                            style: AppStyles.r2B3A4A_12_500
                                                .copyWith(
                                                    fontSize: 13,
                                                    color: AppColors
                                                        .color_2B3A4A
                                                        .withOpacity(0.85)),
                                            onChanged: (value) {
                                              controller.tfIdNumber.text =
                                                  value.toUpperCase();
                                              controller.tfIdNumber.selection =
                                                  TextSelection.fromPosition(
                                                      TextPosition(
                                                          offset: controller
                                                              .tfIdNumber
                                                              .text
                                                              .length));
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 5,
                                                      left: 5,
                                                      right: 10),
                                              // hintText: 'hint',
                                              hintStyle: AppStyles.r2.copyWith(
                                                  color: AppColors.colorHint1,
                                                  fontWeight: FontWeight.w400),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                            )),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 39,
                          ),
                          Column(
                            children: [
                              textFieldClient(
                                  context: context,
                                  label: AppLocalizations.of(context)!
                                      .textLastFatherName,
                                  hint: AppLocalizations.of(context)!
                                      .textEnterName,
                                  width: width * 0.55,
                                  controller: controller.tfLastName,
                                  focusNode: controller.focusLastName,
                                  onChange: (value) {
                                    controller.updateFullName();
                                  }),
                              SizedBox(
                                height: 16,
                              ),
                              textFieldClient(
                                  context: context,
                                  label: AppLocalizations.of(context)!
                                      .textLastMotherName,
                                  hint: AppLocalizations.of(context)!
                                      .textEnterName,
                                  width: width * 0.55,
                                  controller: controller.tfMidelName,
                                  focusNode: controller.focusLastName,
                                  onChange: (value) {
                                    controller.updateFullName();
                                  }),
                              SizedBox(
                                height: 16,
                              ),
                              textFieldClient(
                                  context: context,
                                  label: AppLocalizations.of(context)!.textName,
                                  hint: AppLocalizations.of(context)!
                                      .textEnterName,
                                  width: width * 0.55,
                                  controller: controller.tfName,
                                  focusNode: controller.focusLastName,
                                  onChange: (value) {
                                    controller.updateFullName();
                                  }),
                              SizedBox(
                                height: 16,
                              ),
                              textFieldClient(
                                  context: context,
                                  label: AppLocalizations.of(context)!
                                      .textFullName,
                                  hint: AppLocalizations.of(context)!
                                      .textEnterName,
                                  width: width * 0.55,
                                  controller: controller.tfFullName,
                                  focusNode: controller.focusLastName,
                                  onChange: (value) {}),
                              SizedBox(
                                height: 16,
                              ),
                              textFieldClient(
                                  context: context,
                                  label: AppLocalizations.of(context)!
                                      .textNationality,
                                  hint: AppLocalizations.of(context)!
                                      .textEnterNationality,
                                  width: width * 0.55,
                                  controller: controller.tfNationality,
                                  focusNode: controller.focusLastName,
                                  onChange: (value) {}),
                              SizedBox(
                                height: 16,
                              ),
                              formDateView(
                                  context: context,
                                  type: 1,
                                  hint: AppLocalizations.of(context)!
                                      .textEnterDate,
                                  label: AppLocalizations.of(context)!
                                      .textDateOfBirth,
                                  content: controller.dob,
                                  required: false,
                                  isIcon: true,
                                  width: width * 0.55),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(left: 20),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .textSex,
                                            style: AppStyles.r2B3A4A_12_500
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: AppColors
                                                        .color_2B3A4A
                                                        .withOpacity(0.85)))),
                                  ),
                                  SizedBox(
                                    width: width * 0.55,
                                    child: spinnerFormV2(
                                        context: context,
                                        hint: '',
                                        required: true,
                                        dropValue: controller.sexValue,
                                        function: (value) {
                                          controller.sexValue = value;
                                        },
                                        listDrop: controller.sexs),
                                  ),
                                  SizedBox(
                                    width: 23,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              formDateView(
                                  context: context,
                                  type: 2,
                                  hint: AppLocalizations.of(context)!
                                      .textEnterDate,
                                  label: AppLocalizations.of(context)!
                                      .textDateOfIssue,
                                  content: controller.issue,
                                  required: false,
                                  isIcon: true,
                                  width: width * 0.55),
                              SizedBox(
                                height: 16,
                              ),
                              formDateView(
                                  context: context,
                                  type: 3,
                                  hint: AppLocalizations.of(context)!
                                      .textEnterDate,
                                  label: AppLocalizations.of(context)!
                                      .textExpiredDate,
                                  content: controller.exd,
                                  required: false,
                                  isIcon: true,
                                  width: width * 0.55),
                              // InkWell(
                            // highlightColor: Colors.transparent,
                            // splashColor: Colors.transparent,
                              //   onTap: () {
                              //     showDialog(
                              //       barrierDismissible: false,
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         controller.resetAdress();
                              //         return BillAddressInformation(
                              //           height: 450,
                              //           controller: controller,
                              //         );
                              //       },
                              //     ).then((value) {
                              //       // controller.checkChangeAdditionalInformation();
                              //       if (value) {
                              //         controller.address =
                              //             '${controller.currentAddress}, ${controller.currentPrecinct.name}, ${controller.currentDistrict.name}, ${controller.currentProvince.name}';
                              //         controller.update();
                              //       }
                              //     });
                              //   },
                              //   child: lockedBoxV1(
                              //       content: controller.address,
                              //       label: AppLocalizations.of(context)!
                              //           .textAddress,
                              //       required: false,
                              //       isIcon: false,
                              //       width: width * 0.55),
                              // ),
                              SizedBox(
                                height: 34,
                              ),
                            ],
                          )
                        ]),
                      ),
                      Container(
                        width: 310,
                        margin: EdgeInsets.only(
                            top: 30, bottom: 36, left: 16, right: 16),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.colorButton,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (!controller.checkValidate()) {
                              return;
                            }
                            controller.createBodyCustomer();
                            controller.checkFingerExit((isSuccess) {
                              if (isSuccess) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SuccessDialog(
                                      height: 299,
                                      isSuccess: true,
                                      onClick: () {
                                        Get.back();
                                        Get.offNamed(
                                            RouteConfig.customerInformation,
                                            arguments: [
                                              controller.customerModel,
                                              controller.logicCreateContact
                                                  .requestModel,
                                              controller.productId,
                                              controller.reasonId,
                                              controller.isForcedTerm,
                                              controller.listPromotionId,
                                              controller.packageId
                                            ]);
                                      },
                                    );
                                  },
                                );
                              } else {
                                callback();
                              }
                            });
                            return;
                          },
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context)!.textRegistrar,
                            style: AppStyles.r5
                                .copyWith(fontWeight: FontWeight.w500),
                          )),
                        ),
                      )
                    ]),
              ),
            ),
          );
        });
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
                style: AppStyles.r2B3A4A_12_500.copyWith(
                    fontSize: 14,
                    color: AppColors.color_2B3A4A.withOpacity(0.8)),
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
          margin: EdgeInsets.only(left: 15, right: 23, top: 15),
          child: Container(
              constraints: BoxConstraints(
                minHeight: 45,
              ),
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
                        style: AppStyles.r2B3A4A_12_500.copyWith(
                            fontSize: 14,
                            color: AppColors.color_2B3A4A.withOpacity(0.85)),
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

  Widget textFieldClient(
      {required BuildContext context,
      required String label,
      required double width,
      required String hint,
      required TextEditingController controller,
      FocusNode? focusNode,
      required onChange}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(label,
                  style: AppStyles.r2B3A4A_12_500.copyWith(
                      fontSize: 14,
                      color: AppColors.color_2B3A4A.withOpacity(0.8)))),
        ),
        SizedBox(
          width: width,
          height: 45,
          child: TextField(
              controller: controller,
              focusNode: null,
              style: AppStyles.r2B3A4A_12_500.copyWith(
                  fontSize: 14,
                  color: AppColors.color_2B3A4A.withOpacity(0.85)),
              onChanged: (value) {
                onChange(value);
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(top: 5, left: 18, right: 10),
                hintText: hint,
                hintStyle: AppStyles.r2.copyWith(
                    color: AppColors.colorHint1, fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                        width: 1, color: AppColors.colorLineDash)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.redAccent)),
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
        SizedBox(
          width: 23,
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
      required double width,
      required int type}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: 20,
            ),
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: label,
                style: AppStyles.r2B3A4A_12_500.copyWith(
                    fontSize: 14,
                    color: AppColors.color_2B3A4A.withOpacity(0.85)),
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
        InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
          onTap: () {
            controller.typeDate = type;
            if (type == 1) {
              controller.setDefaultDob();
            } else {
              controller.setDateNow();
            }
            _selectDate(context, controller, false);
          },
          child: Container(
            margin: EdgeInsets.only(
              left: 15,
              right: 23,
            ),
            child: Container(
                height: 45,
                width: width,
                padding: EdgeInsets.only(left: 18, right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Color(0xFFE3EAF2), width: 1)),
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
                                  color:
                                      AppColors.color_2B3A4A.withOpacity(0.85))
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
    );
  }

  _selectDate(
      BuildContext context, ClientDataDNILogic control, bool from) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: control.selectDate,
      firstDate: DateTime(1900),
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

Widget spinnerFormV2(
    {required BuildContext context,
    required String hint,
    required bool required,
    required String dropValue,
    required List<String> listDrop,
    double height = 0,
    TextInputType inputType = TextInputType.text,
    TextEditingController? controlTextField,
    TextInputAction? typeAction,
    Function(String value)? function,
    Function(String value)? onSubmit,
    FocusNode? focusNode}) {
  return Column(
    children: [
      Container(
        height: height > 45 ? height : 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Color(0xFFE3EAF2))),
        child: listDrop.isEmpty
            ? Padding(
                padding: EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 6),
                child: TextField(
                    controller: controlTextField,
                    keyboardType: inputType,
                    autofocus: required,
                    textInputAction: typeAction,
                    style: AppStyles.r2.copyWith(
                        color: AppColors.colorTitle,
                        fontWeight: FontWeight.w500),
                    onChanged: (value) {
                      if (function != null) {
                        function.call(value);
                      }
                    },
                    onSubmitted: (value) {
                      onSubmit!.call(value);
                    },
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: AppStyles.r2.copyWith(
                          color: AppColors.colorHint1,
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    )),
              )
            : DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
                // selectedItemHighlightColor: Colors.red,
                buttonHeight: 60,
                focusNode: focusNode,
                buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Color(0xFFE3EAF2))),
                isExpanded: true,
                value: dropValue.isNotEmpty ? dropValue : null,
                onChanged: (value) {
                  function!.call(value!);
                },

                items: listDrop.map<DropdownMenuItem<String>>((String value) {
                  if (value == 'M') {
                    return DropdownMenuItem(
                        value: value,
                        child: Text(AppLocalizations.of(context)!.textMale));
                  } else {
                    return DropdownMenuItem(
                        value: value,
                        child: Text(AppLocalizations.of(context)!.textFemale));
                  }
                }).toList(),
                style: AppStyles.r2B3A4A_12_500.copyWith(
                    fontSize: 14,
                    color: AppColors.color_2B3A4A.withOpacity(0.85)),
                icon: SvgPicture.asset(AppImages.icDropdownSpinner),
                hint: Text(
                  hint,
                  style: AppStyles.r2.copyWith(
                      color: AppColors.colorHint1, fontWeight: FontWeight.w400),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                },
              ),
      ),
    ],
  );
}

class SuccessDialog extends Dialog {
  final double height;
  final bool isSuccess;
  var onClick;

  SuccessDialog(
      {super.key,
      required this.height,
      required this.isSuccess,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: 330,
        height: height,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SvgPicture.asset(
                isSuccess ? AppImages.imgCongratulations : AppImages.imgNotify),
            SizedBox(
              height: 24,
            ),
            Text(
              AppLocalizations.of(context)!.textIFelicidades,
              style: isSuccess ? AppStyles.r14 : AppStyles.r16,
            ),
            SizedBox(
              height: 16,
            ),
            const DottedLine(
              dashColor: Color(0xFFE3EAF2),
              dashGapLength: 3,
              dashLength: 4,
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                AppLocalizations.of(context)!.textTusHuellas,
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 27, left: 38, right: 38),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.colorButton,
                borderRadius: BorderRadius.circular(24),
              ),
              child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                onTap: () {
                  onClick();
                },
                child: Center(
                    child: Text(
                  AppLocalizations.of(context)!.textMuchasGracias.toUpperCase(),
                  style: AppStyles.r5,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BillAddressInformation extends Dialog {
  final double height;
  final ClientDataDNILogic controller;
  const BillAddressInformation(
      {super.key, required this.height, required this.controller});

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.only(bottom: 10, left: 5),
                  child: Text(
                    AppLocalizations.of(context)!.textProvince,
                    style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                  onTap: () {
                    if (controller.listProvince.isEmpty) {
                      _onLoading(context);
                      controller.getListProvince(
                        (isSuccess) {
                          Get.back();
                          if (isSuccess) {
                            showDialogAddress(context, controller.listProvince,
                                controller, 0);
                          }
                        },
                      );
                    } else {
                      showDialogAddress(
                          context, controller.listProvince, controller, 0);
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
                            hintText:
                                AppLocalizations.of(context)!.hintProvince,
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
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child:
                                  SvgPicture.asset(AppImages.icDropdownSpinner),
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                  child: Text(
                    AppLocalizations.of(context)!.textDistrict,
                    style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                  onTap: () {
                    if (controller.textFieldProvince.text.isNotEmpty) {
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
                        showDialogAddress(
                            context, controller.listDistrict, controller, 1);
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
                            hintText:
                                AppLocalizations.of(context)!.hintDistrict,
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
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child:
                                  SvgPicture.asset(AppImages.icDropdownSpinner),
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                  child: Text(
                    AppLocalizations.of(context)!.textPrecinct,
                    style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                  onTap: () {
                    if (controller.textFieldDistrict.text.isNotEmpty) {
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
                        showDialogAddress(
                            context, controller.listPrecinct, controller, 2);
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
                            hintText:
                                AppLocalizations.of(context)!.hintPrecinct,
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
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child:
                                  SvgPicture.asset(AppImages.icDropdownSpinner),
                            ))),
                  ),
                ),
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

  void showDialogAddress(BuildContext context, List<AddressModel> list,
      ClientDataDNILogic controll, int position) {
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
