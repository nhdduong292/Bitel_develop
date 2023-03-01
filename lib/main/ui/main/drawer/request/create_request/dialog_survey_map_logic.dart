import 'dart:async';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class DialogSurveyMapLogic extends GetxController{
  String currentTechnology = "";
  List<String> listTechnology = ["AON","GPON"];
  String currentRadius = "";
  double lat = 0;
  double long = 0;
  String requestId;

  final Completer<GoogleMapController> controllerMap = Completer<GoogleMapController>();
  late CameraPosition kGooglePlex;
  bool isLocation = false;
  //Circle
  Set<Circle> circles = Set<Circle>();
  var radiusValue = 500.0;
//Markers set
  Set<Marker> markers = Set<Marker>();


  DialogSurveyMapLogic({required this.requestId});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _getCurrentLocation().then((value) {
      lat = value.latitude;
      long = value.longitude;
      print("lat: $lat long: $long");
      kGooglePlex = CameraPosition(
        target: LatLng(lat, long),
        zoom: 14.4746,
      );
      circles.add(Circle(
          circleId: CircleId('raj'),
          center: LatLng(lat, long),
          fillColor: Colors.blue.withOpacity(0.1),
          radius: radiusValue,
          strokeColor: Colors.blue,
          strokeWidth: 1));

      Marker marker = Marker(
          markerId: MarkerId('marker_1'),
          position: LatLng(lat, long),
          onTap: () {},
          icon: BitmapDescriptor.defaultMarker);
      markers.add(marker);
      isLocation = true;
      update();
    });
  }
  void setTechnology(String value){
    currentTechnology = value;
    update();
  }

  void setRadius(String value){
    currentRadius = value;
    update();
  }

  Future<Position> _getCurrentLocation() async{
    // bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    // if(!serviceEnable){
    //   return Future.error("Location disable");
    // }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Location denied");
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error("Location deniedForever");
    }
    return await Geolocator.getCurrentPosition();
  }

  void createSurvey(Function(bool isSuccess) function) async{
    if(currentRadius.isEmpty || currentTechnology.isEmpty){
      Get.snackbar("Vui lòng nhập đầy đủ thông tin!","", snackPosition: SnackPosition.BOTTOM);
      return;
    }
    Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> body = {
      "requestId": requestId,
      "lat": "$lat",
      "lng": "$long",
      "type": currentTechnology,
      "radius": currentRadius
    };
    print("post");
    ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_SURVEY,
        body: body,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            function.call(true);
          } else {
            print("error: ${response.status}");
            function.call(false);
          }
        },
        onError: (error) {
          print("error: " + error.toString());
          function.call(false);
        });
  }


}