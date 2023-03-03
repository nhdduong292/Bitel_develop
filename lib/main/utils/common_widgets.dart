// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:multiselect/multiselect.dart';

import '../../res/app_colors.dart';
import '../ui/main/activate_prepaid_pages/activate_prepaid_logic.dart';

Icon iconUnchecked() {
  return Icon(
    Icons.circle_outlined,
    color: Color(0xFF29BDBE),
    size: 20,
  );
}

Icon iconChecked() {
  return Icon(
    Icons.check_circle,
    color: Color(0xFF29BDBE),
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
      label.isNotEmpty
          ? Container(
              margin: EdgeInsets.only(left: 20, top: 15),
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: label,
                  style: TextStyle(
                      color: AppColors.colorText1,
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
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
            )
          : Container(),
      Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: SizedBox(
          height: 45,
          child: TextField(
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto',
                color: Color(0xFF415263),
                fontWeight: FontWeight.w500),
            keyboardType: inputType,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
      ),
    ],
  );
}

Widget inputFormV2(
    {required String label,
    required String hint,
    required bool required,
    required TextInputType inputType,
    required double width}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(
        child: Container(
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
      ),
      Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: SizedBox(
          height: 45,
          width: width,
          child: TextField(
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto',
                color: Color(0xFF415263),
                fontWeight: FontWeight.w500),
            keyboardType: inputType,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
      label.isNotEmpty
          ? Container(
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
            )
          : Container(),
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
                  icon: SvgPicture.asset(AppImages.icDropdownSpinner),
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
                  icon: SvgPicture.asset(AppImages.icDropdownSpinner),
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
        () => Wrap(children: [
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: townCenterItems != null
                  ? notifyCoverageLocation(
                      coverage: townCenterItem?.value?.coverage,
                      context: context)
                  : SizedBox()),
        ]),
      )
    ],
  );
}

Widget spinnerFormNormalV2({
  required BuildContext context,
  required String label,
  required String hint,
  required bool required,
  required items,
  required dropdownValue,
  required double width,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(
        child: Container(
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
      ),
      Container(
        // width: double.infinity,
        height: 45,
        width: width,
        padding: EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 6),
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Color(0xFFE3EAF2))),
        child: Obx(
          () => DropdownButton<String>(
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
            icon: SvgPicture.asset(AppImages.icDropdownSpinner),
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
    ],
  );
}

Widget spinnerFormNormal(
    {required BuildContext context,
    required String label,
    required String hint,
    required bool required,
    required items,
    required dropdownValue}) {
  return Column(
    children: [
      label.isNotEmpty
          ? Container(
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
            )
          : Container(),
      Container(
        // width: double.infinity,
        height: 45,
        padding: EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 6),
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Color(0xFFE3EAF2))),
        child: Obx(
          () => DropdownButton<String>(
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
            icon: SvgPicture.asset(AppImages.icDropdownSpinner),
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
    ],
  );
}

Widget notifyCoverageLocation({bool? coverage, required BuildContext context}) {
  return Stack(alignment: AlignmentDirectional.center, children: [
    SvgPicture.asset(
      (coverage != null && coverage) || coverage == null
          ? AppImages.bgLocationCoverageNotify
          : AppImages.bgLocationNotCoverageNotify,
      height: 80,
    ),
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

Widget circleMarkerView({required RxBool check, required String text}) {
  return Obx(() => Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: check.value
              ? LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  transform: GradientRotation(124.84),
                  colors: [
                    Color(0xFF00A5B1),
                    Color(0xFF0FDDDB),
                  ],
                  stops: [0.0583, 0.7052],
                )
              : LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  transform: GradientRotation(124.84),
                  colors: [
                    Color(0xFFEBEFF3),
                    Color(0xFFFFFFFF),
                  ],
                  stops: [0.0583, 0.7052],
                ),
        ),
        child: Center(
          child:
              Text(text, style: check.value ? AppStyles.rw13 : AppStyles.rb13),
        ),
      ));
}

