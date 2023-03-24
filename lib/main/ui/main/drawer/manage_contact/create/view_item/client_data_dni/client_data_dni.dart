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
import '../../../../../../../router/route_config.dart';
import '../../../../../../../utils/common_widgets.dart';
import 'client_data_dni_logic.dart';

typedef void TouchUpadte();

class ClientDataDNIWidget extends GetView<ClientDataDNILogic> {
  final TouchUpadte callback;
  ClientDataDNIWidget({required this.callback});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: ClientDataDNILogic(),
        builder: (controller) {
          return SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                        AppLocalizations.of(context)!.textInformacionDel,
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
                            RichText(
                              text: TextSpan(
                                  text:
                                      '${controller.logicCreateContact.typeCustomer}: ',
                                  style: AppStyles.r9454C9_14_500.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                  children: [
                                    TextSpan(
                                      text: controller.idNumber,
                                      style: AppStyles.r2B3A4A_12_500.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ]),
                            )
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
                          label: AppLocalizations.of(context)!.textLastName,
                          hint: AppLocalizations.of(context)!.textEnterName,
                          width: width * 0.55,
                          controller: controller.tfLastName,
                          focusNode: controller.focusLastName,
                          onChange: (value) {}),
                      SizedBox(
                        height: 16,
                      ),
                      textFieldClient(
                          context: context,
                          label: AppLocalizations.of(context)!.textName,
                          hint: AppLocalizations.of(context)!.textEnterName,
                          width: width * 0.55,
                          controller: controller.tfName,
                          focusNode: controller.focusLastName,
                          onChange: (value) {}),
                      SizedBox(
                        height: 16,
                      ),
                      textFieldClient(
                          context: context,
                          label: AppLocalizations.of(context)!.textNationality,
                          hint: AppLocalizations.of(context)!
                              .textEnterNationality,
                          width: width * 0.55,
                          controller: controller.tfNationality,
                          focusNode: controller.focusLastName,
                          onChange: (value) {}),
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
                                    AppLocalizations.of(context)!.textSex,
                                    style: AppStyles.r2B3A4A_12_500.copyWith(
                                        fontSize: 14,
                                        color: AppColors.color_2B3A4A
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
                          type: 1,
                          hint: AppLocalizations.of(context)!.textEnterDate,
                          label: AppLocalizations.of(context)!.textDateOfBirth,
                          content: controller.dob,
                          required: false,
                          isIcon: true,
                          width: width * 0.55),
                      SizedBox(
                        height: 16,
                      ),
                      formDateView(
                          context: context,
                          type: 2,
                          hint: AppLocalizations.of(context)!.textEnterDate,
                          label: AppLocalizations.of(context)!.textExpiredDate,
                          content: controller.exd,
                          required: false,
                          isIcon: true,
                          width: width * 0.55),
                      SizedBox(
                        height: 16,
                      ),
                      textFieldClient(
                          context: context,
                          label: AppLocalizations.of(context)!.textAddress,
                          hint: AppLocalizations.of(context)!.textEnterAddress,
                          width: width * 0.55,
                          controller: controller.tfAddress,
                          focusNode: controller.focusLastName,
                          onChange: (value) {}),
                      SizedBox(
                        height: 34,
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                width: 310,
                margin:
                    EdgeInsets.only(top: 30, bottom: 36, left: 16, right: 16),
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.colorButton,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: InkWell(
                  onTap: () {
                    if (!controller.checkValidate()) {
                      return;
                    }
                    if (controller.logicCreateContact.typeCustomer != 'DNI') {
                      callback();
                      return;
                    }
                    _onLoading(context);
                    controller.createCustomer(
                      (isSuccess) {
                        if (isSuccess) {
                          Get.back();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessDialog(
                                height: 299,
                                isSuccess: true,
                                onClick: () {
                                  Get.back();
                                  Get.offNamed(RouteConfig.customerInformation,
                                      arguments: [
                                        controller.customerModel,
                                        controller.requestModel,
                                        controller.productId,
                                        controller.reasonId,
                                        controller.isForcedTerm
                                      ]);
                                },
                              );
                            },
                          );
                        } else {
                          Get.back();
                          Common.showToastCenter(
                              AppLocalizations.of(context)!.textErrorAPI);
                        }
                      },
                    );
                  },
                  child: Center(
                      child: Text(
                    AppLocalizations.of(context)!.textRegistrar,
                    style: AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                  )),
                ),
              )
            ]),
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
        Container(
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
                        fontFamily: 'Roboto',
                        fontSize: 14,
                      )),
                ],
              ),
            ),
          ),
        ),
        InkWell(
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
