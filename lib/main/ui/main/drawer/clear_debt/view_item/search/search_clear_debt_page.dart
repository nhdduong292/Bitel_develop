// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ;
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../res/app_images.dart';
import '../../../../../../../res/app_styles.dart';
import '../../../../../../utils/common_widgets.dart';
import 'search_clear_debt_logic.dart';

typedef void TouchScan();

class SearchClearDebtPage extends GetView<SearchClearDebtLogic> {
  final TouchScan callback;
  SearchClearDebtPage({required this.callback});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: SearchClearDebtLogic(context: context),
        builder: (controller) {
          return FocusScope(
            node: controller.focusScopeNode,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
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
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(26),
                                dashPattern: const [2, 2],
                                strokeWidth: 1,
                                color: const Color(0xFF9454C9),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 12),
                                  child: Obx(
                                    () => RichText(
                                      text: TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .textAnypayBalance,
                                          style: AppStyles.r1.copyWith(
                                              fontWeight: FontWeight.w400),
                                          children: [
                                            TextSpan(
                                              text: ' S/${controller.balance} ',
                                              style: AppStyles.r9454C9_14_500
                                                  .copyWith(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 22, right: 15, bottom: 14),
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                border:
                                    Border.all(color: const Color(0xFFE3EAF2))),
                            child: DropdownButtonFormField2(
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                              ),
                              // selectedItemHighlightColor: Colors.red,
                              buttonPadding:
                                  const EdgeInsets.only(left: 0, right: 10),
                              dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                      color: const Color(0xFFE3EAF2))),
                              isExpanded: true,
                              value: controller.currentStatus.isNotEmpty
                                  ? controller.currentStatus
                                  : null,
                              onChanged: (value) {
                                controller.setStatus(value!);
                              },
                              buttonHeight: 60,
                              items: controller
                                  .getListStatus()
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem(
                                    value: value,
                                    child: Center(child: Text(value)));
                              }).toList(),
                              style: AppStyles.r415263_13_500,
                              icon:
                                  SvgPicture.asset(AppImages.icDropdownSpinner),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select gender.';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                controller.currentStatus ==
                                        controller.getListStatus()[0]
                                    ? Expanded(
                                        flex: 2,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: spinnerFormV2(
                                              context: context,
                                              hint: "",
                                              required: false,
                                              dropValue: controller
                                                  .currentIdentityType,
                                              function: (value) {
                                                controller.setIdentity(value);
                                              },
                                              listDrop:
                                                  controller.listIdentity),
                                        ))
                                    : Container(),
                                Expanded(
                                    flex: 4,
                                    child: TextField(
                                        controller: controller.textFieldEnter,
                                        keyboardType: TextInputType.phone,
                                        textInputAction: TextInputAction.send,
                                        style: AppStyles.r2.copyWith(
                                            color: AppColors.colorTitle,
                                            fontWeight: FontWeight.w500),
                                        onChanged: (value) {
                                          controller.setEnter(value);
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              top: 5, left: 10, right: 10),
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .hintEnterPhone,
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
                                        )))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 17, left: 15, right: 15, bottom: 19),
                            padding: const EdgeInsets.only(
                                top: 10, left: 40, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0xFFE3EAF2), width: 1),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: AppStyles.r415263_13_500
                                        .copyWith(fontSize: 16),
                                    onChanged: (value) {
                                      controller.setCapcha(value);
                                    },
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!
                                          .textEnterCaptcha,
                                      hintStyle: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF7F96AD)),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 12.01),
                                  child: InkWell(
                                    child: Image.asset(AppImages.imgCapchaTest),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 7.04),
                                  child: InkWell(
                                    child: SvgPicture.asset(
                                        AppImages.icRefreshCapcha),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        width: width,
                        child: bottomButton(
                            text: AppLocalizations.of(context)!.textContinue,
                            onTap: () {
                              if (controller.isActive) {
                                return;
                              }
                              controller.focusScopeNode.unfocus();
                              ClearDebtLogic clearDebtLogic = Get.find();
                              clearDebtLogic.balance = controller.balance.value;
                              clearDebtLogic.isTabOne.value = false;
                              clearDebtLogic.isTabTwo.value = true;
                              clearDebtLogic.nextPage(1);
                            },
                            color: controller.isActive
                                ? const Color(0xFF415263).withOpacity(0.2)
                                : null),
                      ),
                    ]),
              ),
            ),
          );
        });
  }
}
