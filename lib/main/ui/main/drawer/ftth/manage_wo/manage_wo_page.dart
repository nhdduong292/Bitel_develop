// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/ui/main/drawer/ftth/manage_wo/manage_wo_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/manage_wo/wo_detail_page.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';
import '../../../../../utils/common_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ManageWOPage extends GetView<ManageWOLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return GetBuilder(
        init: ManageWOLogic(),
        builder: (controller) {
          return SafeArea(
              child: Scaffold(
                  body: Column(
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
                        Text(AppLocalizations.of(context)!.textWOManagement,
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
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.textSearch,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                color: AppColors.colorText1,
                                fontWeight: FontWeight.w600),
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
                      Row(
                        children: [
                          SizedBox(
                            width: 180,
                            child: spinnerFormNormal(
                                context: context,
                                label: "",
                                hint: AppLocalizations.of(context)!.hintWOType,
                                required: false,
                                items: controller.listWOTypes,
                                dropdownValue: controller.WOType),
                          ),
                          Expanded(
                              child: inputForm(
                                  label: "",
                                  hint: AppLocalizations.of(context)!
                                      .hintISDNAccount,
                                  required: false,
                                  inputType: TextInputType.text)),
                        ],
                      ),
                      bottomButton(
                          text: AppLocalizations.of(context)!.textSearch,
                          onTap: () {}),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DialogAdvancedSearch();
                              });
                        },
                        child: Text(
                            AppLocalizations.of(context)!.textAdvancedSearch,
                            style: TextStyle(
                                color: AppColors.colorTitle,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto')),
                      ),
                      SizedBox(
                        height: 5,
                      ),
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
                height: 20,
              ),
              Container(
                height: 55,
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color(0xFFE3EAF2)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)
                    ]),
                child: TabBar(
                  controller: controller.tabController,
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.textAssigned),
                    Tab(text: AppLocalizations.of(context)!.textNotAssign),
                  ],
                  unselectedLabelColor: AppColors.colorText2,
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(120.0),
                    color: AppColors.colorSelectTab,
                  ),
                  labelStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                // height: 600,
                child:
                    TabBarView(controller: controller.tabController, children: [
                  tabBarView(
                      listWO: controller.assignedWOList, context: context),
                  tabBarView(
                      listWO: controller.notAssignWOList, context: context)
                ]),
              ),
            ],
          )));
        });
  }
}

