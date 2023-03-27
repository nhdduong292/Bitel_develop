import 'dart:async';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class DialogSurveyMapLogic extends GetxController {
  BuildContext context;

  String currentTechnology = "GPON";
  List<String> listTechnology = ["AON", "GPON"];
  String currentRadius = "500";
  double lat = 0;
  double long = 0;
  RequestDetailModel requestModel;
  bool isConnect = false;
  TextEditingController textFieldRadius = TextEditingController();

  Completer<GoogleMapController> controllerMap =
      Completer<GoogleMapController>();
  CameraPosition kGooglePlex = CameraPosition(
    // target: LatLng(-12.786389, -74.975555),
    target: LatLng(-12.060391, -77.099104),
    zoom: 14.4746,
  );
  bool isLocation = true;

  //Circle
  Set<Circle> circles = Set<Circle>();
  var radiusValue = 500.0;

//Markers set
  Set<Marker> markers = Set<Marker>();
  var currentPoint;

  bool isActive = true;
  Timer? _debounce;

  DialogSurveyMapLogic({required this.context, required this.requestModel});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    textFieldRadius.text = currentRadius;
    // _getCurrentLocation().then((value) {
    //   lat = value.latitude;
    //   long = value.longitude;
    //   currentPoint = LatLng(lat, long);
    //   print("lat: $lat long: $long");
    //   setCircle(currentPoint);
    // });

    _getCurrentLocation().then(
      (value) {
        getLocationAddress();
      },
    );
  }

  void setMarker(LatLng point) {
    Marker marker = Marker(
        markerId: MarkerId('marker_1'),
        position: point,
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker);
    markers.add(marker);
  }

  void setCircle(LatLng point) async {
    currentPoint = point;
    lat = point.latitude;
    long = point.longitude;
    setMarker(point);
    GoogleMapController controller = await controllerMap.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: 14.4746)));
    circles.add(Circle(
        circleId: CircleId('raj'),
        center: point,
        fillColor: Colors.blue.withOpacity(0.1),
        radius: radiusValue,
        strokeColor: Colors.blue,
        strokeWidth: 1));
    isActive = false;
    update();
  }

  void setTechnology(String value) {
    currentTechnology = value;
    update();
  }

  void setRadius(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      try {
        currentRadius = value;
        radiusValue = double.parse(currentRadius);
        if (radiusValue < 1) {
          return;
        }
        setCircle(currentPoint);
      } catch (e) {
        print(e.toString());
      }
    });
  }

  Future<Position> _getCurrentLocation() async {
    // bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    // if(!serviceEnable){
    //   return Future.error("Location disable");
    // }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location deniedForever");
    }
    return await Geolocator.getCurrentPosition();
  }

  bool checkValidate(BuildContext context) {
    int radius = int.parse(currentRadius);
    if (currentTechnology == "GPON" && (radius > 500 || radius < 1)) {
      // setRadius("500");
      Common.showToastCenter(AppLocalizations.of(context)!.textRadiusLimit);
      return true;
    }
    if (currentTechnology == "AON" && (radius > 500 || radius < 1)) {
      // setRadius("300");
      Common.showToastCenter(AppLocalizations.of(context)!.textRadiusLimit);
      return true;
    }
    return false;
  }

  void createSurvey(Function(bool isSuccess) function) async {
    Future.delayed(Duration(seconds: 2));
    Map<String, dynamic> body = {
      "requestId": requestModel.id,
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
          Get.back();
          if (response.isSuccess) {
            print("success");
            function.call(true);
          } else {
            print("error: ${response.status}");
            function.call(false);
          }
        },
        onError: (error) {
          Get.back();
          function.call(false);
          Common.showMessageError(error, context);
        });
  }

  void setStateConnect(bool value) {
    isConnect = value;
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getLocationAddress() async {
    try {
      List<Location> locations = await locationFromAddress(
          requestModel.getInstalAddress(),
          localeIdentifier: "es_PE");
      // List<Location> locations = await locationFromAddress("Nguy Như Kon Tum Thanh Xuân Hà Nội", localeIdentifier: "vi_VN");
      locations.forEach((element) {
        print(
            "addddddddddddddddd lat: ${element.latitude} long: ${element.longitude}");
      });
      if (locations.isNotEmpty) {
        lat = locations[0].latitude;
        long = locations[0].longitude;
        currentPoint = LatLng(lat, long);
        print("lat: $lat long: $long");
        setCircle(currentPoint);
      }
    } catch (e) {
      Common.showToastCenter(e.toString());
    }
  }
}
