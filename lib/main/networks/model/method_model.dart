import 'package:get/get.dart';

class MethodModel {
  String? name;
  int? freeInstallation;
  String? reasonCodeName;
  String? price;
  RxBool isSelected = false.obs;

  MethodModel({
    this.name,
    this.freeInstallation,
    this.reasonCodeName,
    this.price,
  });
}