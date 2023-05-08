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
        return InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border:
                        Border.all(width: 1, color: AppColors.colorLineDash),
                    // ignore: prefer_const_literals_to_create_immutables
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
                      selectTypeSearchService(
                          context: context,
                          currentStatus: controller.currentStatus,
                          listStatus: controller.getListStatus(),
                          currentIdentityType: controller.currentIdentityType,
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
                    ],
                  ),
                ),
                Expanded(child: Container()),
                InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                  onTap: () {
                    // if (controller.isActive ||
                    //     controller.checkValidate(context)) {
                    //   return;
                    // }
                    // _onLoading(context);
                    FocusScope.of(context).requestFocus(FocusNode());
                    AfterSaleSearchLogic logic =
                        Get.find<AfterSaleSearchLogic>();
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
          ),
        );
      },
    );
  }
}
