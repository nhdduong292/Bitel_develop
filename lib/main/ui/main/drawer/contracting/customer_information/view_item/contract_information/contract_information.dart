// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/customer_information_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../../res/app_images.dart';
import '../../../../../../../networks/model/address_model.dart';
import '../../../../../../../utils/common_widgets.dart';
import '../../../../../../../utils/values.dart';
import '../../../../request/dialog_address_page.dart';

typedef void TouchUpadte();

class ContractInformationWidget extends GetView<CustomerInformationLogic> {
  final TouchUpadte callback;
  CustomerInformationLogic controller;
  ContractInformationWidget({required this.controller, required this.callback});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              height: 52,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.textContractInformation,
                  style: AppStyles.r00A5B1_15d5_500,
                ),
              ),
            ),
            DottedLine(
              dashColor: Color(0xFFE3EAF2),
              dashGapLength: 3,
              dashLength: 4,
            ),
            SizedBox(
              height: 15,
            ),
            lockedBoxV1(
                content: controller.isForcedTerm
                    ? AppLocalizations.of(context)!.textForcedTerm
                    : AppLocalizations.of(context)!.textUndetermined,
                label: AppLocalizations.of(context)!.textContactType,
                required: false,
                isIcon: true,
                width: width * 0.55),
            // lockedBoxV1(
            //     content: '123456/XXXXXX',
            //     label: AppLocalizations.of(context)!.textContractNumber,
            //     required: false,
            //     isIcon: false,
            //     width: width * 0.55),
            lockedBoxV1(
                content: controller.getQuantitySubscriber(),
                label: AppLocalizations.of(context)!.textQuantitySubscriber,
                required: true,
                isIcon: false,
                width: width * 0.55),
            Obx(() => lockedBoxV1(
                content: controller.getSignDate(),
                label: AppLocalizations.of(context)!.textSignDate,
                required: false,
                isIcon: false,
                width: width * 0.55)),
            lockedBoxV1(
                content: controller.getBillCycle(),
                label: AppLocalizations.of(context)!.textBillCycle,
                required: true,
                isIcon: true,
                width: width * 0.55),
            lockedBoxV1(
                content: controller.getChangeNotification(),
                label: AppLocalizations.of(context)!.textChangeNotification,
                required: false,
                isIcon: true,
                width: width * 0.55),
            lockedBoxV1(
                content: controller.getPrintBillDetail(),
                label: AppLocalizations.of(context)!.textPrintBillDetail,
                required: false,
                isIcon: true,
                width: width * 0.55),
            lockedBoxV1(
                content: controller.getCurrency(),
                label: AppLocalizations.of(context)!.textCurrency,
                required: true,
                isIcon: true,
                width: width * 0.55),
            dropDownContactLanguages(
                context: context,
                label: AppLocalizations.of(context)!.textContractLanguage,
                hint: '',
                required: false,
                items: controller.contractLanguages,
                dropdownValue: controller.contractLanguagetValue,
                width: width * 0.55),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    controller.resetBillAdress();
                    return BillAddressInformation(
                      height: 300,
                      controller: controller,
                    );
                  },
                ).then((value) {
                  if (value) {
                    controller.billAddress =
                        '${controller.billAddressSelect}, ${controller.billArea.fullName}';
                    controller.update();
                  }
                });
              },
              child: lockedBoxV1(
                  content: controller.billAddress,
                  label: AppLocalizations.of(context)!.textBillingAddress,
                  required: true,
                  isIcon: false,
                  width: width * 0.55),
            ),
            SizedBox(
              height: 27,
            )
          ]),
        ),
        SizedBox(
          height: 16,
        ),
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
              height: 52,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.textProtectionFilterAdvertising,
                  style: AppStyles.r00A5B1_15d5_500,
                ),
              ),
            ),
            DottedLine(
              dashColor: Color(0xFFE3EAF2),
              dashGapLength: 3,
              dashLength: 4,
            ),
            customRadioMutiple(
                width: width,
                text: AppLocalizations.of(context)!.textIAcceptToActivate,
                check: controller.checkOption1,
                changeValue: (value) {
                  controller.checkOption1.value = value;
                }),
            customRadioMutiple(
                width: width,
                text: AppLocalizations.of(context)!
                    .textIAcceptToReceiveInformatioin,
                check: controller.checkOption2,
                changeValue: (value) {
                  controller.checkOption2.value = value;
                }),
            customRadioMutiple(
                width: width,
                text: AppLocalizations.of(context)!
                    .textIAcceptToReceiveAdvertising,
                check: controller.checkOption3,
                changeValue: (value) {
                  controller.checkOption3.value = value;
                }),
            customRadioMutiple(
                width: width,
                text: AppLocalizations.of(context)!
                    .textIAcceptToReceiveAdvertisingBitel,
                check: controller.checkOption4,
                changeValue: (value) {
                  controller.checkOption4.value = value;
                }),
            SizedBox(
              height: 24,
            )
          ]),
        ),
        SizedBox(
            width: width,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: bottomButtonV2(
                        onTap: () {},
                        text: AppLocalizations.of(context)!
                            .textCancel
                            .toUpperCase())),
                Expanded(
                    flex: 1,
                    child: bottomButton(
                        onTap: () {
                          //nếu trạng thái là connected thì gọi api update, ngược lại gọi api create
                          if (controller.statusRequest ==
                              RequestStatus.CONTRACTING) {
                            controller.updateContract(
                              context,
                              (p0) {
                                if (p0) {
                                  callback();
                                } else {
                                  // Common.showToastCenter(
                                  //     AppLocalizations.of(context)!.textErrorAPI);
                                }
                              },
                            );
                          } else {
                            controller.createContract(
                              context,
                              (p0) {
                                if (p0) {
                                  callback();
                                } else {
                                  // Common.showToastCenter(
                                  //     AppLocalizations.of(context)!.textErrorAPI);
                                }
                              },
                            );
                          }
                        },
                        text: AppLocalizations.of(context)!
                            .textContinue
                            .toUpperCase())),
              ],
            )),
      ]),
    );
  }

  Widget dropDownContactLanguages({
    required BuildContext context,
    required String label,
    required String hint,
    required bool required,
    required items,
    required dropdownValue,
    required double width,
  }) {
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
          // width: double.infinity,
          height: 45,
          width: width,
          padding: EdgeInsets.only(left: 15, top: 6, bottom: 6, right: 6),
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Color(0xFFE3EAF2))),
          child: Obx(
            () => DropdownButton<String>(
              isExpanded: true,
              underline: Container(),
              value: dropdownValue.value,
              onChanged: (String? value) => dropdownValue.value = value,
              items: items.map<DropdownMenuItem<String>>((String value) {
                if (value == "SHIPIBO_KONIBO") {
                  return DropdownMenuItem(
                      value: value,
                      child: Text(
                          AppLocalizations.of(context)!.textSHIPIBOKONIBO));
                } else if (value == "ASHANINKA") {
                  return DropdownMenuItem(
                      value: value,
                      child: Text(AppLocalizations.of(context)!.textASHANINKA));
                } else if (value == "AYMARA") {
                  return DropdownMenuItem(
                      value: value,
                      child: Text(AppLocalizations.of(context)!.textAYMARA));
                } else if (value == "SPANISH") {
                  return DropdownMenuItem(
                      value: value,
                      child: Text(AppLocalizations.of(context)!.textSPANISH));
                } else {
                  return DropdownMenuItem(
                      value: value,
                      child: Text(AppLocalizations.of(context)!.textQUECHUA));
                }
              }).toList(),
              alignment: AlignmentDirectional.centerStart,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Barlow',
                  color: Color(0xFF415263),
                  fontWeight: FontWeight.w500),
              icon: SvgPicture.asset(AppImages.icDropdownSpinner),
              hint: Text(
                hint,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Barlow',
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
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
              constraints: BoxConstraints(
                minHeight: 45,
              ),
              width: width,
              padding: EdgeInsets.only(left: 15, right: 7),
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
    controller.billArea.province = "";
    controller.billArea.district = "";
    controller.billArea.precinct = "";
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
                          controller.billArea.province = "";
                          controller.billArea.district = "";
                          controller.billArea.precinct = "";
                        },
                        onSuggestionSelected: (suggestion) {
                          if (suggestion is AddressModel) {
                            controller.textFieldArea.text = suggestion.fullName;
                            controller.billArea.fullName = suggestion.fullName;
                            controller.billArea.province = suggestion.province;
                            controller.billArea.district = suggestion.district;
                            controller.billArea.precinct = suggestion.precinct;
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
                        controller.setBillAddress(value);
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
                    if (controller.validateBillAddress()) {
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
