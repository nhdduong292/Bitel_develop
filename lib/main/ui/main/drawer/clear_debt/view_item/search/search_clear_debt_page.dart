// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../../res/app_colors.dart';
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
        init: SearchClearDebtLogic(),
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
                    child: Column(children: []),
                  ),
                  Obx(
                    () => SizedBox(
                      width: width,
                      child: bottomButton(
                          text: AppLocalizations.of(context)!.textContinue,
                          onTap: () {},
                          color: !(controller.checkOption1.value &&
                                  controller.checkOption2.value)
                              ? const Color(0xFF415263).withOpacity(0.2)
                              : null),
                    ),
                  ),
                ]),
          );
        });
  }
}