Widget inputFormPassword(
    {required String label,
    required String hint,
    required bool required,
    required TextInputType inputType,
    required RxBool isVisibility}) {
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
          height: 45,
          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Obx(() => TextField(
                obscureText: !isVisibility.value,
                textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    color: Color(0xFF415263),
                    fontWeight: FontWeight.w500),
                keyboardType: inputType,
                decoration: InputDecoration(
                  hintText: hint,
                  suffixIcon: IconButton(
                    icon: Icon(
                      color: AppColors.color_919BA5,
                      isVisibility.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      isVisibility.value = (!isVisibility.value);
                    },
                  ),
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
              ))),
    ],
  );
}

Widget bottomButton({required String text, required onTap, color}) {
  return Container(
    margin: EdgeInsets.only(left: 15, top: 24, right: 15, bottom: 10),
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: color ?? AppColors.colorText3,
            boxShadow: [
              BoxShadow(
                  color: color == null ? Color(0xFFB3BBC5) : Colors.transparent,
                  blurRadius: 5)
            ]),
        child: Center(
            child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        )),
      ),
    ),
  );
}

Widget bottomButtonV2({required String text, required onTap}) {
  return Container(
    margin: EdgeInsets.only(left: 15, top: 24, right: 15, bottom: 10),
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          border: Border.all(color: Color(0xFFE3EAF2)),
        ),
        child: Center(
            child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        )),
      ),
    ),
  );
}

Widget spinnerFormV3({
  required BuildContext context,
  required String hint,
  required bool required,
  required String dropValue,
  required List<String> listDrop,
}) {
  return Column(
    children: [
      Container(
        height: 45,
        padding: EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Color(0xFFE3EAF2))),
        child: listDrop.isEmpty
            ? TextField(
                style: AppStyles.r2.copyWith(
                    color: AppColors.colorTitle, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: AppStyles.r2.copyWith(
                      color: AppColors.colorHint1, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ))
            : DropdownButton<String>(
                isExpanded: true,
                underline: Container(),
                value: dropValue.isNotEmpty ? dropValue : null,
                onChanged: (value) {},
                items: listDrop.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                alignment: AlignmentDirectional.centerStart,
                style: AppStyles.r2.copyWith(
                    color: AppColors.colorTitle, fontWeight: FontWeight.w500),
                icon: SvgPicture.asset(AppImages.icDropdownSpinner),
                hint: Text(
                  hint,
                  style: AppStyles.r2.copyWith(
                      color: AppColors.colorHint1, fontWeight: FontWeight.w400),
                ),
              ),
      ),
    ],
  );
}

Widget spinnerFormV2(
    {required BuildContext context,
    required String hint,
    required bool required,
    required String dropValue,
    required List<String> listDrop,
    double height = 0,
    TextInputType inputType = TextInputType.text,
    TextEditingController? controlTextField,
    TextInputAction? typeAction,
  Function(String value)? function,
  FocusNode? focusNode
}) {
  return Column(
    children: [
      Container(
        height: height > 45 ? height : 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Color(0xFFE3EAF2))),
        child: listDrop.isEmpty
            ? Padding(
                padding: EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 6),
                child: TextField(
                    controller: controlTextField,
                    keyboardType: inputType,
                    autofocus: required,
                    textInputAction: typeAction,
                    style: AppStyles.r2.copyWith(
                        color: AppColors.colorTitle,
                        fontWeight: FontWeight.w500),
                    onChanged: (value) {
                      function!.call(value);
                    },
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: AppStyles.r2.copyWith(
                          color: AppColors.colorHint1,
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    )),
              )
            : DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
                // selectedItemHighlightColor: Colors.red,
                buttonHeight: 60,
                focusNode: focusNode,
                buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Color(0xFFE3EAF2))),
                isExpanded: true,
                value: dropValue.isNotEmpty ? dropValue : null,
                onChanged: (value) {
                  function!.call(value!);
                },

                items: listDrop.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                style: AppStyles.r2.copyWith(
                    color: AppColors.colorTitle, fontWeight: FontWeight.w500),
                icon: SvgPicture.asset(AppImages.icDropdownSpinner),
                hint: Text(
                  hint,
                  style: AppStyles.r2.copyWith(
                      color: AppColors.colorHint1, fontWeight: FontWeight.w400),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                },
              ),
      ),
    ],
  );
}

