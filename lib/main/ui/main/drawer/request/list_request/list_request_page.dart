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
              InkWell(
                onTap: () {
                  Get.toNamed(RouteConfig.createRequest);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 35),
                  child: SvgPicture.asset(AppImages.icCreateRequest),
                ),
              )
            ],
            title: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(AppLocalizations.of(context)!.textListOfRequest,
                  style: AppStyles.title),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                        child: Container(
                          width: width * .06,
                          height: 42,
                          child: TextFormField(
                            cursorColor: AppColors.colorText1,
                            onChanged: (value) {
                              String key = value.trim();
                              controller.onSearchChanged(key);
                            },
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              isDense: true,
                              // errorText: controller.isSubmitPass
                              //     ? (controller.controllerPass.value.text
                              //     .length <
                              //     6
                              //     ? ""
                              //     : null)
                              //     : null,
                              hintText: AppLocalizations.of(context)!
                                  .textSearchCodeProvence,
                              hintStyle: AppStyles.r2.copyWith(
                                  color:
                                      AppColors.colorText4.withOpacity(0.75)),

                              // filled: true,
                              // fillColor: Colors.white,
                              // border: InputBorder.none,
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.transparent)),
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
                          child: Text(
                              AppLocalizations.of(context)!.textCreateRequest,
                              style: AppStyles.r7)),

                      Tab(
                          child: Text(
                        AppLocalizations.of(context)!.textCreateRequestWithout,
                        style: AppStyles.r7,
                      )),
                      Tab(
                          child: Text(
                        AppLocalizations.of(context)!.textSurveyOfflineSuccess,
                        style: AppStyles.r7,
                      )),
                      Tab(
                          child: Text(
                        AppLocalizations.of(context)!.textConnected,
                        style: AppStyles.r7,
                      )),
                      Tab(
                          child: Text(
                        AppLocalizations.of(context)!.textDeploying,
                        style: AppStyles.r7,
                      )),
                      Tab(
                          child: Text(
                              AppLocalizations.of(context)!.textComplete,
                              style: AppStyles.r7)),
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
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 16),
                              child: Text(
                                AppLocalizations.of(context)!.textListOfRequest,
                                style: AppStyles.r6.copyWith(
                                    color: AppColors.colorText1,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                            // InkWell(
                            //   onTap: () {
                            //     showDialogTransferRequest(context);
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(top: 10),
                            //     child:
                            //         SvgPicture.asset(AppImages.icTranferSaff),
                            //   ),
                            // ),
                            // InkWell(
                            //   onTap: () {
                            //     showDialogCancelRequest(context);
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(
                            //         left: 16, right: 16, top: 20),
                            //     child:
                            //         SvgPicture.asset(AppImages.icCancelRequest),
                            //   ),
                            // )
                          ],
                        ),
                        Expanded(
                            child: TabBarView(
                          controller: controller.tabController,
                          children: [
                            // first tab bar view widget
                            ListRequestTabPage(
                              status: RequestStatus.CREATE_REQUEST,
                              listRequestLogic: controller,
                              key: controller.globalKey1,
                            ),
                            ListRequestTabPage(
                              status:
                                  RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY,
                              listRequestLogic: controller,
                              key: controller.globalKey2,
                            ),
                            ListRequestTabPage(
                              status: RequestStatus.SURVEY_OFFLINE_SUCCESSFULLY,
                              listRequestLogic: controller,
                              key: controller.globalKey3,
                            ),
                            ListRequestTabPage(
                              status: RequestStatus.CONNECTED,
                              listRequestLogic: controller,
                              key: controller.globalKey4,
                            ),
                            ListRequestTabPage(
                              status: RequestStatus.DEPLOYING,
                              listRequestLogic: controller,
                              key: controller.globalKey5,
                            ),
                            ListRequestTabPage(
                              status: RequestStatus.COMPLETE,
                              listRequestLogic: controller,
                              key: controller.globalKey6,
                            ),
                            ListRequestTabPage(
                              status: RequestStatus.CANCEL,
                              listRequestLogic: controller,
                              key: controller.globalKey7,
                            ),
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

  void showDialogAdvanceSearch(
      BuildContext context, ListRequestLogic controller) {
    controller.searchRequest.reset();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogAdvancedSearchPage(
              onSubmit: (model) {
                if (controller.index == model.getPositionStatus(context)) {
                  controller.updateSearchRequest(model, context);
                  if (controller.index == 0) {
                    controller.globalKey1.currentState!.getListRequest("");
                  } else if (controller.index == 1) {
                    controller.globalKey2.currentState!.getListRequest("");
                  } else if (controller.index == 2) {
                    controller.globalKey3.currentState!.getListRequest("");
                  } else if (controller.index == 3) {
                    controller.globalKey4.currentState!.getListRequest("");
                  } else if (controller.index == 4) {
                    controller.globalKey5.currentState!.getListRequest("");
                  } else if (controller.index == 5) {
                    controller.globalKey6.currentState!.getListRequest("");
                  } else if (controller.index == 6) {
                    controller.globalKey7.currentState!.getListRequest("");
                  }
                } else {
                  controller.updateSearchRequest(model, context);
                }
              },
              searchRequest: controller.searchRequest);
        });
  }
}
