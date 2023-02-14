import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_tab_item.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_tab_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListRequestTabPage extends GetWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder(
      init: ListRequestTabLogic(),
      builder: (controller) {
      return  controller.listRequest.isEmpty ? InkWell(
        child: Center(
          child: Text("No data"),
        ),
        onTap: () {
          Get.toNamed(RouteConfig.requestDetail);
        },
      ) : ListView.builder(
          itemCount: controller.listRequest.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.toNamed(RouteConfig.requestDetail);
              },
              child: ListRequestTabItem(controller.listRequest[index]),
            );
          });
    },);
  }
}