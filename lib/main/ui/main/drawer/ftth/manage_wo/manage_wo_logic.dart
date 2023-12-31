import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageWOLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }

  List<WorkOrder> assignedWOList = [
    WorkOrder(
        type: 'Survey',
        line: '11_a_line_ricardosun1',
        address: 'Av, xd, Independencia, Lima',
        isStarted: false,
        customerName: 'name1',
        assigned: true,
        phoneNumber: '123456',
        deadline: '13/01/2023 08:31:12'),
    WorkOrder(
        type: 'Deployment',
        account: '11_a_line_ricardosun1',
        address: 'Av, xd, Independencia, Lima',
        isStarted: true,
        customerName: 'name2',
        assigned: true,
        phoneNumber: '123456',
        deadline: '13/01/2023 08:31:12')
  ];
  List<WorkOrder> notAssignWOList = [
    WorkOrder(
      type: 'Deployment',
      account: '11_a_line_ricardosun1',
      address: 'Av, xd, Independencia, Lima',
      isStarted: true,
      customerName: 'name3',
      assigned: false,
      phoneNumber: '123456',
      deadline: '13/01/2023 08:31:12',
    ),
    WorkOrder(
        type: 'Survey',
        line: '11_a_line_ricardosun1',
        address: 'Av, xd, Independencia, Lima',
        isStarted: false,
        customerName: 'name4',
        assigned: false,
        phoneNumber: '123456',
        deadline: '13/01/2023 08:31:12')
  ];

  List<String> serviceItems = ['FTTH', 'Office Wan', 'Leased Line'];
  var chosenServiceItems = RxList<String>();
  var WOType = RxnString();
  List<String> listWOTypes = ['Survey offline', 'Deployment'];
  var chosenWOTypes = RxList<String>();
  List<String> listTeams = ['team1', 'team2'];
  var chosenTeams = RxList<String>();
  List<String> listTechnician = ['tech1', 'tech2'];
  var chosenTechnician = RxList<String>();
  List<String> listStatus = [
    'Not started',
    'In progress',
    'Complete',
    'Pending',
    'Cancel'
  ];
  var chosenStatus = RxList<String>();

  var fromDate = "".obs;
  var toDate = "".obs;
  DateTime selectDate = DateTime.now();

  void setToDate(DateTime picked) {
    toDate.value = "${picked.day}/${picked.month}/${picked.year}";
    update();
  }

  void setFromDate(DateTime picked) {
    fromDate.value = "${picked.day}/${picked.month}/${picked.year}";
    update();
  }
}

class WorkOrder {
  String type;
  String line;
  String address;
  bool isStarted;
  String deadline;
  String customerName;
  String phoneNumber;
  String account;
  bool assigned;

  WorkOrder({
    required this.type,
    this.line = '',
    required this.address,
    required this.isStarted,
    required this.deadline,
    required this.customerName,
    required this.phoneNumber,
    this.account = '',
    required this.assigned
  });
}
