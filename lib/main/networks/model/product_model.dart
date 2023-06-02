import 'package:get/get.dart';

class ProductModel {
  int? productId;
  int? offerId;
  String? productCode;
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
    offerId = json['offerId'];
    productCode = json['productCode'];
  }

  double get productValue {
    double value;
    try {
      value = double.parse(defaultValue ?? '');
      return value;
    } catch (e) {
      return 0.0;
    }
  }
}
