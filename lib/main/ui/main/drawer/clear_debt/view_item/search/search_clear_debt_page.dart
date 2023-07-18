// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ;
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:bitel_ventas/res/app_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../res/app_images.dart';
import '../../../../../../../res/app_styles.dart';
import '../../../../../../networks/model/captcha_model.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';
import 'search_clear_debt_logic.dart';

typedef void TouchScan();

class SearchClearDebtPage extends GetView<SearchClearDebtLogic> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: SearchClearDebtLogic(context: context),
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
                                              text:
                                                  ' S/${Common.numberFormat(controller.balance.value)} ',
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
                            // margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(20),
                            child: selectTypeSearchService(
                                context: context,
                                currentStatus: controller.currentStatus,
                                listStatus: controller.getListStatus(),
                                currentIdentityType:
                                    controller.currentIdentityType,
                                listIdentity: controller.listIdentity,
                                maxLength: controller.getMaxLengthIdNumber(
                                    controller.currentIdentityType),
                                controller: controller.textFieldEnter,
                                changeStatus: (value) {
                                  controller.setStatus(value);
                                },
                                setIdentity: (value) {
                                  controller.setIdentity(value);
                                },
                                onChangeText: (value) {
                                  controller.setEnter(value);
                                },
                                onSubmit: (value) {}),
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
                                  padding: const EdgeInsets.only(right: 7.04),
                                  child: Container(
                                    width: 103,
                                    height: 48,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ClipRRect(
                                        // borderRadius: BorderRadius.circular(20),
                                        child: controller.isGetCaptchaDone
                                            ? controller.captchaModel
                                                            .base64Img !=
                                                        null &&
                                                    controller.captchaModel
                                                        .base64Img!.isNotEmpty
                                                ? Image.memory(
                                                    fit: BoxFit.fill,
                                                    controller
                                                        .convertImageCaptcha(),
                                                    gaplessPlayback: true)
                                                : Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .colorBackground),
                                                    child: Text(
                                                      controller
                                                          .generatedCaptcha,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: AppFonts
                                                              .Hallelujha,
                                                          fontSize: 24),
                                                    ),
                                                  )
                                            : LoadingCirculApi()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 7.04),
                                  child: InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      controller.captchaModel = CaptchaModel();
                                      controller.update();
                                      controller.getCaptcha();
                                    },
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
                              controller.searchClearDebt(isSuccess: (value) {
                                if (value) {
                                  if (controller.listClearDebt.isEmpty) {
                                    Common.showToastCenter(
                                        AppLocalizations.of(context)!
                                            .textNoResultIsFound,
                                        context);
                                    return;
                                  }
                                  ClearDebtLogic clearDebtLogic = Get.find();
                                  clearDebtLogic.balance =
                                      controller.balance.value;
                                  clearDebtLogic.setListClearDebt(
                                      controller.listClearDebt);
                                  clearDebtLogic.isTabOne.value = false;
                                  clearDebtLogic.isTabTwo.value = true;
                                  clearDebtLogic.nextPage(1);
                                }
                              });
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
