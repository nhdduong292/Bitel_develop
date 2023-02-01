import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportLogic extends GetxController with SingleGetTickerProviderMixin{
  TabController? tabController;
  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(vsync: this, length: 3);
    super.onInit();

  }
}