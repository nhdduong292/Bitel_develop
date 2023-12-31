import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/response/list_request_response.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/sale/sale_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_tab_item.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../services/connection_service.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/values.dart';

class ListRequestTabPage extends StatefulWidget {
  String status;
  ListRequestLogic listRequestLogic;
  Function callbackTotalRequest;

  ListRequestTabPage(
      {required this.status,
      required this.listRequestLogic,
      required Key key,
      required this.callbackTotalRequest})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListRequestTabState(status, listRequestLogic, callbackTotalRequest);
  }
}

class ListRequestTabState extends State<ListRequestTabPage> {
  String status;

  bool isLoading = false;
  bool isLoadMore = true;
  List<RequestDetailModel> listRequest = [];
  ListRequestLogic listRequestLogic;
  final ScrollController _scrollController = ScrollController();
  SaleLogic saleLogic = Get.find();
  static const int PAGE_NUM = 10;
  int page = 0;
  Function callbackTotalRequest;

  ListRequestTabState(
      this.status, this.listRequestLogic, this.callbackTotalRequest);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listRequestLogic.searchRequest.fromDate = saleLogic.fromDate;
    listRequestLogic.searchRequest.toDate = saleLogic.toDate;
    getListRequest(listRequestLogic.keySearch);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (isLoadMore) {
          if (kDebugMode) {
            print("load more list request");
          }
          getLoadMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingCirculApi()
        : listRequest.isEmpty
            ? InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Center(
                  child: Text(AppLocalizations.of(context)!.textNoData),
                ),
                onTap: () {
                  // Get.toNamed(RouteConfig.requestDetail);
                },
              )
            : RefreshIndicator(
                onRefresh: _onRefresh,
                color: AppColors.colorBackground,
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    // itemExtent: 999,
                    itemCount: listRequest.length % 10 == 0
                        ? listRequest.length + 1
                        : listRequest.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == listRequest.length) {
                        return const CupertinoActivityIndicator();
                      }
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
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
                    }));
  }

  void getListRequest(String key, {int page = 0}) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    this.page = page;
    if (page == 0) {
      isLoadMore = true;
      setState(() {
        isLoading = true;
      });
    }

    Future.delayed(const Duration(seconds: 1));
    Map<String, dynamic> params = {
      "service": key.isEmpty ? listRequestLogic.searchRequest.service : "",
      "code": key.isEmpty ? listRequestLogic.searchRequest.code : "",
      "actionCode":
          key.isEmpty ? listRequestLogic.searchRequest.actionCode : "",
      "status": status,
      "province": key.isEmpty ? listRequestLogic.searchRequest.province : "",
      "staffCode": key.isEmpty ? listRequestLogic.searchRequest.staffCode : "",
      "fromDate": key.isEmpty
          ? listRequestLogic.searchRequest.fromDate.substring(0, 10)
          : "",
      "toDate": key.isEmpty
          ? listRequestLogic.searchRequest.toDate.substring(0, 10)
          : "",
      "key": key,
      "page": "$page",
      "pageSize": "$PAGE_NUM",
      "sort": "createdDate",
      "version": Common.getVersionApp()
    };
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_LIST_REQUEST,
        params: params,
        isCancel: false,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success :");
            if (page == 0) {
              listRequest.clear();
            }
            ListRequestResponse listRequestResponse =
                ListRequestResponse.fromJson(response.data['data']);
            if (listRequestResponse.list.length < 10) {
              isLoadMore = false;
            } else {
              isLoadMore = true;
            }
            setState(() {
              listRequest.addAll(listRequestResponse.list);
            });
            callbackTotalRequest(listRequest.length, listRequestResponse.total);
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
            Common.showMessageError(error: error, context: context);
          } catch (e) {
            print(e.toString());
          }
        });
  }

  void getLoadMore() {
    page++;
    getListRequest(listRequestLogic.keySearch, page: page);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future _onRefresh() async {
    getListRequest(listRequestLogic.keySearch, page: 0);
  }
}
