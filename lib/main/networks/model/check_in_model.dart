import 'dart:ffi';

class CheckInModel {
  String? _lat;
  String? _lng;
  int? _radius;
  bool? isCheckin;

  CheckInModel();
  CheckInModel.fromJson(Map<String, dynamic> json) {
    _lat = json['lat'];
    _lng = json['lng'];
    _radius = json['radius'];
    isCheckin = json['isCheckin'];
  }

  String get lat => _lat ?? "0";

  String get lng => _lng ?? "0";

  int get radius => _radius ?? 0;
}
