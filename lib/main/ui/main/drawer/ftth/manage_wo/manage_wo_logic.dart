import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ManageWOLogic extends GetxController with GetSingleTickerProviderStateMixin{
  TabController? tabController;
  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(vsync: this, length: 2);
    super.onInit();

  }
  var WOType = RxnString();
  var allWOType = 'All WO type'.obs;
  List<String> listWOType = ['All WO type', 'Survey offline', 'Deployment'];
  List<WorkOrder> assignedWOList = [
    WorkOrder(
        type: 'Survey',
        line: '11_a_line_ricardosun1',
        address: 'Av, xd, Independencia, Lima',
        isStarted: false,
        deadline: '13/01/2023 08:31:12'),
    WorkOrder(
        type: 'Deployment',
        line: '11_a_line_ricardosun1',
        address: 'Av, xd, Independencia, Lima',
        isStarted: true,
        deadline: '13/01/2023 08:31:12')
  ];
  List<WorkOrder> notAssignWOList = [
    WorkOrder(
        type: 'Deployment',
        line: '11_a_line_ricardosun1',
        address: 'Av, xd, Independencia, Lima',
        isStarted: true,
        deadline: '13/01/2023 08:31:12'),
    WorkOrder(
        type: 'Survey',
        line: '11_a_line_ricardosun1',
        address: 'Av, xd, Independencia, Lima',
        isStarted: false,
        deadline: '13/01/2023 08:31:12')
  ];

  var serviceItem = "All service".obs;
  List<String> serviceItems = ['All service', 'FTTH', 'Office Wan', 'Leased Line'];
  RxList<String> chosenServiceItems = [''].obs;
  var chosenServiceString = 'All service'.obs;
}

class WorkOrder {
  String type;
  String line;
  String address;
  bool isStarted;
  String deadline;

  WorkOrder({
    required this.type,
    required this.line,
    required this.address,
    required this.isStarted,
    required this.deadline,
  });
}