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

import '../../../../../../utils/common.dart';

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
                bottomButton(
                    isBoxShadow: true,
                    color: controller.isActive ? Colors.white : null,
                    text: AppLocalizations.of(context)!.textSearch,
                    onTap: () {
                      if (controller.isActive) {
                        return;
                      }

                      if (controller.checkValidate()) {
                        return;
                      }

                      FocusScope.of(context).requestFocus(FocusNode());
                      controller.getAccounts((isSuccess) {
                        if (isSuccess) {
                          if (controller.listAccount.isEmpty) {
                            Common.showToastCenter(AppLocalizations.of(context)!
                                .textNoResultIsFound);
                            return;
                          }
                          AfterSaleSearchLogic logic =
                              Get.find<AfterSaleSearchLogic>();
                          logic.isTabTwo.value = true;
                          logic.isTabOne.value = false;
                          logic.nextPage(1);
                        }
                      });
                    }),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
