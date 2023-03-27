// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';
import '../../../../../router/route_config.dart';
import '../manage_contact_logic.dart';

class ManageContactPage extends GetView<ManageContactLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
      init: ManageContactLogic(),
      builder: (controller) {
        return SafeArea(
            child: Scaffold(
          body: SingleChildScrollView(
            child: Wrap(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF8FBFB),
                          ),
                          width: width,
                          height: 150,
                        ),
                        SvgPicture.asset(
                          AppImages.bgAppbar,
                          width: width,
                        ),
                        Positioned(
                          top: 40,
                          left: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  AppLocalizations.of(context)!
                                      .textManageContact,
                                  style: AppStyles.title),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 35,
                            left: 20,
                            child: InkWell(
                              onTap: () => Get.back(),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(13)),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 15,
                                    color: AppColors.colorTitle,
                                  ),
                                ),
                              ),
                            )),
                        Positioned(
                          top: 35,
                          right: 20,
                          child: InkWell(
                            child: SvgPicture.asset(
                              AppImages.icCreateContact,
                              width: 30,
                              height: 30,
                            ),
                            onTap: () {
                              Get.toNamed(RouteConfig.createContact);
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Color(0xFFE3EAF2)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                          ]),
                      child: ExpandablePanel(
                        header: SizedBox(
                          height: 40,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                Icons.search,
                                size: 20,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.bottom,
                                  autocorrect: true,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Barlow',
                                      color: Color(0xFF415263),
                                      fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        ?.textSearch,
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Barlow',
                                        fontWeight: FontWeight.w300),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                        collapsed: SizedBox(
                          width: 0,
                          height: 0,
                        ),
                        expanded: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            DottedLine(
                              dashColor: Color(0xFFE3EAF2),
                              dashGapLength: 3,
                              dashLength: 4,
                            ),
                            inputForm(
                                label: AppLocalizations.of(context)!
                                    .textPhoneNumber,
                                hint: AppLocalizations.of(context)!
                                    .hintPhoneNumber,
                                required: false,
                                inputType: TextInputType.number),
                            Container(
                              margin: EdgeInsets.only(left: 20, top: 15),
                              alignment: Alignment.topLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .textIdentifyNumber,
                                style: TextStyle(
                                    color: AppColors.colorText1,
                                    fontFamily: 'Barlow',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 95,
                                  padding: EdgeInsets.only(
                                      left: 12, top: 6, bottom: 6, right: 6),
                                  margin: EdgeInsets.only(
                                      left: 15, right: 10, top: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      border:
                                          Border.all(color: Color(0xFFE3EAF2))),
                                  child: Obx(
                                    () => DropdownButton<String>(
                                        isExpanded: true,
                                        underline: Container(),
                                        value: controller.dni.value,
                                        onChanged: (String? value) =>
                                            controller.dni.value = value!,
                                        items: controller.identifyNumberType
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem(
                                              value: value, child: Text(value));
                                        }).toList(),
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Barlow',
                                            color: Color(0xFF007689),
                                            fontWeight: FontWeight.w500),
                                        icon: SvgPicture.asset(
                                            AppImages.icDropdownSpinner)),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 45,
                                    margin: EdgeInsets.only(right: 15, top: 10),
                                    child: TextField(
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Barlow',
                                          color: Color(0xFF415263),
                                          fontWeight: FontWeight.w500),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)!
                                            .hintIdentifyNumber,
                                        hintStyle: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Barlow',
                                            fontWeight: FontWeight.w300),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          borderSide: BorderSide(
                                            color: Color(0xFFE3EAF2),
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
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
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 15, top: 24, right: 15, bottom: 10),
                              child: InkWell(
                                splashColor: Colors.black38,
                                onTap: () {},
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: AppColors.colorText3,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFFB3BBC5),
                                            blurRadius: 5)
                                      ]),
                                  child: Center(
                                      child: Text(
                                    AppLocalizations.of(context)!
                                        .textSearch
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                        theme: ExpandableThemeData(
                            expandIcon: Icons.arrow_drop_down,
                            collapseIcon: Icons.arrow_drop_up,
                            iconColor: Color(0xFF415263),
                            iconSize: 30,
                            iconPadding: EdgeInsets.only(right: 10, top: 5)),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Color(0xFFE3EAF2)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                          ]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 35,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .textContactList,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Barlow',
                                        color: Color(0xFF2B3A4A),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                InkWell(
                                    child: SvgPicture.asset(
                                  AppImages.icSortAlphabet,
                                  width: 33,
                                  height: 30,
                                )),
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: controller.listContact
                                .map((item) => _contactItem(
                                    contact: item, context: context))
                                .toList(),
                          ),
                          SizedBox(
                            height: 150,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
      },
    );
  }
}

Widget _contactItem({required Contact contact, required BuildContext context}) {
  return Column(
    children: [
      DottedLine(
        dashColor: Color(0xFFE3EAF2),
        dashGapLength: 3,
        dashLength: 4,
      ),
      SizedBox(
        height: 25,
      ),
      Row(
        children: [
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.textFullName,
              style: TextStyle(
                  color: AppColors.colorText2,
                  fontSize: 15,
                  fontFamily: 'Barlow'),
            ),
          ),
          Text(
            contact.name,
            style: TextStyle(
                color: Color(0xFF415263),
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 'Barlow'),
          ),
          SizedBox(
            width: 25,
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.textDateOfBirth,
              style: TextStyle(
                  color: AppColors.colorText2,
                  fontSize: 15,
                  fontFamily: 'Barlow'),
            ),
          ),
          Text(
            contact.dob,
            style: TextStyle(
                color: Color(0xFF415263),
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 'Barlow'),
          ),
          SizedBox(
            width: 25,
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.textTypeOfDocument,
              style: TextStyle(
                  color: AppColors.colorText2,
                  fontSize: 15,
                  fontFamily: 'Barlow'),
            ),
          ),
          Text(
            contact.type,
            style: TextStyle(
                color: Color(0xFF415263),
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 'Barlow'),
          ),
          SizedBox(
            width: 25,
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.textIdentifyNumber,
              style: TextStyle(
                  color: AppColors.colorText2,
                  fontSize: 15,
                  fontFamily: 'Barlow'),
            ),
          ),
          Text(
            contact.idNumber,
            style: TextStyle(
                color: AppColors.colorContent,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 'Barlow'),
          ),
          SizedBox(
            width: 25,
          ),
        ],
      ),
      SizedBox(
        height: 25,
      ),
    ],
  );
}
