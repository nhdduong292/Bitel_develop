import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../utils/common.dart';

class ChooseServiceItemPage extends GetWidget {
  int index;
  RxInt select;
  FindAccountModel model;

  ChooseServiceItemPage(this.index, this.select, this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
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
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Obx(
              () {
                return select.value == index ? iconChecked() : iconUnchecked();
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                AppLocalizations.of(context)!.textName,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                            ),
                            Text(
                              model.name,
                              style: AppStyles.rText1_13_500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                AppLocalizations.of(context)!.textPhone,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                            ),
                            Text(
                              model.phone,
                              style: AppStyles.rText1_13_500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                AppLocalizations.of(context)!.textAccount,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                            ),
                            Text(
                              model.account,
                              style: AppStyles.rText1_13_500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                AppLocalizations.of(context)!.textServiceNumber,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                            ),
                            Text(
                              model.serviceNumber.toString(),
                              style: AppStyles.rText1_13_500,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10),
                            //   child: Text(
                            //     AppLocalizations.of(context)!.textPhoneNumber,
                            //     style: AppStyles.r6C8AA1_13_400,
                            //   ),
                            // ),
                            // Text(
                            //   model.serviceNumber.toString(),
                            //   style: AppStyles.rText1_13_500,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10),
                            //   child: Text(
                            //     AppLocalizations.of(context)!.textName,
                            //     style: AppStyles.r6C8AA1_13_400,
                            //   ),
                            // ),
                            // Text(
                            //   model.name,
                            //   style: AppStyles.rText1_13_500,
                            // )
                          ],
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                AppLocalizations.of(context)!.textStatus,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 2),
                              decoration: BoxDecoration(
                                color: AppColors.colorBackground3,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Text(
                                'Active',
                                style: AppStyles.rText1_13_500
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                AppLocalizations.of(context)!.textIDNumber,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                            ),
                            Text(
                              model.idNumber,
                              style: AppStyles.rText1_13_500,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 4),
                              child: Text(
                                AppLocalizations.of(context)!.textPlan,
                                style: AppStyles.r6C8AA1_13_400,
                              ),
                            ),
                            Text(
                              model.plan,
                              style: AppStyles.rText1_13_500,
                            ),
                          ],
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    AppLocalizations.of(context)!.textInstallationAddress,
                    style: AppStyles.r6C8AA1_13_400,
                  ),
                ),
                Text(
                  model.address,
                  style: AppStyles.rText1_13_500,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
