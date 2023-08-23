import 'dart:ffi';

class CheckInModel {
  String? _lat;
  String? _lng;
  int? _radius;
  bool? _isCheckin;

  CheckInModel();
  CheckInModel.fromJson(Map<String, dynamic> json) {
    _lat = json['lat'];
    _lng = json['lng'];
    _radius = json['radius'];
    _isCheckin = json['isCheckin'];
  }

  String get lat => _lat ?? "0";

  String get lng => _lng ?? "0";

  int get radius => _radius ?? 0;

  bool get isCheckin => _isCheckin ?? false;

  set isCheckin(bool value) {
    _isCheckin = value;
  }
}
