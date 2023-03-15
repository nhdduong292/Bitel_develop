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
import '../../../../../../../utils/common_widgets.dart';

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
            lockedBox(
                content: controller.isForcedTerm
                    ? AppLocalizations.of(context)!.textForcedTerm
                    : 'Undetermined',
                label: AppLocalizations.of(context)!.textContactType,
                required: false,
                isIcon: true,
                width: 210),
            lockedBox(
                content: '123456/XXXXXX',
                label: AppLocalizations.of(context)!.textContractNumber,
                required: false,
                isIcon: false,
                width: 210),
            lockedBox(
                content: '1',
                label: AppLocalizations.of(context)!.textQuantitySubscriber,
                required: true,
                isIcon: false,
                width: 210),
            Obx(() => lockedBox(
                content: controller.signDate.value != ''
                    ? Common.fromDate(
                        DateTime.parse(controller.signDate.value), 'dd/MM/yyyy')
                    : "---",
                label: AppLocalizations.of(context)!.textSignDate,
                required: false,
                isIcon: false,
                width: 210)),
            Obx(
              () => lockedBox(
                  content: controller.billCycle.value,
                  label: AppLocalizations.of(context)!.textBillCycle,
                  required: true,
                  isIcon: true,
                  width: 210),
            ),
            lockedBox(
                content: AppLocalizations.of(context)!.textEmail,
                label: AppLocalizations.of(context)!.textChangeNotification,
                required: false,
                isIcon: true,
                width: 210),
            lockedBox(
                content: AppLocalizations.of(context)!.textEmail,
                label: AppLocalizations.of(context)!.textPrintBillDetail,
                required: false,
                isIcon: true,
                width: 210),
            lockedBox(
                content: 'SOL',
                label: AppLocalizations.of(context)!.textCurrency,
                required: true,
                isIcon: true,
                width: 210),
            dropDownContactLanguages(
                context: context,
                label: AppLocalizations.of(context)!.textContractLanguage,
                hint: '',
                required: false,
                items: controller.contractLanguages,
                dropdownValue: controller.contractLanguagetValue,
                width: 210),
            inputFormV3(
                hint: AppLocalizations.of(context)!.textEnterBilling,
                label: AppLocalizations.of(context)!.textBillingAddress,
                required: true,
                onChange: (value) {
                  controller.billAddress = value;
                },
                controller: controller.billAddressController,
                inputType: TextInputType.streetAddress,
                width: 210),
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
                    .textIAcceptToReceiveInformatioin,
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
                          controller.createContract(
                            context,
                            (p0) {
                              if (p0) {
                                callback();
                              } else {
                                Common.showToastCenter(
                                    AppLocalizations.of(context)!.textErrorAPI);
                              }
                            },
                          );
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
                style: TextStyle(
                  color: AppColors.colorText1,
                  fontFamily: 'Roboto',
                  fontSize: 14,
                ),
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
        Container(
          // width: double.infinity,
          height: 45,
          width: width,
          padding: EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 6),
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
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  color: Color(0xFF415263),
                  fontWeight: FontWeight.w500),
              icon: SvgPicture.asset(AppImages.icDropdownSpinner),
              hint: Text(
                hint,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