Widget tabBarView({
  required List<WorkOrder> listWO,
  required BuildContext context,
}) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
    padding: EdgeInsets.symmetric(vertical: 12),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color(0xFFE3EAF2)),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0xFFE3EAF2), blurRadius: 3)]),
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
                  AppLocalizations.of(context)!.textWOList,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
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
        DottedLine(
          dashColor: Color(0xFFE3EAF2),
          dashGapLength: 3,
          dashLength: 4,
        ),
        Expanded(
          child: ListView.separated(
            itemCount: listWO.length,
            itemBuilder: (context, index) {
              return _woItem(wo: listWO[index], context: context);
            },
            separatorBuilder: (BuildContext context, int index) {
              return DottedLine(
                dashColor: Color(0xFFE3EAF2),
                dashGapLength: 3,
                dashLength: 4,
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget _woItem({required WorkOrder wo, required BuildContext context}) {
  return InkWell(
    onTap: () {Get.to(() => WODetailPage(wo: wo,));},
    child: Column(
      children: [
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
                AppLocalizations.of(context)!.textFTTHWOType,
                style: TextStyle(
                    color: AppColors.colorText2,
                    fontSize: 15,
                    fontFamily: 'Roboto'),
              ),
            ),
            Text(
              wo.type,
              style: TextStyle(
                  color: Color(0xFF415263),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
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
                AppLocalizations.of(context)!.textLine,
                style: TextStyle(
                    color: AppColors.colorText2,
                    fontSize: 15,
                    fontFamily: 'Roboto'),
              ),
            ),
            Text(
              wo.line,
              style: TextStyle(
                  color: Color(0xFF415263),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
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
                AppLocalizations.of(context)!.textAddress,
                style: TextStyle(
                    color: AppColors.colorText2,
                    fontSize: 15,
                    fontFamily: 'Roboto'),
              ),
            ),
            Text(
              wo.address,
              style: TextStyle(
                  color: Color(0xFF415263),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
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
                AppLocalizations.of(context)!.textStatus,
                style: TextStyle(
                    color: AppColors.colorText2,
                    fontSize: 15,
                    fontFamily: 'Roboto'),
              ),
            ),
            Text(
              wo.isStarted
                  ? AppLocalizations.of(context)!.textStarted
                  : AppLocalizations.of(context)!.textNotStarted,
              style: TextStyle(
                  color: AppColors.colorContent,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
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
                AppLocalizations.of(context)!.textDeadline,
                style: TextStyle(
                    color: AppColors.colorText2,
                    fontSize: 15,
                    fontFamily: 'Roboto'),
              ),
            ),
            Text(
              wo.deadline,
              style: TextStyle(
                  color: Color(0xFF415263),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
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
    ),
  );
}

class DialogAdvancedSearch extends Dialog {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder(
        init: ManageWOLogic(),
        builder: (controller) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            alignment: Alignment.center,
            insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
            child: SingleChildScrollView(
              child: Stack(children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(AppLocalizations.of(context)!.textAdvancedSearch,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            fontSize: 18)),
                    SizedBox(
                      height: 20,
                    ),
                    DottedLine(
                      dashColor: Color(0xFFE3EAF2),
                      dashGapLength: 3,
                      dashLength: 4,
                    ),
                    multiSelectDropdownForm(
                        context: context,
                        items: controller.serviceItems,
                        label: AppLocalizations.of(context)!.textService,
                        required: false,
                        hint: AppLocalizations.of(context)!.hintTelecomService,
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            color: Color(0xFF415263),
                            fontWeight: FontWeight.w500),
                        width: width * 0.52,
                        selectedItems: controller.chosenServiceItems.value),
                    multiSelectDropdownForm(
                        context: context,
                        items: controller.listWOTypes,
                        label: AppLocalizations.of(context)!.textWOType,
                        required: false,
                        hint: AppLocalizations.of(context)!.hintWOType,
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            color: Color(0xFF415263),
                            fontWeight: FontWeight.w500),
                        width: width * 0.52,
                        selectedItems: controller.chosenWOTypes.value),
                    inputFormV2(
                        label: AppLocalizations.of(context)!.textRequestCode,
                        hint: AppLocalizations.of(context)!.hintEnterCode,
                        required: false,
                        inputType: TextInputType.text,
                        width: width * 0.52),
                    inputFormV2(
                        label: AppLocalizations.of(context)!.textAccount,
                        hint: AppLocalizations.of(context)!.hintAccount,
                        required: false,
                        inputType: TextInputType.text,
                        width: width * 0.52),
                    inputFormV2(
                        label:
                            AppLocalizations.of(context)!.textCustomerPhoneNumber,
                        hint: AppLocalizations.of(context)!.hintEnterPhone,
                        required: false,
                        inputType: TextInputType.text,
                        width: width * 0.52),
                    multiSelectDropdownForm(
                        context: context,
                        items: controller.listTeams,
                        label: AppLocalizations.of(context)!.textTeam,
                        required: false,
                        hint: AppLocalizations.of(context)!.hintChooseTeam,
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            color: Color(0xFF415263),
                            fontWeight: FontWeight.w300),
                        width: width * 0.52,
                        selectedItems: controller.chosenTeams.value),
                    multiSelectDropdownForm(
                        context: context,
                        items: controller.listTechnician,
                        label: AppLocalizations.of(context)!.textTechnician,
                        required: false,
                        hint: AppLocalizations.of(context)!.hintChooseTechnician,
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            color: Color(0xFF415263),
                            fontWeight: FontWeight.w300),
                        width: width * 0.52,
                        selectedItems: controller.chosenTechnician.value),
                    multiSelectDropdownForm(
                        context: context,
                        items: controller.listStatus,
                        label: AppLocalizations.of(context)!.textStatus,
                        required: false,
                        hint: AppLocalizations.of(context)!.textComplete,
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            color: Color(0xFF415263),
                            fontWeight: FontWeight.w500),
                        width: width * 0.52,
                        selectedItems: controller.chosenStatus.value),
                    Container(
                      padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                      child: Row(
                        children: [
                          Expanded(flex: 2, child:  Text(
                            AppLocalizations.of(context)!.textRequestDate,
                            style: AppStyles.r8.copyWith(
                                color: AppColors.colorText1.withOpacity(0.85),
                                fontWeight: FontWeight.w400),
                          )),
                          Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: InkWell(
                                        onTap: () {
                                          _selectDate(context,controller, true);
                                        },
                                        child:  Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(24),
                                              border: Border.all(color: Color(0xFFE3EAF2))),
                                          padding: EdgeInsets.only(top: 11,bottom: 11, left: 16, right: 16),
                                          child: Text.rich(TextSpan(
                                              style: AppStyles.r2.copyWith(color: controller.fromDate.value.isEmpty  ? AppColors.colorHint1 : AppColors.colorText1, fontWeight: FontWeight.w400),
                                              children: [
                                                WidgetSpan(
                                                  child: controller.fromDate.value.isEmpty ? Padding(
                                                    padding: const EdgeInsets.only(right: 8.0),
                                                    child: SvgPicture.asset(AppImages.icSelectDate),
                                                  ) : Container(),
                                                ),

                                                TextSpan(
                                                  text: controller.fromDate.value.isEmpty ? AppLocalizations.of(context)!.textFrom: controller.fromDate.value,
                                                )
                                              ]
                                          )),
                                        )),
                                  ),
                                  SizedBox(width: 12,),
                                  Expanded(
                                    flex:1,
                                    child: InkWell(
                                        onTap: () {
                                          _selectDate(context,controller,false);
                                        },
                                        child:  Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(24),
                                              border: Border.all(color: Color(0xFFE3EAF2))),
                                          padding: EdgeInsets.only(top: 11,bottom: 11, left: 16, right: 16),
                                          child: Text.rich(TextSpan(
                                              style: AppStyles.r2.copyWith(color: controller.toDate.value.isEmpty  ? AppColors.colorHint1 : AppColors.colorText1, fontWeight: FontWeight.w400),
                                              children: [
                                                WidgetSpan(
                                                  child: controller.toDate.value.isEmpty ? Padding(
                                                    padding: const EdgeInsets.only(right: 8.0),
                                                    child: SvgPicture.asset(AppImages.icSelectDate),
                                                  ) : Container(),
                                                ),

                                                TextSpan(
                                                  text: controller.toDate.value.isEmpty ? AppLocalizations.of(context)!.textTo: controller.toDate.value,
                                                )
                                              ]
                                          )),
                                        )),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                    bottomButton(
                        text: AppLocalizations.of(context)!.textSearch,
                        onTap: () => Get.back()),
                    SizedBox(height: 20,)
                  ],
                ),
                Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.close,
                        color: Color(0xFF4B5765),
                        size: 25,
                      ),
                    ))
              ]),
            ),
          );
        });
  }

  _selectDate(BuildContext context, ManageWOLogic control, bool from) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: control.selectDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if(from){
      control.setFromDate(picked!);
    } else {
      control.setToDate(picked!);
    }
  }
}
