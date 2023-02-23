import 'package:bitel_ventas/main/ui/main/drawer/contracting/product_payment_method_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPaymentMethodPage extends GetView<ProductPaymentMethodLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: ProductPaymentMethodLogic(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
          );
        });
  }

}