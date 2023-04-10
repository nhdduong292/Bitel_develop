import 'package:bitel_ventas/main/networks/model/buy_anypay_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateOrderLogic extends GetxController
    with SingleGetTickerProviderMixin {
  BuildContext context;
  var isTabOne = true.obs;
  var isTabTwo = false.obs;
  var isTabThree = false.obs;
  TabController? tabController;
  int index = 0;

  BuyAnyPayModel buyAnyPayModel = BuyAnyPayModel();

  String email = '';

  CreateOrderLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(vsync: this, length: 3);
    super.onInit();

    tabController!.addListener(
      () {},
    );
  }

  void nextPage(int value) {
    index = value;
    tabController!
        .animateTo(index, duration: const Duration(milliseconds: 500));
    update();
  }
}