Widget multiSelectDropdownForm(
    {required BuildContext context,
    required List<String> items,
    required List<String> selectedItems,
    required String hint,
    required TextStyle hintStyle,
    required String label,
    required bool required,
    required double width}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(
        child: Container(
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
      ),
      Container(
        height: 45,
        width: width,
        padding: EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 6),
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Color(0xFFE3EAF2))),
        child: DropDownMultiSelect(
          options: items,
          onChanged: (value) {
            selectedItems = value;
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFFFFFFF),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFFFFFFF),
                width: 1,
              ),
            ),
          ),
          selectedValues: selectedItems,
          icon: SvgPicture.asset(AppImages.icDropdownSpinner),
          childBuilder: (selectedItems) {
            return Row(
              children: [
                Expanded(
                  child: selectedItems.isNotEmpty
                      ? Text(
                          selectedItems.join(', '),
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            color: Color(0xFF415263),
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        )
                      : Text(
                          hint,
                          style: hintStyle,
                          maxLines: 1,
                        ),
                ),
                SvgPicture.asset(AppImages.icDropdownSpinner),
              ],
            );
          },
        ),
      ),
    ],
  );
}

Widget expandableV1({required String label, required Widget child}) {
  return ExpandableNotifier(
    child: Column(
      children: [
        Expandable(
          theme: ExpandableThemeData(hasIcon: false),
          collapsed: ExpandableButton(
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Color(0xFFE3EAF2)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          expanded: Column(
            children: [
              ExpandableButton(
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  padding: EdgeInsets.only(left: 13, top: 13, bottom: 11),
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.black,
                        size: 20,
                      ),
                      Text(
                        label,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color(0xFFE3EAF2)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                    ]),
                child: child,
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

Widget LoadingCirculApi() {
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: 4,
      color: AppColors.colorBackground,
    ),
  );
}

Widget lockedBox(
    {required String label,
    required String content,
    required bool required,
    required bool isIcon,
    required double width}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(
        child: Container(
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
      ),
      Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Container(
            height: 45,
            width: width,
            padding: EdgeInsets.only(left: 18, right: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Color(0xFFE3EAF2), width: 1)),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      content,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xFFCFCFCF),
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                  ),
                ),
                Visibility(
                    visible: isIcon,
                    child: SvgPicture.asset(AppImages.icArrowDownLockedBox))
              ],
            )),
      ),
    ],
  );
}

Widget customRadioGroup(
    {required int value,
    required String label,
    required RxInt groupValue,
    required var onChange}) {
  return InkWell(
    onTap: () {
      onChange(value);
    },
    child: Row(
      children: [
        Obx(() => Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value == groupValue.value
                    ? Colors.blue
                    : Colors.transparent,
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: value == groupValue.value
                    ? Icon(
                        Icons.check,
                        size: 16.0,
                        color: Colors.white,
                      )
                    : null,
              ),
            )),
        SizedBox(width: 8.0),
        Text(label),
      ],
    ),
  );
}

Widget customRadioMutiple(
    {required var width,
    required String text,
    required var check,
    required var changeValue}) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, top: 16),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      InkWell(
          onTap: () {
            changeValue(!check.value);
          },
          splashColor: Colors.black38,
          child: Obx(() => check.value
              ? SvgPicture.asset(AppImages.icRadioChecked)
              : SvgPicture.asset(AppImages.icRadioUnChecked))),
      SizedBox(
        width: 10,
      ),
      SizedBox(
          width: width * 0.75,
          child: Text(
            text,
            style: AppStyles.r2B3A4A_12_500,
          )),
    ]),
  );
}

SvgPicture iconOnlyUnRadio() {
  return SvgPicture.asset(AppImages.icUnSelectRadio, height: 20, width: 20,);
}

SvgPicture iconOnlyRadio() {
  return SvgPicture.asset(AppImages.icSelectRadio, height: 20, width: 20,);
}



