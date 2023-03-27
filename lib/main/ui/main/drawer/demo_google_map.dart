import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'request/create_request/dialog_survey_map_logic.dart';

class DemoGoogleMap extends GetWidget{
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: DialogSurveyMapLogic(
            context: context, requestModel: RequestDetailModel()),
        builder: (controller) {
          return !controller.isLocation
              ? Container()
              : GoogleMap(
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController control) {
              controller.controllerMap.complete(control);
            },
            initialCameraPosition: controller.kGooglePlex,
            circles: controller.circles,
            markers: controller.markers,
            onTap: (argument) {
              controller.setCircle(argument);
            },
          );
        }
    );
  }
}