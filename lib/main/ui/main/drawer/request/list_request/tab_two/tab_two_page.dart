import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_tab_item.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/tab_one/list_request_tab_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/tab_two/tab_two_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabTwoPage extends GetWidget{
  String status;

  TabTwoPage(this.status);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder(
      init: TabTwoLogic(status, context),
      builder: (controller) {
        return  controller.isLoading ? LoadingCirculApi() : controller.listRequest.isEmpty ? InkWell(
          child: Center(
            child: Text("No data"),
          ),
          onTap: () {
            // Get.toNamed(RouteConfig.requestDetail);
          },
        ) : ListView.builder(
            itemCount: controller.listRequest.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  List<String> listArgument = ["${controller.listRequest[index].id}",status];
                  Get.toNamed(RouteConfig.requestDetail, arguments: listArgument);
                },
                // child: ListRequestTabItem(controller.listRequest[index]),
                child: Container(),
              );
            });
      },);
  }
}