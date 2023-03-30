import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/networks/response/list_request_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_tab_item.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/tab_one/list_request_tab_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/common.dart';

class ListRequestTabPage extends StatefulWidget {
  String status;
  ListRequestLogic listRequestLogic;
  ListRequestTabPage(
      {required this.status, required this.listRequestLogic, required Key key})
      : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return GetBuilder(
  //     init: ListRequestTabLogic(status),
  //     builder: (controller) {
  //       return controller.isLoading
  //           ? LoadingCirculApi()
  //           : controller.listRequest.isEmpty
  //               ? InkWell(
  //                   child: Center(
  //                     child: Text("No data $status"),
  //                   ),
  //                   onTap: () {
  //                     // Get.toNamed(RouteConfig.requestDetail);
  //                   },
  //                 )
  //               : ListView.builder(
  //                   itemCount: controller.listRequest.length,
  //                   itemBuilder: (context, index) {
  //                     return InkWell(
  //                       onTap: () {
  //                         List<String> listArgument = ["${controller.listRequest[index].id}",status];
  //                         Get.toNamed(RouteConfig.requestDetail, arguments: listArgument);
  //                       },
  //                       child:
  //                           ListRequestTabItem(controller.listRequest[index]),
  //                     );
  //                   });
  //     },
  //   );
  // }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListRequestTabState(status, listRequestLogic);
  }
  // static ListRequestTabState? of(BuildContext context) =>
  //     context.findAncestorStateOfType<_ListRequestTabState>();
}

class ListRequestTabState extends State<ListRequestTabPage> {
  String status;

  bool isLoading = false;
  List<RequestDetailModel> listRequest = [];
  ListRequestLogic listRequestLogic;

  ListRequestTabState(this.status, this.listRequestLogic);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListRequest(listRequestLogic.keySearch);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingCirculApi()
        : listRequest.isEmpty
            ? InkWell(
                child: Center(
                  child: Text(AppLocalizations.of(context)!.textNoData),
                ),
                onTap: () {
                  // Get.toNamed(RouteConfig.requestDetail);
                },
              )
            : ListView.builder(
                itemCount: listRequest.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      List<String> listArgument = [
                        "${listRequest[index].id}",
                        status
                      ];
                      Get.toNamed(RouteConfig.requestDetail,
                          arguments: listArgument);
                    },
                    child: ListRequestTabItem(listRequest[index]),
                  );
                });
  }

  void getListRequest(String key) async {
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> params = {
      "service": key.isEmpty ? listRequestLogic.searchRequest.service : "",
      "code": key.isEmpty ? listRequestLogic.searchRequest.code : "",
      "status": status,
      "province": key.isEmpty ? listRequestLogic.searchRequest.province : "",
      "staffCode": key.isEmpty ? listRequestLogic.searchRequest.staffCode : "",
      "fromDate": key.isEmpty ? listRequestLogic.searchRequest.fromDate : "",
      "toDate": key.isEmpty ? listRequestLogic.searchRequest.toDate : "",
      "key": key,
      "page": "0",
      "pageSize": "10",
      "sort": "createdDate"
    };
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_LIST_REQUEST,
        params: params,
        isCancel: false,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success :");
            listRequest.clear();
            ListRequestResponse listRequestResponse =
                ListRequestResponse.fromJson(response.data['data']);
            setState(() {
              listRequest.addAll(listRequestResponse.list);
            });
          } else {
            print("error: ${response.status}");
          }
          setState(() {
            isLoading = false;
          });
        },
        onError: (error) {
          try {
            setState(() {
              isLoading = false;
            });
            Common.showMessageError(error, context);
          }catch(e){
            print(e.toString());
          }
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // ApiUtil.getInstance()!.cancelToken!.cancel();
    super.dispose();
  }
}
