// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../res/app_colors.dart';
import '../ui/main/activate_prepaid_pages/activate_prepaid_logic.dart';

Icon iconUnchecked() {
  return Icon(
    Icons.circle_outlined,
    color: Color(0xFF87A0B3),
    size: 20,
  );
}

Icon iconChecked() {
  return Icon(
    Icons.check_circle,
    color: Color(0xFF87A0B3),
    size: 20,
  );
}

Widget inputForm(
    {required String label,
    required String hint,
    required bool required,
    required TextInputType inputType}) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 20, top: 15),
        alignment: Alignment.topLeft,
        child: RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              color: AppColors.colorText1,
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w500
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
      Container(
        height: 45,
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Roboto',
              color: Color(0xFF415263),
              fontWeight: FontWeight.w500),
          keyboardType: inputType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w300),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(
                color: Color(0xFFE3EAF2),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(
                color: Color(0xFFE3EAF2),
                width: 1,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget spinnerForm(
    {required BuildContext context,
    required String label,
    required String hint,
    required bool required,
    items,
    dropdownValue,
    Rxn<TownCenter>? townCenterItem,
    List<TownCenter>? townCenterItems}) {
  return Column(
    children: [
      Container(
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
      Container(
        // width: double.infinity,
        height: 45,
        padding: EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 6),
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Color(0xFFE3EAF2))),
        child: Obx(
          () => townCenterItems != null
              ? DropdownButton<TownCenter>(
                  isExpanded: true,
                  underline: Container(),
                  value: townCenterItem?.value,
                  onChanged: (TownCenter? value) =>
                      townCenterItem?.value = value,
                  // items: items.map<DropdownMenuItem<String>>((String value) {
                  //   return DropdownMenuItem(value: value, child: Text(value));
                  // }).toList(),
                  items: townCenterItems.map((item) {
                    return DropdownMenuItem<TownCenter>(
                        value: item, child: Text(item.name));
                  }).toList(),
                  alignment: AlignmentDirectional.centerStart,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Color(0xFF415263),
                      fontWeight: FontWeight.w500),
                  icon: Image(
                    image: svg_provider.Svg(AppImages.icDropdownSpinner),
                  ),
                  hint: Text(
                    hint,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300),
                  ),
                )
              : DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  value: dropdownValue.value,
                  onChanged: (String? value) => dropdownValue.value = value,
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  alignment: AlignmentDirectional.centerStart,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Color(0xFF415263),
                      fontWeight: FontWeight.w500),
                  icon: Image(
                    image: svg_provider.Svg(AppImages.icDropdownSpinner),
                  ),
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
      Obx(
        () => Wrap(
          children: [Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: townCenterItems != null
                  ? notifyCoverageLocation(
                      coverage: townCenterItem?.value?.coverage, context: context)
                  : null),
        ]),
      )
    ],
  );
}

Widget notifyCoverageLocation({bool? coverage, required BuildContext context}) {
  return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SvgPicture.asset((coverage != null && coverage) || coverage == null
            ? AppImages.bgLocationCoverageNotify
            : AppImages.bgLocationNotCoverageNotify,
        height: 80,),
        Positioned(
          top: 27,
          left: 65,
          right: 10,
          child: RichText(
            text: TextSpan(
              text: AppLocalizations.of(context)!.textSelectedLoation,
              style: TextStyle(
                  color: (coverage != null && coverage) || coverage == null
                      ? AppColors.colorContent
                      : AppColors.colorTextError,
                  fontFamily: 'Roboto',
                  fontSize: 14),
              children: [
                TextSpan(
                  text: (coverage != null && coverage) || coverage == null
                      ? AppLocalizations.of(context)!.textHasCoverage
                      : AppLocalizations.of(context)!.textHasNoCoverage,
                  style: TextStyle(
                      color: (coverage != null && coverage) || coverage == null
                          ? AppColors.colorContent
                          : AppColors.colorTextError,
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        )
      ]);
}
