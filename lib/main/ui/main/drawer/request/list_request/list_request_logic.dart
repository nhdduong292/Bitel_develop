import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListRequestLogic extends GetxController with SingleGetTickerProviderMixin{
  TabController? tabController;
  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(vsync: this, length: 6);
    super.onInit();

  }
}