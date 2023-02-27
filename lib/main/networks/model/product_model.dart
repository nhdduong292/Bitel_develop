import 'package:get/get.dart';

class ProductModel{
  String? name;
  String? desc;
  String? speed;
  String? price;
  var isSelected = false.obs;

  ProductModel({
    this.name,
    this.desc,
    this.speed,
    this.price,
  });
}