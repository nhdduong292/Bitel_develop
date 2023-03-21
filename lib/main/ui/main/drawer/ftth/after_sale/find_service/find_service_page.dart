import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/find_service/find_service_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FindServicePage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FindServiceLogic(context),
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(width: 1, color: AppColors.colorLineDash),
                  boxShadow: [
                    const BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 2,
                      color: AppColors.colorLineDash,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0xFFE3EAF2))),
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
                            border: Border.all(color: const Color(0xFFE3EAF2))),
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
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                              value: value, child: Center(child: Text(value)));
                        }).toList(),
                        style: AppStyles.r2.copyWith(
                            color: AppColors.color_415263,
                            fontWeight: FontWeight.w500),
                        icon: SvgPicture.asset(AppImages.icDropdownSpinner),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select gender.';
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        controller.currentStatus == controller.getListStatus()[0] ?
                        Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: spinnerFormV2(
                                  context: context,
                                  hint: "",
                                  required: false,
                                  dropValue: controller.currentIdentityType,
                                  function: (value) {
                                    controller.setIdentity(value);
                                  },
                                  listDrop: controller.listIdentity),
                            )) : Container(),
                        Expanded(
                            flex: 4,
                            child: TextField(
                                controller: controller.textFieldEnter,
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
                                  hintText: AppLocalizations.of(context)!
                                      .hintEnterPhone,
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
                                )))
                      ],
                    )
                  ],
                ),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  // if (controller.isActive ||
                  //     controller.checkValidate(context)) {
                  //   return;
                  // }
                  // _onLoading(context);
                  AfterSaleSearchLogic logic = Get.find<AfterSaleSearchLogic>();
                  logic.isTabTwo.value = true;
                  logic.isTabOne.value = false;
                  logic.nextPage(1);
                },
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.only(bottom: 50, left: 25, right: 25),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: controller.isActive
                        ? Colors.white
                        : AppColors.colorButton,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text(
                    AppLocalizations.of(context)!.textContinue.toUpperCase(),
                    style: controller.isActive
                        ? AppStyles.r1.copyWith(fontWeight: FontWeight.w500)
                        : AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                  )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
