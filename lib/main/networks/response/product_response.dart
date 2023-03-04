import 'dart:ffi';

import 'package:bitel_ventas/main/networks/model/product_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductResponse {
  int? status;
  String? errorCode;
  String? errorMessage;
  List<ProductModel> list = [];

  ProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    if (json['data'] != null) {
      list = (json['data'] as List)
          .map((postJson) => ProductModel.fromJson(postJson))
          .toList();
    }
  }
}
