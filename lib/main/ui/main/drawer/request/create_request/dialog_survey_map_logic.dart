import 'dart:async';
import 'dart:math';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/check_in_model.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../../services/connection_service.dart';
import '../../../../../utils/common_widgets.dart';

class DialogSurveyMapLogic extends GetxController {
  BuildContext context;

  String currentTechnology = "GPON";
  List<String> listTechnology = ["AON", "GPON"];
  String currentRadius = "300";
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
  bool isSuccessGetLocation = true;
  bool isTimekeeping = false;
  CheckInModel checkInModel = CheckInModel();

  DialogSurveyMapLogic(
      {required this.context,
      required this.requestModel,
      required this.isTimekeeping});

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
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if (isTimekeeping) {
      getLocationCheckIn((isSuccess) {
        getCurrentLocation();
      });
    } else {
      _onLoading(context);
      _getCurrentLocation().then(
        (value) {
          getLocationAddress(false);
          // Get.back();
        },
      );
    }
  }

  void getCurrentLocation() {
    _onLoading(context);
    _getCurrentLocation().then(
      (value) {
        lat = value.latitude;
        long = value.longitude;

        currentPoint = LatLng(lat, long);
        if (isTimekeeping) {
          setCircles(currentPoint);
        } else {
          setCircleFirst(currentPoint);
        }
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
    List<Placemark> placemarks =
        await placemarkFromCoordinates(lat, long, localeIdentifier: "en_US");
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

  void setCircleFirst(LatLng point) async {
    currentPoint = point;
    lat = point.latitude;
    long = point.longitude;

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(lat, long, localeIdentifier: "en_US");
      markers.add(Marker(
          markerId: MarkerId('marker_1'),
          position: point,
          onTap: () {},
          icon: BitmapDescriptor.defaultMarker));
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
      Get.back();
    } catch (e) {
      if (kDebugMode) {
        Common.showToastCenter(e.toString(), context);
      }
    }
  }

  void setCircles(LatLng point) async {
    currentPoint = point;
    lat = point.latitude;
    long = point.longitude;

    var locationCheckIn =
        LatLng(double.parse(checkInModel.lat), double.parse(checkInModel.lng));

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(lat, long, localeIdentifier: "en_US");
      markers.add(Marker(
          markerId: MarkerId('marker_1'),
          position: locationCheckIn,
          onTap: () {},
          icon: BitmapDescriptor.defaultMarker));
      markers.add(Marker(
          markerId: MarkerId('marker_2'),
          position: point,
          onTap: () {},
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure)));
      setMarker(locationCheckIn);
      GoogleMapController controller = await controllerMap.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: locationCheckIn, zoom: 14.4746)));
      circles.add(Circle(
          circleId: CircleId('raj'),
          center: locationCheckIn,
          fillColor: Colors.blue.withOpacity(0.1),
          radius: checkInModel.radius.toDouble(),
          strokeColor: Colors.blue,
          strokeWidth: 1));
      isActive = false;
      update();
      Get.back();
    } catch (e) {
      if (kDebugMode) {
        Common.showToastCenter(e.toString(), context);
      }
    }
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
    int radius = 0;
    try {
      radius = int.parse(currentRadius);
    } catch (e) {}
    if (currentTechnology == "GPON" && (radius > 300 || radius < 1)) {
      // setRadius("500");
      Common.showToastCenter(
          AppLocalizations.of(context)!.textRadiusLimit, context);
      return true;
    }
    if (currentTechnology == "AON" && (radius > 300 || radius < 1)) {
      // setRadius("300");
      Common.showToastCenter(
          AppLocalizations.of(context)!.textRadiusLimit, context);
      return true;
    }
    return false;
  }

  void createSurvey(Function(bool isSuccess) function) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
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
          Common.showMessageError(
              error: error, context: context, isShow: false);
        });
  }

  void createSurveyTransfer(Function(bool isSuccess) function) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    Future.delayed(Duration(seconds: 2));
    Map<String, dynamic> body = {
      "requestId": requestModel.id,
      "lat": "$lat",
      "lng": "$long",
      "type": currentTechnology,
      "radius": currentRadius,
      "address": "string"
    };

    print("post");
    ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_SURVEY_TRANSFER,
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
          Common.showMessageError(
              error: error, context: context, isShow: false);
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

  void getLocationAddress(bool isReload) async {
    try {
      if (isReload) {
        _onLoading(context);
      }

      print(requestModel.getInstalAddress());
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
        setCircleFirst(currentPoint);
        isSuccessGetLocation = true;
        update();
      } else {
        Get.back();
        isSuccessGetLocation = false;
        update();
      }
    } catch (e) {
      Get.back();
      isSuccessGetLocation = false;
      update();
      Common.showToastCenter(e.toString(), context);
    }
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: LoadingCirculApi(),
        );
      },
    );
  }

  void getLocationCheckIn(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_GET_LOCATION_CHECK_IN,
      onSuccess: (response) {
        Get.back();
        checkInModel = CheckInModel.fromJson(response.data['data']);
        update();
        onSuccess(true);
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void checkIn(LatLng point, var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_GET_LOCATION_CHECK_IN,
      body: {
        "lat": point.latitude,
        "lng": point.longitude,
        "radius": checkInModel.radius,
        "isCheckin": true
      },
      onSuccess: (response) {
        Get.back();
        onSuccess(true);
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void checkOut(LatLng point, var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_GET_LOCATION_CHECK_IN,
      body: {
        "lat": point.latitude,
        "lng": point.longitude,
        "radius": checkInModel.radius,
        "isCheckin": false
      },
      onSuccess: (response) {
        Get.back();
        onSuccess(true);
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }
}
