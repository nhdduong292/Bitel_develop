// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ;
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/view_item/clear_debt_detail/clear_debt_detail_logic.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../res/app_images.dart';
import '../../../../../../../res/app_styles.dart';
import '../../../../../../utils/common_widgets.dart';

typedef void TouchScan();

class ClearDebtDetailPage extends GetView<ClearDebtDetailLogic> {
  final TouchScan callback;
  ClearDebtDetailPage({required this.callback});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: ClearDebtDetailLogic(context: context),
        builder: (controller) {
          return SingleChildScrollView(
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
                    child: expandableV1(
                        label: 'bxloc',
                        child: Column(
                          children: [
                            Text('loc'),
                            Text('loc'),
                            Text('loc'),
                            Text('loc')
                          ],
                        )),
                  ),
                  SizedBox(
                    width: width,
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textContinue,
                        onTap: () {
                          ClearDebtLogic clearDebtLogic = Get.find();
                          clearDebtLogic.isTabOne.value = false;
                          clearDebtLogic.isTabTwo.value = true;
                          clearDebtLogic.nextPage(1);
                        },
                        color: true
                            ? const Color(0xFF415263).withOpacity(0.2)
                            : null),
                  ),
                ]),
          );
        });
  }

  Widget expandableV1({required String label, required Widget child}) {
    return ExpandableNotifier(
      child: Column(
        children: [
          Expandable(
            theme: ExpandableThemeData(hasIcon: false),
            collapsed: ExpandableButton(
                child: Container(
              width: 325,
              height: 123,
              decoration: BoxDecoration(
                color: Color(0xFFF0FAFA),
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xFFF0FAFA))),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
            )),
            expanded: Column(
              children: [
                ExpandableButton(
                  child: Column(children: [
                    Container(
                      width: 325,
                      height: 123,
                      decoration: BoxDecoration(
                        color: Color(0xFFF0FAFA),
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Color(0xFFF0FAFA))),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                    ),
                    child
                  ]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
