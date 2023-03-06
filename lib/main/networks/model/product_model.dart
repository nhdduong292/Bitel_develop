import 'package:get/get.dart';

class ProductModel {
  int? productId;
  String? productName;
  String? offerName;
  String? defaultValue;
  String? speed;

  ProductModel();

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    offerName = json['offerName'];
    defaultValue = json['defaultValue'];
    speed = json['speed'];
  }
}
