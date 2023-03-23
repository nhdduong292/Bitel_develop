import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ChooseServiceItemPage extends GetWidget {
  int index;
  RxInt select;


  ChooseServiceItemPage(this.index, this.select);

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Obx(() {
              return select.value == index ? iconChecked() : iconUnchecked();
            },),
          ),
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      AppLocalizations.of(context)!.textTypeOfService,
                      style: AppStyles.r6C8AA1_13_400,
                    ),
                  ),
                  Text(
                    "data",
                    style: AppStyles.rText1_13_500,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      AppLocalizations.of(context)!.textNumber,
                      style: AppStyles.r6C8AA1_13_400,
                    ),
                  ),
                  Text(
                    "data",
                    style: AppStyles.rText1_13_500,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: Text(
                      AppLocalizations.of(context)!.textIDType,
                      style: AppStyles.r6C8AA1_13_400,
                    ),
                  ),
                  Text(
                    "data",
                    style: AppStyles.rText1_13_500,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      AppLocalizations.of(context)!.textName,
                      style: AppStyles.r6C8AA1_13_400,
                    ),
                  ),
                  Text(
                    "data",
                    style: AppStyles.rText1_13_500,
                  )
                ],
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        AppLocalizations.of(context)!.textPlan,
                        style: AppStyles.r6C8AA1_13_400,
                      ),
                    ),
                    Text(
                      "data",
                      style: AppStyles.rText1_13_500,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 4),
                      child: Text(
                        AppLocalizations.of(context)!.textStatus,
                        style: AppStyles.r6C8AA1_13_400,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 8, bottom: 2),
                      decoration: BoxDecoration(
                        color: AppColors.colorBackground3,
                        borderRadius: BorderRadius.circular(9),

                      ),
                      child: Text(
                        "Active",
                        style: AppStyles.rText1_13_500.copyWith(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: Text(
                        AppLocalizations.of(context)!.textIDNumber,
                        style: AppStyles.r6C8AA1_13_400,
                      ),
                    ),
                    Text(
                      "data",
                      style: AppStyles.rText1_13_500,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "",
                        style: AppStyles.r6C8AA1_13_400,
                      ),
                    ),
                    Text(
                      "",
                      style: AppStyles.rText1_13_500,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
