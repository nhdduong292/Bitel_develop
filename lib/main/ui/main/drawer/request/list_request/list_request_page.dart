import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_advance_search_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_cancel_request_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_transfer_request_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/tab_one/list_request_tab_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/tab_two/tab_two_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/tab_two/tab_two_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/tab_one/list_request_tab_page.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListRequestPage extends GetWidget {
  GlobalKey<ListRequestTabState> globalKey1 = GlobalKey();
  GlobalKey<ListRequestTabState> globalKey2 = GlobalKey();
  GlobalKey<ListRequestTabState> globalKey3 = GlobalKey();
  GlobalKey<ListRequestTabState> globalKey4 = GlobalKey();
  GlobalKey<ListRequestTabState> globalKey5 = GlobalKey();
  GlobalKey<ListRequestTabState> globalKey6 = GlobalKey();
  GlobalKey<ListRequestTabState> globalKey7 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: ListRequestLogic(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.only(left: 18, bottom: 18, top: 2),
              child: GestureDetector(
                child: SvgPicture.asset(AppImages.icBack),
                onTap: () {
                  Get.back();
                },
              ),
            ),
            elevation: 0.0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 35),
                child: GestureDetector(
                  child: SvgPicture.asset(AppImages.icCreateRequest),
                  onTap: () {
                    Get.toNamed(RouteConfig.createRequest);
                  },
                ),
              )
            ],
            title: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(AppLocalizations.of(context)!.textListOfRequest, style: AppStyles.title),
            ),
            toolbarHeight: 100,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: AppColors.colorBackground,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(width / 2, 20),
                      bottomRight: Radius.elliptical(width / 2, 20))),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 55,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SvgPicture.asset(AppImages.icSearch),
                      ),
                      Expanded(
                      //     child: Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   child: Text(AppLocalizations.of(context)!.textSearchCodeProvence, style: AppStyles.r2.copyWith(color: AppColors.colorText4.withOpacity(0.75)),),
                      // )),
                        child:  TextField(
                          cursorColor: AppColors.colorText1,
                          onChanged: (value) {
                            String key = value.trim();
                            if(controller.index == 0) {
                              globalKey1.currentState!.getListRequest(key);
                            } else if(controller.index == 1){
                              globalKey2.currentState!.getListRequest(key);
                            } else if(controller.index == 2){
                              globalKey3.currentState!.getListRequest(key);
                            } else if(controller.index == 3){
                              globalKey4.currentState!.getListRequest(key);
                            } else if(controller.index == 4){
                              globalKey5.currentState!.getListRequest(key);
                            } else if(controller.index == 5){
                              globalKey6.currentState!.getListRequest(key);
                            } else if(controller.index == 6){
                              globalKey7.currentState!.getListRequest(key);
                            }
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            // errorText: controller.isSubmitPass
                            //     ? (controller.controllerPass.value.text
                            //     .length <
                            //     6
                            //     ? ""
                            //     : null)
                            //     : null,
                            hintText: AppLocalizations.of(context)!.textSearchCodeProvence,
                            hintStyle: AppStyles.r2.copyWith(color: AppColors.colorText4.withOpacity(0.75)),

                            // filled: true,
                            // fillColor: Colors.white,
                            // border: InputBorder.none,
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.transparent)),
                            errorBorder: const UnderlineInputBorder(
                              //<-- SEE HERE
                              borderSide: BorderSide(
                                  width: 1, color: Colors.redAccent),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              //<-- SEE HERE
                              borderSide: BorderSide(
                                  width: 1, color: Colors.transparent),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialogAdvanceSearch(context, controller);
                        },
                        child: SvgPicture.asset(AppImages.icAdvanceSearch),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 45,
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: TabBar(
                    isScrollable: true,
                    controller: controller.tabController,
                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                      color: AppColors.colorSelectTab,
                    ),
                    labelColor: Colors.white,
                    onTap: (value) {
                      print("tap: $value");
                    },
                    unselectedLabelColor: AppColors.colorText2,
                    tabs: [
                      // first tab [you can add an icon using the icon property]
                      Tab(
                        child: Text(AppLocalizations.of(context)!.textCreateRequest,
                            style: AppStyles.r7)

                      ),

                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.textCreateRequestWithout,
                            style: AppStyles.r7,)
                      ),
                      Tab(
                          child: Text(
                            AppLocalizations.of(context)!.textSurveyOfflineSuccess,
                            style: AppStyles.r7,)
                      ),
                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.textConnected,
                            style: AppStyles.r7,)
                      ),
                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.textDeploying,
                            style: AppStyles.r7,)
                      ),
                      Tab(
                        child: Text(
                            AppLocalizations.of(context)!.textComplete,
                            style: AppStyles.r7)
                      ),
                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.textCancel,
                            style: AppStyles.r7,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          width: 1, color: Colors.black.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 16),
                              child: Text(AppLocalizations.of(context)!.textListOfRequest, style: AppStyles.r6.copyWith(color: AppColors.colorText1, fontWeight: FontWeight.w600),),
                            )),
                            InkWell(
                              onTap: () {
                                showDialogTransferRequest(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SvgPicture.asset(AppImages.icTranferSaff),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialogCancelRequest(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                                child: SvgPicture.asset(AppImages.icCancelRequest),
                              ),
                            )
                          ],
                        ),
                        Expanded(child: TabBarView(
                          controller: controller.tabController,
                          children: [
                            // first tab bar view widget
                            ListRequestTabPage(status: RequestStatus.CREATE_REQUEST, key: globalKey1,),
                            ListRequestTabPage(status:RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY, key: globalKey2,),
                            ListRequestTabPage(status:RequestStatus.SURVEY_OFFLINE_SUCCESSFULLY, key: globalKey3,),
                            ListRequestTabPage(status:RequestStatus.CONNECTED, key: globalKey4,),
                            ListRequestTabPage(status:RequestStatus.DEPLOYING, key: globalKey5,),
                            ListRequestTabPage(status:RequestStatus.COMPLETE, key: globalKey6,),
                            ListRequestTabPage(status:RequestStatus.CANCEL, key: globalKey7,),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDialogTransferRequest(BuildContext context) {
    // showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (context) {
    //       return DialogTransferRequest(
    //         onSubmit: () {},
    //       );
    //     });
  }

  void showDialogCancelRequest(BuildContext context) {
    // showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (context) {
    //       return DialogCancelRequest(
    //         onSubmit: () {},
    //       );
    //     });
  }

  void showDialogAdvanceSearch(BuildContext context, ListRequestLogic controller) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogAdvancedSearchPage(
            onSubmit: (model) {
                if(controller.index == model.getPositionStatus()) {
                  controller.updateSearchRequest(model);
                  if(controller.index == 0) {
                    globalKey1.currentState!.getListRequest("");
                  } else if(controller.index == 1){
                    globalKey2.currentState!.getListRequest("");
                  } else if(controller.index == 2){
                    globalKey3.currentState!.getListRequest("");
                  } else if(controller.index == 3){
                    globalKey4.currentState!.getListRequest("");
                  } else if(controller.index == 4){
                    globalKey5.currentState!.getListRequest("");
                  } else if(controller.index == 5){
                    globalKey6.currentState!.getListRequest("");
                  } else if(controller.index == 6){
                    globalKey7.currentState!.getListRequest("");
                  }
                }else {
                  controller.updateSearchRequest(model);
                }
            },
           searchRequest: controller.searchRequest);
        });
  }
}
